  METHOD zif_abapgit_object~is_active.

    DATA lv_changedate TYPE vcldir-changedate.

    SELECT SINGLE changedate INTO lv_changedate FROM vcldir
      WHERE vclname = ms_item-obj_name.

* see logic in function module VIEWCLUSTER_GET_DEFINITION
    rv_active = boolc( lv_changedate IS NOT INITIAL ).

  ENDMETHOD.