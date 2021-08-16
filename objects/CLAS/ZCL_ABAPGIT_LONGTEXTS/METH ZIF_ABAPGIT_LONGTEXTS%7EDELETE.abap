  METHOD zif_abapgit_longtexts~delete.

    DATA: lt_dokil TYPE zif_abapgit_definitions=>tty_dokil.
    FIELD-SYMBOLS: <ls_dokil> TYPE dokil.

    SELECT * FROM dokil
      INTO TABLE lt_dokil
      WHERE id     = iv_longtext_id
      AND   object = iv_object_name.

    LOOP AT lt_dokil ASSIGNING <ls_dokil>.

      CALL FUNCTION 'DOCU_DEL'
        EXPORTING
          id       = <ls_dokil>-id
          langu    = <ls_dokil>-langu
          object   = <ls_dokil>-object
          typ      = <ls_dokil>-typ
        EXCEPTIONS
          ret_code = 1
          OTHERS   = 2.

      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise_t100( ).
      ENDIF.

    ENDLOOP.

  ENDMETHOD.