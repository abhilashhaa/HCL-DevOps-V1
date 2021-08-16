  METHOD deserialize_version.

    DATA: ls_object   TYPE etmobjects,
          lo_upload   TYPE REF TO cl_apl_ecatt_upload,
          li_upload   TYPE REF TO zif_abapgit_ecatt_upload,
          lv_xml      TYPE xstring,
          lv_text     TYPE string,
          li_document TYPE REF TO if_ixml_document,
          lv_version  TYPE string,
          lx_error    TYPE REF TO cx_ecatt.

    lv_version = get_version_from_node( ii_version_node ).

    IF lv_version IS INITIAL.
      RETURN.
    ENDIF.

    lo_upload  = get_upload( ).
    li_upload ?= lo_upload.

    li_document = cl_ixml=>create( )->create_document( ).
    li_document->append_child( ii_version_node->get_first_child( ) ).

    lv_xml = cl_ixml_80_20=>render_to_xstring( li_document ).

    li_upload->set_stream_for_upload( lv_xml ).

    ls_object-d_obj_name  = mv_object_name.
    ls_object-s_obj_type  = get_object_type( ).
    ls_object-d_devclass  = iv_package.
    ls_object-d_obj_ver   = lv_version.
    ls_object-d_overwrite = abap_true.

    TRY.
        lo_upload->upload( CHANGING ch_object = ls_object ).

      CATCH cx_ecatt INTO lx_error.
        lv_text = lx_error->get_text( ).
        zcx_abapgit_exception=>raise( lv_text ).
    ENDTRY.

  ENDMETHOD.