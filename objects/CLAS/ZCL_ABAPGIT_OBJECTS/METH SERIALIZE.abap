  METHOD serialize.

    DATA: li_obj   TYPE REF TO zif_abapgit_object,
          li_xml   TYPE REF TO zif_abapgit_xml_output,
          lo_files TYPE REF TO zcl_abapgit_objects_files.

    FIELD-SYMBOLS: <ls_file> LIKE LINE OF rs_files_and_item-files.

    rs_files_and_item-item = is_item.

    IF is_supported( rs_files_and_item-item ) = abap_false.
      zcx_abapgit_exception=>raise( |Object type ignored, not supported: {
        rs_files_and_item-item-obj_type }-{
        rs_files_and_item-item-obj_name }| ).
    ENDIF.

    CREATE OBJECT lo_files
      EXPORTING
        is_item = rs_files_and_item-item.

    li_obj = create_object( is_item     = rs_files_and_item-item
                            iv_language = iv_language ).
    li_obj->mo_files = lo_files.
    CREATE OBJECT li_xml TYPE zcl_abapgit_xml_output.

    IF iv_serialize_master_lang_only = abap_true.
      li_xml->i18n_params( iv_serialize_master_lang_only = abap_true ).
    ENDIF.

    li_obj->serialize( li_xml ).
    lo_files->add_xml( ii_xml      = li_xml
                       is_metadata = li_obj->get_metadata( ) ).

    rs_files_and_item-files = lo_files->get_files( ).

    check_duplicates( rs_files_and_item-files ).

    rs_files_and_item-item-inactive = boolc( li_obj->is_active( ) = abap_false ).

    LOOP AT rs_files_and_item-files ASSIGNING <ls_file>.
      <ls_file>-sha1 = zcl_abapgit_hash=>sha1(
        iv_type = zif_abapgit_definitions=>c_type-blob
        iv_data = <ls_file>-data ).
    ENDLOOP.

  ENDMETHOD.