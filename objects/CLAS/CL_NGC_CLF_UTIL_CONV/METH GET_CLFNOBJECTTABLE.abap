  METHOD get_clfnobjecttable.

    READ TABLE gt_classtypes ASSIGNING FIELD-SYMBOL(<ls_classtype>)
      WITH KEY classtype = iv_classtype.

    IF sy-subrc <> 0.
      ASSERT 1 = 2.
    ENDIF.

    rv_clfnobjecttable = <ls_classtype>-clfnobjecttable.

  ENDMETHOD.