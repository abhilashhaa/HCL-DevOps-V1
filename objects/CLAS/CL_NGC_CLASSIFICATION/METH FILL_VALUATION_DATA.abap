  METHOD fill_valuation_data.

    DATA:
      lv_helper_string TYPE string.

    IF iv_charc_type IS INITIAL.
      RETURN.
    ENDIF.

    cs_valuation_data-clfnobjecttype  = if_ngc_c=>gc_clf_object_class_indicator-object.
    cs_valuation_data-validityenddate = if_ngc_c=>gc_date_max.

    CASE iv_charc_type.
      WHEN if_ngc_c=>gc_charcdatatype-char.
        " in case of character type set the default value dependency to 1 (=EQ)
        cs_valuation_data-charcvaluedependency  = if_ngc_core_c=>gc_chr_charcvaluedependency-eq.

      WHEN if_ngc_c=>gc_charcdatatype-curr.
        cs_valuation_data-charcfromnumericvalue = cs_valuation_data-charcfromamount.
        cs_valuation_data-charctonumericvalue   = cs_valuation_data-charctoamount.

        IF cs_valuation_data-charcvaluedependency CA '67'.
          CLEAR: cs_valuation_data-charcfromamount, cs_valuation_data-charcfromnumericvalue.
        ELSEIF cs_valuation_data-charcvaluedependency CA '189'.
          CLEAR: cs_valuation_data-charctoamount, cs_valuation_data-charctonumericvalue.
        ENDIF.

      WHEN if_ngc_c=>gc_charcdatatype-num.
        cs_valuation_data-charcfromnumericvalue = cs_valuation_data-charcfromdecimalvalue.
        cs_valuation_data-charctonumericvalue   = cs_valuation_data-charctodecimalvalue.

        IF cs_valuation_data-charcvaluedependency CA '67'.
          CLEAR: cs_valuation_data-charcfromdecimalvalue, cs_valuation_data-charcfromnumericvalue.
        ELSEIF cs_valuation_data-charcvaluedependency CA '189'.
          CLEAR: cs_valuation_data-charctodecimalvalue, cs_valuation_data-charctonumericvalue.
        ENDIF.

      WHEN if_ngc_c=>gc_charcdatatype-date.
        lv_helper_string                        = cs_valuation_data-charcfromdate.
        cs_valuation_data-charcfromnumericvalue = lv_helper_string.
        lv_helper_string                        = cs_valuation_data-charctodate.
        cs_valuation_data-charctonumericvalue   = lv_helper_string.

        IF cs_valuation_data-charcvaluedependency CA '67'.
          CLEAR: cs_valuation_data-charcfromdate, cs_valuation_data-charcfromnumericvalue.
        ELSEIF cs_valuation_data-charcvaluedependency CA '189'.
          CLEAR: cs_valuation_data-charctodate, cs_valuation_data-charctonumericvalue.
        ENDIF.

      WHEN if_ngc_c=>gc_charcdatatype-time.
        lv_helper_string                        = cs_valuation_data-charcfromtime.
        cs_valuation_data-charcfromnumericvalue = lv_helper_string.
        lv_helper_string                        = cs_valuation_data-charctotime.
        cs_valuation_data-charctonumericvalue   = lv_helper_string.

        IF cs_valuation_data-charcvaluedependency CA '67'.
          CLEAR: cs_valuation_data-charcfromtime, cs_valuation_data-charcfromnumericvalue.
        ELSEIF cs_valuation_data-charcvaluedependency CA '189'.
          CLEAR: cs_valuation_data-charctotime, cs_valuation_data-charctonumericvalue.
        ENDIF.

    ENDCASE.

  ENDMETHOD.