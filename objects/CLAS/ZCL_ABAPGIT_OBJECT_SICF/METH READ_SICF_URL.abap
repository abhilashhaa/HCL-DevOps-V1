  METHOD read_sicf_url.

* note: this method is called dynamically from some places

    DATA: lv_name       TYPE icfservice-icf_name,
          lv_url        TYPE icfurlbuf,
          lv_string     TYPE string,
          lv_icfnodguid TYPE icfservice-icfnodguid,
          lv_parguid    TYPE icfservice-icfparguid.


    lv_name    = iv_obj_name.
    lv_parguid = iv_obj_name+15.

    SELECT SINGLE icfnodguid FROM icfservice INTO lv_icfnodguid
      WHERE icf_name = lv_name
      AND icfparguid = lv_parguid.

    CALL FUNCTION 'HTTP_GET_URL_FROM_NODGUID'
      EXPORTING
        nodguid     = lv_icfnodguid
      IMPORTING
        url         = lv_url
      EXCEPTIONS
        icf_inconst = 1
        OTHERS      = 2.
    IF sy-subrc = 0.
      lv_string = lv_url.
      rv_hash = zcl_abapgit_hash=>sha1_raw( zcl_abapgit_convert=>string_to_xstring_utf8( lv_string ) ).
    ENDIF.

  ENDMETHOD.