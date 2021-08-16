  METHOD conv_mult_to_sing_relations.

    " 2  >=  -  <
    " 3  >=  -  <=
    " 4  >   -  <
    " 5  >   -  <=

    LOOP AT ct_valuation_data ASSIGNING FIELD-SYMBOL(<ls_valuation>)
      WHERE
        charcvaluedependency CO '2345'.
      IF <ls_valuation>-charcfromnumericvalue <= mc_min_2.
        CLEAR  <ls_valuation>-charcfromnumericvalue.

        CASE <ls_valuation>-charcvaluedependency.
          WHEN '2' OR '4'.
            <ls_valuation>-charcvaluedependency = '6'.
          WHEN '3' OR '5'.
            <ls_valuation>-charcvaluedependency = '7'.
        ENDCASE.

        CONTINUE.
      ENDIF.

      IF <ls_valuation>-charctonumericvalue >= mc_max_2.
        CLEAR <ls_valuation>-charctonumericvalue.

        CASE <ls_valuation>-charcvaluedependency.
          WHEN '2' OR '3'.
            <ls_valuation>-charcvaluedependency = '9'.
          WHEN '4' OR '5'.
            <ls_valuation>-charcvaluedependency = '8'.
        ENDCASE.

        CONTINUE.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.