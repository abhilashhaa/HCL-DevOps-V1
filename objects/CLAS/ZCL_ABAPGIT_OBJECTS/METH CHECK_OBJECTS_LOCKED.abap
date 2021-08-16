  METHOD check_objects_locked.

    DATA: li_obj TYPE REF TO zif_abapgit_object.

    FIELD-SYMBOLS: <ls_item> LIKE LINE OF it_items.

    LOOP AT it_items ASSIGNING <ls_item>.

      " You should remember that we ignore not supported objects here,
      " because otherwise the process aborts which is not desired
      IF is_supported( <ls_item> ) = abap_false.
        CONTINUE.
      ENDIF.

      li_obj = create_object( is_item     = <ls_item>
                              iv_language = iv_language ).

      IF li_obj->is_locked( ) = abap_true.
        zcx_abapgit_exception=>raise( |Object { <ls_item>-obj_type } { <ls_item>-obj_name } |
                                   && |is locked. Action not possible.| ).
      ENDIF.

    ENDLOOP.

  ENDMETHOD.