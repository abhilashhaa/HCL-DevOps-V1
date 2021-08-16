  METHOD if_ngc_bil_chr_transactional~check_before_save.

    DATA:
      lv_language_prev TYPE spras.


*--------------------------------------------------------------------*
* Check if description exists for each characteristic
*--------------------------------------------------------------------*

    LOOP AT mt_charc_create_data ASSIGNING FIELD-SYMBOL(<ls_charc_create_data>).
      CLEAR: lv_language_prev.

      IF lines( <ls_charc_create_data>-charcdesc ) = 0.
        " Define a description for characteristic &1
        MESSAGE e003(ngc_rap) WITH <ls_charc_create_data>-charc-charact_name INTO DATA(lv_message).
        me->add_charc_message(
          EXPORTING
            iv_charcinternalid = <ls_charc_create_data>-charc-charcinternalid
            iv_cid             = ''
            iv_set_failed      = abap_true
          CHANGING
            ct_reported        = et_charc_reported
            ct_failed          = et_charc_failed ).

        CONTINUE.
      ENDIF.

      SORT <ls_charc_create_data>-charcdesc BY language_int.
      LOOP AT <ls_charc_create_data>-charcdesc ASSIGNING FIELD-SYMBOL(<ls_charc_desc_create>).
        IF <ls_charc_desc_create>-language_int = lv_language_prev.
          " Only one description per language is allowed
          MESSAGE e032(ngc_rap) INTO lv_message.
          me->add_charc_desc_message(
            EXPORTING
              iv_charcinternalid = <ls_charc_create_data>-charc-charcinternalid
              iv_cid             = ''
              iv_language        = <ls_charc_desc_create>-language_int
              iv_set_failed      = abap_true
            CHANGING
              ct_reported        = et_charc_desc_reported
              ct_failed          = et_charc_desc_failed ).

          CONTINUE.
        ENDIF.

        lv_language_prev = <ls_charc_desc_create>-language_int.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.