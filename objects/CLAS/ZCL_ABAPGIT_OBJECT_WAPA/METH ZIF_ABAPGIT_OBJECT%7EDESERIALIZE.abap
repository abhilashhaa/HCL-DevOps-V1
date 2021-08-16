  METHOD zif_abapgit_object~deserialize.

    DATA: lo_bsp            TYPE REF TO cl_o2_api_application,
          ls_attributes     TYPE o2applattr,
          lt_nodes          TYPE o2applnode_table,
          lt_navgraph       TYPE o2applgrap_table,
          lv_obj_name       TYPE string,
          lv_extra          TYPE string,
          lv_ext            TYPE string,
          lo_page           TYPE REF TO cl_o2_api_pages,
          lt_pages_info     TYPE ty_pages_tt,
          ls_pagekey        TYPE o2pagkey,
          ls_local_page     TYPE ty_page,
          lt_remote_content TYPE o2pageline_table,
          lt_local_content  TYPE o2pageline_table,
          lt_local_pages    TYPE o2pagelist.

    FIELD-SYMBOLS: <ls_remote_page> LIKE LINE OF lt_pages_info.

    io_xml->read( EXPORTING iv_name = 'ATTRIBUTES'
                  CHANGING cg_data = ls_attributes ).
    io_xml->read( EXPORTING iv_name = 'NAVGRAPH'
                  CHANGING cg_data = lt_navgraph ).
    io_xml->read( EXPORTING iv_name = 'PAGES'
                  CHANGING cg_data = lt_pages_info ).

    ls_attributes-devclass = iv_package.

    cl_o2_api_application=>load(
      EXPORTING
        p_application_name  = ls_attributes-applname    " Application Name
      IMPORTING
        p_application       = lo_bsp    " Instance Created
      EXCEPTIONS
        object_not_existing = 1
        permission_failure  = 2
        error_occured       = 3
        OTHERS              = 4 ).

    CASE sy-subrc.
      WHEN 0.

        cl_o2_api_pages=>get_all_pages(
          EXPORTING
            p_applname = ls_attributes-applname
            p_version  = c_active
          IMPORTING
            p_pages    = lt_local_pages ).

      WHEN 1.

        lo_bsp = create_new_application( is_attributes = ls_attributes
                                         it_nodes      = lt_nodes
                                         it_navgraph   = lt_navgraph ).

      WHEN OTHERS.

        zcx_abapgit_exception=>raise( |Error { sy-subrc } from CL_O2_API_APPLICATION=>LOAD| ).

    ENDCASE.

    LOOP AT lt_pages_info ASSIGNING <ls_remote_page>.

      ls_pagekey-applname = <ls_remote_page>-attributes-applname.
      ls_pagekey-pagekey = <ls_remote_page>-attributes-pagekey.

      cl_o2_api_pages=>load(
        EXPORTING
          p_pagekey             = ls_pagekey
        IMPORTING
          p_page                = lo_page
        EXCEPTIONS
          object_not_existing   = 1
          version_not_existing  = 2
          OTHERS                = 3 ).

      CASE sy-subrc.
        WHEN 0.

          ls_local_page = read_page( <ls_remote_page>-attributes ).

        WHEN 1.

          lo_page = create_new_page( <ls_remote_page>-attributes ).

        WHEN 2.

          " Do nothing...

        WHEN OTHERS.

          zcx_abapgit_exception=>raise( |Error { sy-subrc } from CL_O2_API_PAGES=>LOAD| ).

      ENDCASE.

      SPLIT <ls_remote_page>-attributes-pagename AT '.' INTO lv_extra lv_ext.
      REPLACE ALL OCCURRENCES OF '/' IN lv_extra WITH '_-'.
      REPLACE ALL OCCURRENCES OF '/' IN lv_ext WITH '_-'.

      lt_remote_content = to_page_content( mo_files->read_raw( iv_extra = lv_extra
                                                               iv_ext   = lv_ext ) ).
      lt_local_content = to_page_content( get_page_content( lo_page ) ).

      IF ls_local_page = <ls_remote_page> AND lt_local_content = lt_remote_content.
        " no changes -> nothing to do
        CONTINUE.
      ENDIF.

      IF <ls_remote_page>-attributes-pagetype <> so2_controller.

        lo_page->set_page( lt_remote_content ).

        lo_page->set_event_handlers( <ls_remote_page>-event_handlers ).
        lo_page->set_parameters( <ls_remote_page>-parameters ).
        lo_page->set_type_source( <ls_remote_page>-types ).

      ENDIF.

      lo_page->save( p_with_all_texts = abap_true ).

      lv_obj_name = cl_wb_object_type=>get_concatenated_key_from_id(
        p_key_component1 = <ls_remote_page>-attributes-applname
        p_key_component2 = <ls_remote_page>-attributes-pagekey
        p_external_id    = 'WG ' ).

      zcl_abapgit_objects_activation=>add( iv_type = 'WAPP'
                                           iv_name = lv_obj_name ).

    ENDLOOP.

    delete_superfluous_pages( it_local_pages  = lt_local_pages
                              it_remote_pages = lt_pages_info ).

    zcl_abapgit_sotr_handler=>create_sotr(
      iv_package = iv_package
      io_xml     = io_xml ).

  ENDMETHOD.