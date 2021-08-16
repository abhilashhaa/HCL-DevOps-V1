  METHOD encode.

    DATA: lv_sha1          TYPE x LENGTH 20,
          lv_adler32       TYPE zif_abapgit_definitions=>ty_adler32,
          lv_compressed    TYPE xstring,
          lv_xstring       TYPE xstring,
          li_progress      TYPE REF TO zif_abapgit_progress,
          lv_objects_total TYPE i.

    FIELD-SYMBOLS: <ls_object>  LIKE LINE OF it_objects.


    rv_data = c_pack_start.

    CONCATENATE rv_data c_version INTO rv_data IN BYTE MODE.

    lv_xstring = zcl_abapgit_convert=>int_to_xstring4( lines( it_objects ) ).
    CONCATENATE rv_data lv_xstring INTO rv_data IN BYTE MODE.

    lv_objects_total = lines( it_objects ).

    li_progress = zcl_abapgit_progress=>get_instance( lv_objects_total ).

    LOOP AT it_objects ASSIGNING <ls_object>.
      IF sy-tabix MOD 200 = 0.
        li_progress->show(
          iv_current = sy-tabix
          iv_text    = |Encoding objects ( { sy-tabix } of { lv_objects_total } )| ).
      ENDIF.

      lv_xstring = type_and_length(
        iv_type   = <ls_object>-type
        iv_length = xstrlen( <ls_object>-data ) ).
      CONCATENATE rv_data lv_xstring INTO rv_data IN BYTE MODE.

      cl_abap_gzip=>compress_binary(
        EXPORTING
          raw_in   = <ls_object>-data
        IMPORTING
          gzip_out = lv_compressed ).

      CONCATENATE rv_data c_zlib lv_compressed INTO rv_data IN BYTE MODE.

      IF NOT <ls_object>-adler32 IS INITIAL.
        lv_adler32 = <ls_object>-adler32.
      ELSE.
        lv_adler32 = zcl_abapgit_hash=>adler32( <ls_object>-data ).
      ENDIF.
      CONCATENATE rv_data lv_adler32 INTO rv_data IN BYTE MODE.

    ENDLOOP.

    lv_sha1 = to_upper( zcl_abapgit_hash=>sha1_raw( rv_data ) ).
    CONCATENATE rv_data lv_sha1 INTO rv_data IN BYTE MODE.

  ENDMETHOD.