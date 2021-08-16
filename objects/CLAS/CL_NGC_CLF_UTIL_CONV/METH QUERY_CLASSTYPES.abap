  METHOD query_classtypes.

    DATA:
      lt_classtype_range TYPE RANGE OF klassenart,
      ls_classtype_range LIKE LINE OF lt_classtype_range.


    CLEAR: gt_classtypes.

    " Build ranges of class types
    ls_classtype_range-sign = if_ngc_core_c=>gc_range_sign-include.
    ls_classtype_range-option = if_ngc_core_c=>gc_range_option-equals.
    LOOP AT it_kssk_insert ASSIGNING FIELD-SYMBOL(<ls_kssk_insert>).
      ls_classtype_range-low = <ls_kssk_insert>-klart.
      APPEND ls_classtype_range TO lt_classtype_range.
    ENDLOOP.

    LOOP AT it_ausp_insert ASSIGNING FIELD-SYMBOL(<ls_ausp_insert>).
      ls_classtype_range-low = <ls_ausp_insert>-klart.
      APPEND ls_classtype_range TO lt_classtype_range.
    ENDLOOP.

    LOOP AT it_kssk_delete ASSIGNING FIELD-SYMBOL(<ls_kssk_delete>).
      ls_classtype_range-low = <ls_kssk_delete>-klart.
      APPEND ls_classtype_range TO lt_classtype_range.
    ENDLOOP.

    LOOP AT it_ausp_delete ASSIGNING FIELD-SYMBOL(<ls_ausp_delete>).
      ls_classtype_range-low = <ls_ausp_delete>-klart.
      APPEND ls_classtype_range TO lt_classtype_range.
    ENDLOOP.

    " only query the object table
    TEST-SEAM select_classtype.
      SELECT classtype, clfnobjecttable
        FROM i_clfnclasstype
        INTO CORRESPONDING FIELDS OF TABLE @gt_classtypes
        WHERE classtype IN @lt_classtype_range ##TOO_MANY_ITAB_FIELDS.
    END-TEST-SEAM.

  ENDMETHOD.