  METHOD test_changed_by.

    DATA ls_tadir TYPE zif_abapgit_definitions=>ty_tadir.
    DATA ls_item  TYPE zif_abapgit_definitions=>ty_item.
    DATA lv_user  TYPE xubname.

    ls_tadir = zcl_abapgit_ui_factory=>get_popups( )->popup_object( ).
    IF ls_tadir IS INITIAL.
      RETURN.
    ENDIF.

    ls_item-obj_type = ls_tadir-object.
    ls_item-obj_name = ls_tadir-obj_name.

    lv_user = zcl_abapgit_objects=>changed_by( ls_item ).

    MESSAGE lv_user TYPE 'S'.

  ENDMETHOD.