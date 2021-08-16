  METHOD if_ngc_rap_chr_bapi_util~read_change_number_valid_from.

    /plmi/cl_ecn_bo=>get_instance(
      IMPORTING
        eo_bo = DATA(lo_ecn_bo)
    ).

    lo_ecn_bo->get_header(
      EXPORTING
        it_change_no = VALUE #( ( change_no = iv_change_no ) )
      IMPORTING
        et_header    = DATA(lt_header)
*       et_message   = DATA(lt_message)
        ev_severity  = DATA(lv_severity)
    ).

    IF lv_severity CA 'EAX'.
      RETURN.
    ENDIF.

    rv_valid_from = lt_header[ change_no = iv_change_no ]-valid_from.

  ENDMETHOD.