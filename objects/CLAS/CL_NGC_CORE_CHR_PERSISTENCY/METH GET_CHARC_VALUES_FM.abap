METHOD get_charc_values_fm.

*--------------------------------------------------------------------*
* The implementation of this method is based on
* /PLMI/CL_CLF_BO_VALUE --> GET_VALUES_F4_FM
*--------------------------------------------------------------------*

  TYPES:
    BEGIN OF rcgaddinf,
      aennr     TYPE aennr,
      valdat    TYPE datum,
      refexflg  TYPE flag,
      referflg  TYPE flag,
      preobjflg TYPE flag,
      nexobjflg TYPE flag,
      preentflg TYPE flag,
      nexentflg TYPE flag,
      owsrflg   TYPE flag,
    END OF rcgaddinf.

  DATA:
    ls_charc_value TYPE ngcs_core_charc_value,
    lv_fm          TYPE rs38l_fnam,
    lt_value       TYPE TABLE OF rctvalues,
    ls_addinf      TYPE rcgaddinf,
    lv_phrased_ind TYPE boole_d,
    lv_phrase_key  TYPE c LENGTH 21,
    lv_phrase_code TYPE c LENGTH 40.

  CLEAR: et_message.

  LOOP AT it_characteristic ASSIGNING FIELD-SYMBOL(<ls_characteristic>)
    WHERE charccheckfunctionmodule IS NOT INITIAL.

    lv_fm = <ls_characteristic>-charccheckfunctionmodule && if_ngc_core_c=>gc_charc_f4_fm_suffix.

    " check if function module exists
    IF mo_core_util->function_exists( lv_fm ) = abap_false.
      " Function module & does not exist
      " Error message generation should be avoided here because there are some implementations
      " which are interrupted by the error message.
      " Instead of error msg, it will handle this situation like when the FM exists but returns empty result.
*      MESSAGE e007(c1) WITH lv_fm INTO DATA(lv_msg)  ##NEEDED.
*      APPEND VALUE #( charcinternalid = <ls_characteristic>-charcinternalid
*                      key_date        = <ls_characteristic>-key_date
*                      msgty           = sy-msgty
*                      msgid           = sy-msgid
*                      msgno           = sy-msgno
*                      msgv1           = sy-msgv1
*                      msgv2           = sy-msgv2
*                      msgv3           = sy-msgv3
*                      msgv4           = sy-msgv4 ) TO et_message.
      CONTINUE.
    ENDIF.

    " call user function to determine list of valid values
    lt_value = mo_chr_util_funcmod->call_f4_fm(
      iv_function_name   = lv_fm
      iv_characteristic  = <ls_characteristic>-characteristic
      iv_charcinternalid = <ls_characteristic>-charcinternalid ).

    ls_charc_value-charcinternalid = <ls_characteristic>-charcinternalid.
    lv_fm = if_ngc_core_c=>gc_fm_charc_is_phrased.

    " Check if characteristic is phrased or not
    " check if function module exists
    IF mo_core_util->function_exists( if_ngc_core_c=>gc_fm_charc_is_phrased ) = abap_true.
      lv_phrased_ind = mo_chr_util_funcmod->check_charc_is_phrased(
        iv_charcinternalid = <ls_characteristic>-charcinternalid ).
      lv_fm = if_ngc_core_c=>gc_fm_charc_phrase_text_read.
    ENDIF.

    LOOP AT lt_value INTO DATA(ls_value).
      ls_charc_value-charcvalue            = ls_value-value.
      ls_charc_value-charcvaluedescription = ls_value-val_descr.
      ls_charc_value-charcvaluedependency  = if_ngc_core_c=>gc_chr_charcvaluedependency-eq.
      ls_charc_value-key_date              = <ls_characteristic>-key_date.

      IF lv_phrased_ind = abap_true.
        lv_phrase_key = ls_value-value.
        ls_addinf-valdat = sy-datum.
        ls_addinf-aennr = 0.
        mo_chr_util_funcmod->read_phrased_text(
          EXPORTING
            iv_phrase_key    = lv_phrase_key
          IMPORTING
            ev_phrase_code   = lv_phrase_code
          EXCEPTIONS
            phrase_not_found = 1 ).

        IF sy-subrc = 0 AND lv_phrase_code IS NOT INITIAL.
          CONCATENATE lv_phrase_code ls_charc_value-charcvaluedescription
            INTO ls_charc_value-charcvaluedescription SEPARATED BY ': '. "#EC NOTEXT
        ENDIF.
      ENDIF.
      APPEND ls_charc_value TO ct_characteristic_value.
    ENDLOOP.

  ENDLOOP.

ENDMETHOD.