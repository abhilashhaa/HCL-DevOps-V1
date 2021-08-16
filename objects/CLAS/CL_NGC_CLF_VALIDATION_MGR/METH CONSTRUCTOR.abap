METHOD constructor.

  mt_validator = VALUE #(
    ( sort = 0010 validator = NEW cl_ngc_clf_val_clstype_allowed( ) )
    ( sort = 0020 validator = NEW cl_ngc_clf_val_ecn_used( )        )
*--------------------------------------------------------------------*
*   The ECN validator is not used yet, because ECN is not supported
*   by the API yet. When the ECN support is implemented, this is needed as well.
*   ( sort = 9999 validator = NEW cl_ngc_clf_val_ecn_classtype( )   )
*--------------------------------------------------------------------*
    ( sort = 0030 validator = NEW cl_ngc_clf_val_auth_clf( )        )
    ( sort = 0040 validator = NEW cl_ngc_clf_val_class_status( )    )
    ( sort = 0050 validator = NEW cl_ngc_clf_val_class_validity( )  )
    ( sort = 0060 validator = NEW cl_ngc_clf_val_multiple_class( )  )
    ( sort = 0070 validator = NEW cl_ngc_clf_val_positionnumber( )  )
    ( sort = 0080 validator = NEW cl_ngc_clf_val_charcval_domain( ) )
    ( sort = 0090 validator = NEW cl_ngc_clf_val_external_check( )  )
*   ( sort = 0100 validator = NEW cl_ngc_clf_val_entry_required( )  )
    ( sort = 0110 validator = NEW cl_ngc_clf_val_value_overlap( )   )
    ( sort = 0120 validator = NEW cl_ngc_clf_val_same_clf( )        )
    ( sort = 0130 validator = NEW cl_ngc_clf_val_value_used_leaf( ) )
  ).

ENDMETHOD.