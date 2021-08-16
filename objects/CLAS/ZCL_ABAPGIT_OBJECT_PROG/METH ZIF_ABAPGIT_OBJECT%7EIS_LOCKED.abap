  METHOD zif_abapgit_object~is_locked.

    IF is_program_locked( ) = abap_true
        OR is_any_dynpro_locked( ms_item-obj_name ) = abap_true
        OR is_cua_locked( ms_item-obj_name ) = abap_true
        OR is_text_locked( ms_item-obj_name ) = abap_true.

      rv_is_locked = abap_true.

    ENDIF.

  ENDMETHOD.