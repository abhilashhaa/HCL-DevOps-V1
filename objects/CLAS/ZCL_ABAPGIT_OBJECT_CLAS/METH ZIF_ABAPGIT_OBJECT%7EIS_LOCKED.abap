  METHOD zif_abapgit_object~is_locked.

    IF is_class_locked( ) = abap_true OR is_text_locked( mv_classpool_name ) = abap_true.
      rv_is_locked = abap_true.
    ENDIF.

  ENDMETHOD.