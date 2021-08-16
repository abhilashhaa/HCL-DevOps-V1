  METHOD check_catalog_value.

    DATA:
      BEGIN OF ls_value_trans,
        codegruppe TYPE qcodegrp,
        fillr(1)   TYPE c VALUE space,
        code       TYPE qcode,
      END OF ls_value_trans.

    DATA:
      lv_code       TYPE qcode,
      lv_code_group TYPE qcodegrp,
      lv_qpk1ac     TYPE qpk1ac.

    DATA(lv_charcvalue) = iv_charcvalue.

    CONDENSE lv_charcvalue.
    SPLIT lv_charcvalue AT ' ' INTO lv_code_group lv_code.

    TRY.
        TEST-SEAM fm_code_pickup.
          CALL FUNCTION 'QPK1_SL_CODE_PICKUP'
            EXPORTING
              i_katalogart      = iv_catalog
              i_werks           = iv_plant
              i_auswahlmge      = iv_selection_set
              i_codegruppe      = lv_code_group
              i_code            = lv_code
              i_sprache         = iv_language
            IMPORTING
              e_qpk1ac          = lv_qpk1ac
            EXCEPTIONS
              no_match_in_range = 1
              no_user_selection = 2
              OTHERS            = 3.
        END-TEST-SEAM.
        IF sy-subrc <> 0.
          RAISE value_not_found.
        ENDIF.

      CATCH cx_sy_dyn_call_illegal_func.
        RAISE value_not_found.
    ENDTRY.


    MOVE-CORRESPONDING lv_qpk1ac TO ls_value_trans.
    ev_new_charcvalue = ls_value_trans.

  ENDMETHOD.