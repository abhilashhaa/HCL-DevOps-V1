  METHOD if_ngc_classification~get_updated_data.

    CLEAR: et_classification_data_upd, et_assigned_class_upd, et_valuation_data_upd, et_valuation_data_prev.

    et_classification_data_upd = mt_classification_data.
    et_assigned_class_upd      = mt_assigned_class.
    IF mv_valuation_hash_table IS NOT INITIAL.
      et_valuation_data_upd      = mt_valuation_data_h.
      et_valuation_data_prev     = mt_valuation_data_h_prev.
    ELSE.
      et_valuation_data_upd      = mt_valuation_data.
    ENDIF.

  ENDMETHOD.