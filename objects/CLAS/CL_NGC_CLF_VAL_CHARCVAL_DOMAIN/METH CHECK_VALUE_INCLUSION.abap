  METHOD check_value_inclusion.
    DATA:
      float_eps       TYPE atflv VALUE '0.00000000000005',
      float_from_low  TYPE atflv,
      float_from_high TYPE atflv,
      float_to_high   TYPE atflb,
      float_to_low    TYPE atflb.

    LOOP AT it_domain_value ASSIGNING FIELD-SYMBOL(<ls_domain_value>).
      IF <ls_domain_value>-charcfromnumericvalue GE 0.
        float_from_low  = <ls_domain_value>-charcfromnumericvalue * ( 1 - float_eps ).
        float_from_high = <ls_domain_value>-charcfromnumericvalue * ( 1 + float_eps ).
      ELSE.
        float_from_low  = <ls_domain_value>-charcfromnumericvalue * ( 1 + float_eps ).
        float_from_high = <ls_domain_value>-charcfromnumericvalue * ( 1 - float_eps ).
      ENDIF.
      IF <ls_domain_value>-charcvaluedependency CA '2345'.
        IF <ls_domain_value>-charctonumericvalue GE 0.
          float_to_low  = <ls_domain_value>-charctonumericvalue * ( 1 - float_eps ).
          float_to_high = <ls_domain_value>-charctonumericvalue * ( 1 + float_eps ).
        ELSE.
          float_to_low  = <ls_domain_value>-charctonumericvalue * ( 1 + float_eps ).
          float_to_high = <ls_domain_value>-charctonumericvalue * ( 1 - float_eps ).
        ENDIF.
      ELSE.
        CLEAR : float_to_low, float_to_high.
      ENDIF.

      CASE <ls_domain_value>-charcvaluedependency.
        WHEN '1'. " EQ
          CHECK is_valuation_data_upd-charcvaluedependency = '1'.
          IF is_valuation_data_upd-charcfromnumericvalue GE float_from_low  AND
             is_valuation_data_upd-charcfromnumericvalue LE float_from_high.
            cv_subrc = 0.
            EXIT.
          ENDIF.
        WHEN '2'. " GE LT
          CHECK is_valuation_data_upd-charcvaluedependency NA '6789'.
          CASE is_valuation_data_upd-charcvaluedependency.
            WHEN '1'. " EQ
              IF is_valuation_data_upd-charcfromnumericvalue GE float_from_low  AND
                 is_valuation_data_upd-charcfromnumericvalue LT float_to_low.
                cv_subrc = 0.
                EXIT.
              ENDIF.
            WHEN '3'. " GE LE
              IF is_valuation_data_upd-charcfromnumericvalue GE float_from_low  AND
                 is_valuation_data_upd-charctonumericvalue LT float_to_low.
                cv_subrc = 0.
                EXIT.
              ENDIF.
            WHEN '5'. " GT LE  included in 3=(GE LE)
              IF is_valuation_data_upd-charcfromnumericvalue GE float_from_low  AND
                 is_valuation_data_upd-charctonumericvalue LT float_to_low.
                cv_subrc = 0.
                EXIT.
              ENDIF.
            WHEN '2'. " GE LT
              IF is_valuation_data_upd-charcfromnumericvalue GE float_from_low  AND
                 is_valuation_data_upd-charctonumericvalue LE float_to_high.
                cv_subrc = 0.
                EXIT.
              ENDIF.
            WHEN '4'. " GT LT  included in 2=(GE LT)
              IF is_valuation_data_upd-charcfromnumericvalue GE float_from_low  AND
                 is_valuation_data_upd-charctonumericvalue LE float_to_high.
                cv_subrc = 0.
                EXIT.
              ENDIF.
          ENDCASE.
        WHEN '3'. " GE LE
          CHECK is_valuation_data_upd-charcvaluedependency NA '6789'.
          CASE is_valuation_data_upd-charcvaluedependency.
            WHEN '1'.
              IF is_valuation_data_upd-charcfromnumericvalue GE float_from_low  AND
                 is_valuation_data_upd-charcfromnumericvalue LE float_to_high.
                cv_subrc = 0.
                EXIT.
              ENDIF.
            WHEN OTHERS. "2345  included in 3=(GE LE)
              IF is_valuation_data_upd-charcfromnumericvalue GE float_from_low  AND
                 is_valuation_data_upd-charctonumericvalue LE float_to_high.
                cv_subrc = 0.
                EXIT.
              ENDIF.
          ENDCASE.
        WHEN '4'. " GT LT
          CHECK is_valuation_data_upd-charcvaluedependency NA '6789'.
          CASE is_valuation_data_upd-charcvaluedependency.
            WHEN '1'. " EQ
              IF is_valuation_data_upd-charcfromnumericvalue GT float_from_high AND
                 is_valuation_data_upd-charcfromnumericvalue LT float_to_low.
                cv_subrc = 0.
                EXIT.
              ENDIF.
            WHEN '4'. " GT LT
              IF is_valuation_data_upd-charcfromnumericvalue GE float_from_low AND
                 is_valuation_data_upd-charctonumericvalue LE float_to_high.
                cv_subrc = 0.
                EXIT.
              ENDIF.
            WHEN '2'. " GE LT
              IF is_valuation_data_upd-charcfromnumericvalue GT float_from_high AND
                 is_valuation_data_upd-charctonumericvalue LE float_to_high.
                cv_subrc = 0.
                EXIT.
              ENDIF.
            WHEN '3'. " GE LE
              IF is_valuation_data_upd-charcfromnumericvalue GT float_from_high AND
                 is_valuation_data_upd-charctonumericvalue LT float_to_low.
                cv_subrc = 0.
                EXIT.
              ENDIF.
            WHEN '5'. " GT LE
              IF is_valuation_data_upd-charcfromnumericvalue GE float_from_low  AND
                 is_valuation_data_upd-charctonumericvalue LT float_to_low.
                cv_subrc = 0.
                EXIT.
              ENDIF.
          ENDCASE.
        WHEN '5'. " GT LE
          CHECK is_valuation_data_upd-charcvaluedependency NA '6789'.
          CASE is_valuation_data_upd-charcvaluedependency.
            WHEN '1'. " EQ
              IF is_valuation_data_upd-charcfromnumericvalue GT float_from_high AND
                 is_valuation_data_upd-charcfromnumericvalue LE float_to_high.
                cv_subrc = 0.
                EXIT.
              ENDIF.
            WHEN '5'. " GT LE
              IF is_valuation_data_upd-charcfromnumericvalue GE float_from_low  AND
                 is_valuation_data_upd-charctonumericvalue LE float_to_high.
                cv_subrc = 0.
                EXIT.
              ENDIF.
            WHEN '4'. " GT LT   included in 5=(GT LE)
              IF is_valuation_data_upd-charcfromnumericvalue GE float_from_low  AND
                 is_valuation_data_upd-charctonumericvalue LE float_to_high.
                cv_subrc = 0.
                EXIT.
              ENDIF.
            WHEN '3'. " GE LE
              IF is_valuation_data_upd-charcfromnumericvalue GT float_from_high AND
                 is_valuation_data_upd-charctonumericvalue LE float_to_high.
                cv_subrc = 0.
                EXIT.
              ENDIF.
            WHEN '2'. " GE LT   included in 3=(GE LE)
              IF is_valuation_data_upd-charcfromnumericvalue GT float_from_high AND
                 is_valuation_data_upd-charctonumericvalue LE float_to_high.
                cv_subrc = 0.
                EXIT.
              ENDIF.
          ENDCASE.
        WHEN '6'. " LT
          CHECK is_valuation_data_upd-charcvaluedependency NA '89'.
          CASE is_valuation_data_upd-charcvaluedependency.
            WHEN '1'.
              IF is_valuation_data_upd-charcfromnumericvalue LT float_from_low.
                cv_subrc = 0.
                EXIT.
              ENDIF.
            WHEN '6'. "    LT
              IF is_valuation_data_upd-charcfromnumericvalue LE float_from_high.
                cv_subrc = 0.
                EXIT.
              ENDIF.
            WHEN '7'. "    LE
              IF is_valuation_data_upd-charcfromnumericvalue LT float_from_low.
                cv_subrc = 0.
                EXIT.
              ENDIF.
            WHEN '2'. " GE LT
              IF is_valuation_data_upd-charctonumericvalue LE float_from_high.
                cv_subrc = 0.
                EXIT.
              ENDIF.
            WHEN '4'. " GT LT  included in 2=(GE LT)
              IF is_valuation_data_upd-charctonumericvalue LE float_from_high.
                cv_subrc = 0.
                EXIT.
              ENDIF.
            WHEN '3'. " GE LE  included in 7=LE
              IF is_valuation_data_upd-charctonumericvalue LT float_from_low.
                cv_subrc = 0.
                EXIT.
              ENDIF.
            WHEN '5'. " GT LE  included in 3=(GE LE)
              IF is_valuation_data_upd-charctonumericvalue LT float_from_low.
                cv_subrc = 0.
                EXIT.
              ENDIF.
          ENDCASE.
        WHEN '7'. "    LE
          CHECK is_valuation_data_upd-charcvaluedependency NA '89'.
          IF is_valuation_data_upd-charcvaluedependency CA '167'.
            IF is_valuation_data_upd-charcfromnumericvalue LE float_from_high.
              cv_subrc = 0.
              EXIT.
            ENDIF.
          ENDIF.
          IF is_valuation_data_upd-charcvaluedependency CA '2345'.
            IF is_valuation_data_upd-charctonumericvalue LE float_from_high.
              cv_subrc = 0.
              EXIT.
            ENDIF.
          ENDIF.
        WHEN '8'. " GT
          CHECK is_valuation_data_upd-charcvaluedependency NA '67'.
          IF is_valuation_data_upd-charcvaluedependency CA '1239'.
            IF is_valuation_data_upd-charcfromnumericvalue GT float_from_high.
              cv_subrc = 0.
              EXIT.
            ENDIF.
          ENDIF.
          IF is_valuation_data_upd-charcvaluedependency CA '458'.
            IF is_valuation_data_upd-charcfromnumericvalue GE float_from_low.
              cv_subrc = 0.
              EXIT.
            ENDIF.
          ENDIF.
        WHEN '9'. " GE
          CHECK is_valuation_data_upd-charcvaluedependency NA '67'.
          IF is_valuation_data_upd-charcfromnumericvalue GE float_from_low.
            cv_subrc = 0.
            EXIT.
          ENDIF.
      ENDCASE.

    ENDLOOP.
  ENDMETHOD.