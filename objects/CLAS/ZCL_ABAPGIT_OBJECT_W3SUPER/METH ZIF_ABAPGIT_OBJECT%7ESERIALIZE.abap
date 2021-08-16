  METHOD zif_abapgit_object~serialize.

    DATA lt_w3mime    TYPE STANDARD TABLE OF w3mime.
    DATA lt_w3html    TYPE STANDARD TABLE OF w3html.
    DATA lt_w3params  TYPE STANDARD TABLE OF wwwparams.
    DATA lv_xstring   TYPE xstring.
    DATA lv_size      TYPE i.

    SELECT SINGLE * INTO CORRESPONDING FIELDS OF ms_key
      FROM wwwdata
      WHERE relid = ms_key-relid
      AND objid = ms_key-objid
      AND srtf2 = 0.

    IF sy-subrc IS NOT INITIAL.
      RETURN.
    ENDIF.

    CALL FUNCTION 'WWWDATA_IMPORT'
      EXPORTING
        key               = ms_key
      TABLES
        mime              = lt_w3mime
        html              = lt_w3html
      EXCEPTIONS
        wrong_object_type = 1
        import_error      = 2.

    IF sy-subrc IS NOT INITIAL.
      zcx_abapgit_exception=>raise( 'Cannot read W3xx data' ).
    ENDIF.

    CALL FUNCTION 'WWWPARAMS_READ_ALL'
      EXPORTING
        type             = ms_key-relid
        objid            = ms_key-objid
      TABLES
        params           = lt_w3params
      EXCEPTIONS
        entry_not_exists = 1.

    IF sy-subrc IS NOT INITIAL.
      zcx_abapgit_exception=>raise( 'Cannot read W3xx data' ).
    ENDIF.

    lv_size = find_param( it_params = lt_w3params
                          iv_name = c_param_names-filesize ).
    " Clean params (remove version, filesize & clear filename from path)
    strip_params( CHANGING  ct_params = lt_w3params ).

    CASE ms_key-relid.
      WHEN 'MI'.
        CALL FUNCTION 'SCMS_BINARY_TO_XSTRING'
          EXPORTING
            input_length = lv_size
          IMPORTING
            buffer       = lv_xstring
          TABLES
            binary_tab   = lt_w3mime
          EXCEPTIONS
            failed       = 1.
      WHEN 'HT'.
        CALL FUNCTION 'SCMS_TEXT_TO_XSTRING'
          IMPORTING
            buffer   = lv_xstring
          TABLES
            text_tab = lt_w3html
          EXCEPTIONS
            failed   = 1.
      WHEN OTHERS.
        zcx_abapgit_exception=>raise( 'Wrong W3xx type' ).
    ENDCASE.

    IF sy-subrc IS NOT INITIAL.
      zcx_abapgit_exception=>raise( 'Cannot convert W3xx to xstring' ).
    ENDIF.

    io_xml->add( iv_name = 'NAME'
                 ig_data = ms_key-objid ).

    io_xml->add( iv_name = 'TEXT'
                 ig_data = ms_key-text ).

    io_xml->add( iv_name = 'PARAMS'
                 ig_data = lt_w3params ).

    " Seriazation v2, separate data file. 'extra' added to prevent conflict with .xml
    zif_abapgit_object~mo_files->add_raw( iv_data  = lv_xstring
                                  iv_extra = 'data'
                                  iv_ext   = get_ext( lt_w3params ) ).

  ENDMETHOD.