  METHOD is_name_permitted.

    " It is unlikely that a serialised data model will have a name that is not permitted. However
    " there may be reservations in TRESE which could prohibit the data model name.
    " So to be safe, we check. Tx SD11 does this check.


    CALL FUNCTION 'SDU_SAA_CHECK'
      EXPORTING
        obj_name   = me->ms_object_type-objname
        obj_type   = me->ms_object_type-objtype
      EXCEPTIONS
        wrong_type = 01.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

  ENDMETHOD.