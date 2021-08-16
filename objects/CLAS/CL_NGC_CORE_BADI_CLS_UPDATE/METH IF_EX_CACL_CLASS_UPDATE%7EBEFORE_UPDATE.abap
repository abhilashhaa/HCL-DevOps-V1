  METHOD if_ex_cacl_class_update~before_update.

*   Determine new nodes
    LOOP AT it_class_update INTO DATA(ls_class_update).
      IF ls_class_update-chngind = 'I'.
        mo_cls_hier_maint->add_node(
          iv_node  = ls_class_update-clint
          iv_datuv = ls_class_update-vondt
          iv_datub = ls_class_update-bisdt
          iv_klart = ls_class_update-klart ).
      ELSEIF ls_class_update-chngind = 'D'.
        mo_cls_hier_maint->delete_node(
          iv_node  = ls_class_update-clint
          iv_datuv = ls_class_update-vondt ).
      ELSEIF ls_class_update-chngind = 'U' AND iv_new_date IS INITIAL.
        mo_cls_hier_maint->update_node(
          iv_node  = ls_class_update-clint
          iv_datuv = ls_class_update-vondt
          iv_datub = ls_class_update-bisdt ).
      ENDIF.
    ENDLOOP.

    IF it_class_update IS NOT INITIAL.
      mo_cls_hier_maint->update( ).
    ENDIF.
  ENDMETHOD.