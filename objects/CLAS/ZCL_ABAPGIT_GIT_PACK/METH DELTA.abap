  METHOD delta.

    CONSTANTS: lc_1   TYPE x VALUE '01',
               lc_2   TYPE x VALUE '02',
               lc_4   TYPE x VALUE '04',
               lc_8   TYPE x VALUE '08',
               lc_16  TYPE x VALUE '10',
               lc_32  TYPE x VALUE '20',
               lc_64  TYPE x VALUE '40',
               lc_128 TYPE x VALUE '80'.

    DATA: lv_base   TYPE xstring,
          lv_result TYPE xstring,
          lv_offset TYPE i,
          lo_stream TYPE REF TO lcl_stream,
          lv_sha1   TYPE zif_abapgit_definitions=>ty_sha1,
          ls_object LIKE LINE OF ct_objects,
          lv_len    TYPE i,
          lv_tmp    TYPE xstring,
          lv_org    TYPE x.

    FIELD-SYMBOLS: <ls_object> LIKE LINE OF ct_objects.


    CREATE OBJECT lo_stream
      EXPORTING
        iv_data = is_object-data.

* find base
    READ TABLE ct_objects ASSIGNING <ls_object>
      WITH KEY sha COMPONENTS sha1 = is_object-sha1.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Base not found, { is_object-sha1 }| ).
    ELSEIF <ls_object>-type = zif_abapgit_definitions=>c_type-ref_d.
* sanity check
      zcx_abapgit_exception=>raise( |Delta, base eq delta| ).
    ENDIF.

    lv_base = <ls_object>-data.

* skip the 2 headers
    delta_header( lo_stream ).
    delta_header( lo_stream ).

    WHILE xstrlen( lo_stream->get( ) ) > 0.

      lv_org = lo_stream->eat_byte( ).

      IF lv_org BIT-AND lc_128 = lc_128. " MSB = 1

        lv_offset = 0.
        IF lv_org BIT-AND lc_1 = lc_1.
          lv_offset = lo_stream->eat_byte( ).
        ENDIF.
        IF lv_org BIT-AND lc_2 = lc_2.
          lv_offset = lv_offset + lo_stream->eat_byte( ) * 256.
        ENDIF.
        IF lv_org BIT-AND lc_4 = lc_4.
          lv_offset = lv_offset + lo_stream->eat_byte( ) * 65536.
        ENDIF.
        IF lv_org BIT-AND lc_8 = lc_8.
          lv_offset = lv_offset + lo_stream->eat_byte( ) * 16777216. " hmm, overflow?
        ENDIF.

        lv_len = 0.
        IF lv_org BIT-AND lc_16 = lc_16.
          lv_len = lo_stream->eat_byte( ).
        ENDIF.
        IF lv_org BIT-AND lc_32 = lc_32.
          lv_len = lv_len + lo_stream->eat_byte( ) * 256.
        ENDIF.
        IF lv_org BIT-AND lc_64 = lc_64.
          lv_len = lv_len + lo_stream->eat_byte( ) * 65536.
        ENDIF.

        IF lv_len = 0.
          lv_len = 65536.
        ENDIF.

        CONCATENATE lv_result lv_base+lv_offset(lv_len)
          INTO lv_result IN BYTE MODE.
      ELSE. " lv_bitbyte(1) = '0'
* insert from delta
        lv_len = lv_org. " convert to int
        lv_tmp = lo_stream->eat_bytes( lv_len ).
        CONCATENATE lv_result lv_tmp INTO lv_result IN BYTE MODE.
      ENDIF.

    ENDWHILE.

    lv_sha1 = zcl_abapgit_hash=>sha1( iv_type = <ls_object>-type
                                      iv_data = lv_result ).

    CLEAR ls_object.
    ls_object-sha1 = lv_sha1.
    ls_object-type = <ls_object>-type.
    ls_object-data = lv_result.
    ls_object-index = <ls_object>-index. "Retain sort index
    APPEND ls_object TO ct_objects.

  ENDMETHOD.