  METHOD refval_exists.

    DATA:
      l_ref TYPE REF TO data.

    rv_refval_exists = abap_false.

    " Select the reference table.
    DATA(lr_iobj) = REF #( it_reftabs[ tname = iv_attab ] OPTIONAL ).

    IF lr_iobj IS INITIAL.

      " Behaving normal characteristic as reference data is not passed (or this chr is not valid currently).
      RETURN.
    ENDIF.

    " Convert back the selected line of ref.table to structure format.
    CALL FUNCTION 'CLUC_CONVERT_STRUCTURE_BACK'
      EXPORTING
        i_object    = lr_iobj->table
        i_objectid  = lr_iobj->tname
      IMPORTING
        e_refobject = l_ref
      EXCEPTIONS
        OTHERS      = 2.

    IF sy-subrc IS NOT INITIAL.

      " Data conversion error.
      RETURN.
    ENDIF.

    ASSIGN l_ref->* TO FIELD-SYMBOL(<lv_obj>).

    " Select the reference field of the structure.
    ASSIGN COMPONENT iv_atfel
      OF STRUCTURE <lv_obj>
      TO FIELD-SYMBOL(<lv_reference_data>).

    IF NOT sy-subrc IS INITIAL.

      " Data conversion error.
      RETURN.
    ENDIF.

    rv_refval_exists = abap_true.

  ENDMETHOD.