  METHOD get_url_for_io.

    DATA: ls_io       TYPE skwf_io,
          lv_url      TYPE skwf_url,
          ls_smimloio TYPE smimloio,
          lv_loio     TYPE sdok_docid.


    lv_loio = ms_item-obj_name.

    CLEAR ev_url.
    CLEAR ev_is_folder.

    SELECT SINGLE * FROM smimloio INTO ls_smimloio
      WHERE loio_id = lv_loio.                          "#EC CI_GENBUFF
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_abapgit_not_found.
    ENDIF.

    IF ls_smimloio-lo_class = wbmr_c_skwf_folder_class.
      ev_is_folder = abap_true.
      ls_io-objtype = skwfc_obtype_folder.
    ELSE.
      ls_io-objtype = skwfc_obtype_loio.
    ENDIF.
    ls_io-class = ls_smimloio-lo_class.
    ls_io-objid = ls_smimloio-loio_id.

    CALL FUNCTION 'SKWF_NMSPC_IO_ADDRESS_GET'
      EXPORTING
        io  = ls_io
      IMPORTING
        url = lv_url.

    ev_url = lv_url.

  ENDMETHOD.