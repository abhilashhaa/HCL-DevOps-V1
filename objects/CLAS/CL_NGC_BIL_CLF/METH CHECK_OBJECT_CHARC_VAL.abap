  METHOD check_object_charc_val.

    CASE iv_data_type.
      WHEN if_ngc_c=>gc_charcdatatype-char.
        IF is_value-charcfromamount           IS INITIAL AND
           is_value-charctoamount             IS INITIAL AND
           is_value-charcfromdate             IS INITIAL AND
           is_value-charctodate               IS INITIAL AND
           is_value-charcfromdecimalvalue     IS INITIAL AND
           is_value-charctodecimalvalue       IS INITIAL AND
           is_value-charcfromnumericvalue     IS INITIAL AND
           is_value-charctonumericvalue       IS INITIAL AND
           is_value-charcfromnumericvalueunit IS INITIAL AND
           is_value-charctonumericvalueunit   IS INITIAL AND
           is_value-charcfromtime             IS INITIAL AND
           is_value-charctotime               IS INITIAL.
          rv_valid = abap_true.
        ENDIF.

      WHEN if_ngc_c=>gc_charcdatatype-num.
        IF is_value-charcvalue            IS INITIAL AND
           is_value-charcfromamount       IS INITIAL AND
           is_value-charctoamount         IS INITIAL AND
           is_value-charcfromdate         IS INITIAL AND
           is_value-charctodate           IS INITIAL AND
           is_value-charcfromnumericvalue IS INITIAL AND
           is_value-charctonumericvalue   IS INITIAL AND
           is_value-charcfromtime         IS INITIAL AND
           is_value-charctotime           IS INITIAL.
          rv_valid = abap_true.
        ENDIF.

      WHEN if_ngc_c=>gc_charcdatatype-curr.
        IF is_value-charcvalue                IS INITIAL AND
           is_value-charcfromdate             IS INITIAL AND
           is_value-charctodate               IS INITIAL AND
           is_value-charcfromdecimalvalue     IS INITIAL AND
           is_value-charctodecimalvalue       IS INITIAL AND
           is_value-charcfromnumericvalue     IS INITIAL AND
           is_value-charctonumericvalue       IS INITIAL AND
           is_value-charcfromtime             IS INITIAL AND
           is_value-charctotime               IS INITIAL.
          rv_valid = abap_true.
        ENDIF.

      WHEN if_ngc_c=>gc_charcdatatype-date.
        IF is_value-charcvalue                IS INITIAL AND
           is_value-charcfromamount           IS INITIAL AND
           is_value-charctoamount             IS INITIAL AND
           is_value-charcfromdecimalvalue     IS INITIAL AND
           is_value-charctodecimalvalue       IS INITIAL AND
           is_value-charcfromnumericvalue     IS INITIAL AND
           is_value-charctonumericvalue       IS INITIAL AND
           is_value-charcfromnumericvalueunit IS INITIAL AND
           is_value-charctonumericvalueunit   IS INITIAL AND
           is_value-charcfromtime             IS INITIAL AND
           is_value-charctotime               IS INITIAL.
          rv_valid = abap_true.
        ENDIF.

      WHEN if_ngc_c=>gc_charcdatatype-time.
        IF is_value-charcvalue                IS INITIAL AND
           is_value-charcfromamount           IS INITIAL AND
           is_value-charctoamount             IS INITIAL AND
           is_value-charcfromdate             IS INITIAL AND
           is_value-charctodate               IS INITIAL AND
           is_value-charcfromdecimalvalue     IS INITIAL AND
           is_value-charctodecimalvalue       IS INITIAL AND
           is_value-charcfromnumericvalue     IS INITIAL AND
           is_value-charctonumericvalue       IS INITIAL AND
           is_value-charcfromnumericvalueunit IS INITIAL AND
           is_value-charctonumericvalueunit   IS INITIAL.
          rv_valid = abap_true.
        ENDIF.

      WHEN OTHERS.
        ASSERT FIELDS 'Invalid charc data type' iv_data_type CONDITION 1 = 2 ##NO_TEXT.

    ENDCASE.

  ENDMETHOD.