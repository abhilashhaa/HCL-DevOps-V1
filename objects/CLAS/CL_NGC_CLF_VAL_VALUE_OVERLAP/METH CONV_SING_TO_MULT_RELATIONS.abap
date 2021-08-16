  METHOD conv_sing_to_mult_relations.

    " 6   <
    " 7   <=
    " 8   >
    " 9   >=

    LOOP AT ct_valuation_data ASSIGNING FIELD-SYMBOL(<ls_valuation>)
        WHERE
          charcvaluedependency CO '6789'.
      CASE <ls_valuation>-charcvaluedependency.
        WHEN '6'.
          <ls_valuation>-charcfromnumericvalue = mc_min.
          <ls_valuation>-charcvaluedependency  = '4'.
        WHEN '7'.
          <ls_valuation>-charcfromnumericvalue = mc_min.
          <ls_valuation>-charcvaluedependency  = '5'.
        WHEN '8'.
          <ls_valuation>-charctonumericvalue  = mc_max.
          <ls_valuation>-charcvaluedependency = '4'.
        WHEN '9'.
          <ls_valuation>-charctonumericvalue  = mc_max.
          <ls_valuation>-charcvaluedependency = '2'.
      ENDCASE.
    ENDLOOP.

  ENDMETHOD.