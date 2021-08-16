  METHOD add.
    DATA ls_item TYPE ty_item.

    ASSERT iv_typ = zif_abapgit_html=>c_action_type-separator  " sep doesn't have action
      OR iv_typ = zif_abapgit_html=>c_action_type-onclick      " click may have no action (assigned in JS)
      OR iv_typ = zif_abapgit_html=>c_action_type-dummy        " dummy may have no action
      OR iv_act IS INITIAL AND io_sub IS NOT INITIAL
      OR iv_act IS NOT INITIAL AND io_sub IS INITIAL. " Only one supplied

    ASSERT NOT ( iv_chk <> abap_undefined AND io_sub IS NOT INITIAL ).

    ls_item-txt   = iv_txt.
    ls_item-act   = iv_act.
    ls_item-ico   = iv_ico.
    ls_item-sub   = io_sub.
    ls_item-opt   = iv_opt.
    ls_item-typ   = iv_typ.
    ls_item-cur   = iv_cur.
    ls_item-chk   = iv_chk.
    ls_item-aux   = iv_aux.
    ls_item-id    = iv_id.
    ls_item-title = iv_title.

    APPEND ls_item TO mt_items.

    ro_self = me.

  ENDMETHOD.