  METHOD zif_abapgit_object~exists.

    DATA: ls_tadir     TYPE tadir,
          lv_switch_id TYPE sfw_switch_id.


    lv_switch_id = ms_item-obj_name.
    IF cl_sfw_sw=>check_existence( lv_switch_id ) = abap_false.
      RETURN.
    ENDIF.

    SELECT SINGLE * FROM tadir INTO ls_tadir
      WHERE pgmid = 'R3TR'
      AND object = ms_item-obj_type
      AND obj_name = ms_item-obj_name.
    IF ls_tadir IS INITIAL.
      RETURN.
    ENDIF.

    rv_bool = abap_true.
  ENDMETHOD.