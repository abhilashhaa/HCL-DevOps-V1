  METHOD zif_abapgit_object~is_active.

    DATA: lv_dsona TYPE c LENGTH 30,
          lo_odso  TYPE REF TO object,
          lv_isact TYPE abap_bool.

    lv_dsona = ms_item-obj_name.

    CALL METHOD ('CL_RSD_ODSO')=>('FACTORY')
      EXPORTING
        i_odsobject = lv_dsona
      RECEIVING
        r_r_odso    = lo_odso.

    CALL METHOD lo_odso->('IS_ACTIVE')
      RECEIVING
        r_is_active = lv_isact.

    rv_active = lv_isact.

  ENDMETHOD.