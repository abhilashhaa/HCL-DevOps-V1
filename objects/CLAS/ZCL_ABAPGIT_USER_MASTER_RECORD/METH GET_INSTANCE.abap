  METHOD get_instance.

    DATA: ls_user TYPE ty_user.
    FIELD-SYMBOLS: <ls_user> TYPE ty_user.

    READ TABLE gt_user ASSIGNING <ls_user>
                       WITH KEY user = iv_user.
    IF sy-subrc <> 0.

      ls_user-user = iv_user.
      CREATE OBJECT ls_user-o_user
        EXPORTING
          iv_user = iv_user.

      INSERT ls_user
             INTO TABLE gt_user
             ASSIGNING <ls_user>.

    ENDIF.

    ro_user = <ls_user>-o_user.

  ENDMETHOD.