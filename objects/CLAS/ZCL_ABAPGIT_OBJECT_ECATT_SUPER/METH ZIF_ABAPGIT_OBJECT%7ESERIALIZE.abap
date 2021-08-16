  METHOD zif_abapgit_object~serialize.

    DATA:
      lt_version_info TYPE etversinfo_tabtype,
      li_document     TYPE REF TO if_ixml_document,
      lx_error        TYPE REF TO cx_ecatt,
      lv_text         TYPE string,
      lv_object_type  TYPE etobj_type.

    lv_object_type = get_object_type( ).

    TRY.
        cl_apl_ecatt_object=>get_version_info_object(
          EXPORTING
            im_name         = mv_object_name
            im_obj_type     = lv_object_type
          IMPORTING
            ex_version_info = lt_version_info ).

        li_document = cl_ixml=>create( )->create_document( ).

        serialize_versions(
          EXPORTING
            it_version_info = lt_version_info
          CHANGING
            ci_document     = li_document ).

        io_xml->set_raw( li_document->get_root_element( ) ).

      CATCH cx_ecatt INTO lx_error.
        lv_text = lx_error->get_text( ).
        MESSAGE lv_text TYPE 'S' DISPLAY LIKE 'E'.
    ENDTRY.

  ENDMETHOD.