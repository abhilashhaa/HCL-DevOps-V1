  METHOD zif_abapgit_object~deserialize.
* see function module FB_UPLOAD_FORM

    DATA: li_node                TYPE REF TO if_ixml_node,
          lv_formname            TYPE tdsfname,
          lv_name                TYPE string,
          li_iterator            TYPE REF TO if_ixml_node_iterator,
          lo_sf                  TYPE REF TO cl_ssf_fb_smart_form,
          lo_res                 TYPE REF TO cl_ssf_fb_smart_form,
          lx_error               TYPE REF TO cx_ssf_fb,
          lv_text                TYPE string,
          lv_within_code_section TYPE abap_bool.

    CREATE OBJECT lo_sf.

* set "created by" and "changed by" to current user
    li_iterator = io_xml->get_raw( )->get_root_element( )->create_iterator( ).
    li_node = li_iterator->get_next( ).
    WHILE NOT li_node IS INITIAL.
      lv_name = li_node->get_name( ).
      CASE lv_name.
        WHEN 'LASTDATE'.
          li_node->set_value( sy-datum(4) && '-' && sy-datum+4(2) && '-' && sy-datum+6(2) ).
        WHEN 'LASTTIME'.
          li_node->set_value( sy-uzeit(2) && ':' && sy-uzeit+2(2) && ':' && sy-uzeit+4(2) ).
        WHEN 'FIRSTUSER' OR 'LASTUSER'.
          li_node->set_value( sy-uname && '' ).

      ENDCASE.

      handle_attrib_leading_spaces( EXPORTING iv_name                = lv_name
                                              ii_node                = li_node
                                    CHANGING  cv_within_code_section = lv_within_code_section ).

      li_node = li_iterator->get_next( ).
    ENDWHILE.

    tadir_insert( iv_package ).

    lv_formname = ms_item-obj_name.

    TRY.
        lo_sf->enqueue( suppress_corr_check = space
                        master_language     = mv_language
                        mode                = 'INSERT'
                        formname            = lv_formname ).

        lo_sf->xml_upload( EXPORTING dom      = io_xml->get_raw( )->get_root_element( )
                                     formname = lv_formname
                                     language = mv_language
                           CHANGING  sform    = lo_res ).

        lo_res->store( im_formname = lo_res->header-formname
                       im_language = mv_language
                       im_active   = abap_true ).

        lo_sf->dequeue( lv_formname ).

      CATCH cx_ssf_fb INTO lx_error.
        lv_text = lx_error->get_text( ).
        zcx_abapgit_exception=>raise( |{ ms_item-obj_type } { ms_item-obj_name }: { lv_text } | ).
    ENDTRY.

  ENDMETHOD.