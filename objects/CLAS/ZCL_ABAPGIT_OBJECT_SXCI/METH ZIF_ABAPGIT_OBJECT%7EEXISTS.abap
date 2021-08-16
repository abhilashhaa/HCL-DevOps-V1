  METHOD zif_abapgit_object~exists.

    DATA: lv_implementation_name TYPE rsexscrn-imp_name.

    lv_implementation_name = ms_item-obj_name.

    CALL FUNCTION 'SXV_IMP_EXISTS'
      EXPORTING
        imp_name           = lv_implementation_name
      EXCEPTIONS
        not_existing       = 1
        data_inconsistency = 2
        OTHERS             = 3.

    rv_bool = boolc( sy-subrc = 0 ).

  ENDMETHOD.