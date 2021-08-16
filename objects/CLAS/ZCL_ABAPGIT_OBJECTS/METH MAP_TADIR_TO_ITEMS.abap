  METHOD map_tadir_to_items.

    DATA: ls_item LIKE LINE OF rt_items.
    FIELD-SYMBOLS: <ls_tadir> TYPE zif_abapgit_definitions=>ty_tadir.

    LOOP AT it_tadir ASSIGNING <ls_tadir>.

      ls_item-devclass = <ls_tadir>-devclass.
      ls_item-obj_type = <ls_tadir>-object.
      ls_item-obj_name = <ls_tadir>-obj_name.
      INSERT ls_item INTO TABLE rt_items.

    ENDLOOP.

  ENDMETHOD.