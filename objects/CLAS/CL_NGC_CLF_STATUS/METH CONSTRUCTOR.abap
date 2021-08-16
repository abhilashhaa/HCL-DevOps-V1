  METHOD constructor.

    mo_clf_persistency           = cl_ngc_core_factory=>get_clf_persistency( ).
    mo_domain_value_validator    = NEW cl_ngc_clf_val_charcval_domain( ).
    mo_value_used_leaf_validator = NEW cl_ngc_clf_val_value_used_leaf( ).

  ENDMETHOD.