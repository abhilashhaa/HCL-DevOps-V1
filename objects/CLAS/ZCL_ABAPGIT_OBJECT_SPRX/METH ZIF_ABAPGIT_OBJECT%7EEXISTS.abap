  METHOD zif_abapgit_object~exists.

    DATA:
      lv_status      TYPE prx_status,
      lv_status_text TYPE prx_status_t.

    cl_proxy_data=>db_get_status(
      EXPORTING
        object      = mv_object
        obj_name    = mv_obj_name
      IMPORTING
        status      = lv_status
        status_text = lv_status_text ).

    rv_bool = boolc( lv_status = if_proxy=>c_state_active ).

  ENDMETHOD.