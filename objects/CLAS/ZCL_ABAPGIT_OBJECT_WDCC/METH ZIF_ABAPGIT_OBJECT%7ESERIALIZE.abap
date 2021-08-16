  METHOD zif_abapgit_object~serialize.

    DATA: lv_xml_xstring TYPE xstring,
          lt_otr_texts   TYPE TABLE OF wdy_config_compt,
          lt_cc_text     TYPE TABLE OF wdy_config_datt,
          ls_orig_config TYPE wdy_config_data,
          ls_outline     TYPE wdy_cfg_outline_data,
          ls_config_key  TYPE wdy_config_key,
          lv_xml_string  TYPE string.

    FIELD-SYMBOLS: <lv_data> TYPE any.

    io_xml->add( iv_name = 'OBJECT_NAME'
                 ig_data =  ms_item-obj_name ).

    ls_config_key-config_id = ms_item-obj_name+0(32).
    ls_config_key-config_type = '00'.

    TRY.
        " original_config_data does not exist in 702
        CALL METHOD cl_wdr_cfg_persistence_utils=>('READ_COMP_CONFIG_FROM_DB')
          EXPORTING
            config_key           = ls_config_key
          IMPORTING
            xml_xcontent         = lv_xml_xstring
            original_config_data = ls_orig_config
            outline_data         = ls_outline.

      CATCH cx_static_check.
        zcx_abapgit_exception=>raise( 'Error Reading Component Config from DB: ' && ms_item-obj_name ).
      CATCH cx_root.
        zcx_abapgit_exception=>raise( 'Object type WDCC not supported for this release' ).
    ENDTRY.

    io_xml->add( iv_name = 'CONFIG_ID'
                 ig_data =  ls_orig_config-config_id ).

    io_xml->add( iv_name = 'CONFIG_TYPE'
                 ig_data =  ls_orig_config-config_type ).

    io_xml->add( iv_name = 'CONFIG_VAR'
                 ig_data =  ls_orig_config-config_var ).

    io_xml->add( iv_name = 'WDA_COMPONENT'
                 ig_data =  ls_orig_config-component ).

    ASSIGN COMPONENT 'CONFIG_IDPAR' OF STRUCTURE ls_orig_config TO <lv_data>.
    IF sy-subrc = 0.
      io_xml->add( iv_name = 'CONFIG_IDPAR'
                   ig_data =  <lv_data> ).
    ENDIF.

    ASSIGN COMPONENT 'CONFIG_TYPEPAR' OF STRUCTURE ls_orig_config TO <lv_data>.
    IF sy-subrc = 0.
      io_xml->add( iv_name = 'CONFIG_TYPEPAR'
                   ig_data =  <lv_data> ).
    ENDIF.

    ASSIGN COMPONENT 'CONFIG_VARPAR' OF STRUCTURE ls_orig_config TO <lv_data>.
    IF sy-subrc = 0.
      io_xml->add( iv_name = 'CONFIG_VARPAR'
                   ig_data =  <lv_data> ).
    ENDIF.

    ASSIGN COMPONENT 'PARENT' OF STRUCTURE ls_orig_config TO <lv_data>.
    IF sy-subrc = 0.
      io_xml->add( iv_name = 'PARENT'
                   ig_data =  <lv_data> ).
    ENDIF.

    io_xml->add( iv_name = 'RELID'
                 ig_data =  ls_orig_config-relid ).

    lv_xml_string = zcl_abapgit_convert=>xstring_to_string_utf8( iv_data = lv_xml_xstring ).
    TRY.
        lv_xml_string = zcl_abapgit_xml_pretty=>print( iv_xml           = lv_xml_string
                                                       iv_ignore_errors = abap_false ).
      CATCH zcx_abapgit_exception.    "
        zcx_abapgit_exception=>raise( 'Error Pretty Printing WDCC XML Content: ' && ms_item-obj_name ).
    ENDTRY.

    REPLACE FIRST OCCURRENCE
      OF REGEX '<\?xml version="1\.0" encoding="[\w-]+"\?>'
      IN lv_xml_string
      WITH '<?xml version="1.0" encoding="utf-8"?>'.
    ASSERT sy-subrc = 0.

    mo_files->add_string( iv_extra  = 'comp_config'
                          iv_ext    = 'xml'
                          iv_string = lv_xml_string ).

    SELECT * FROM wdy_config_compt INTO TABLE lt_otr_texts WHERE config_id   = ls_orig_config-config_id
                                                             AND config_type = ls_orig_config-config_type
                                                             AND config_var  = ls_orig_config-config_var.

    IF lt_otr_texts IS NOT INITIAL.
      io_xml->add( iv_name = 'OTR_TEXT'
                   ig_data = lt_otr_texts ).
    ENDIF.

    SELECT * FROM wdy_config_datt INTO TABLE lt_cc_text WHERE config_id   = ls_orig_config-config_id
                                                          AND config_type = ls_orig_config-config_type
                                                          AND config_var  = ls_orig_config-config_var.
    IF lt_cc_text IS NOT INITIAL.
      io_xml->add( iv_name = 'DESCR_LANG'
                   ig_data = lt_cc_text ).
    ENDIF.

  ENDMETHOD.