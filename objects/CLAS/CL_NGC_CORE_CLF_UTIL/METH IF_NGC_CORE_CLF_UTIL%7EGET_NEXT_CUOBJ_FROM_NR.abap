  METHOD if_ngc_core_clf_util~get_next_cuobj_from_nr.

    TEST-SEAM cuobj_get_next_with_nr.
      CALL FUNCTION 'NUMBER_GET_NEXT'
        EXPORTING
          nr_range_nr             = if_ngc_core_c=>gc_inob_cuobj_number_range-number
          object                  = if_ngc_core_c=>gc_inob_cuobj_number_range-object
*         QUANTITY                = '1'
*         SUBOBJECT               = ' '
*         TOYEAR                  = '0000'
*         IGNORE_BUFFER           = ' '
        IMPORTING
          number                  = rv_cuobj
*         QUANTITY                =
*         RETURNCODE              =
        EXCEPTIONS
          interval_not_found      = 1
          number_range_not_intern = 2
          object_not_found        = 3
          quantity_is_0           = 4
          quantity_is_not_1       = 5
          interval_overflow       = 6
          buffer_overflow         = 7
          OTHERS                  = 8.
    END-TEST-SEAM.
    IF sy-subrc <> 0.
      " TODO error handling
      ASSERT 1 = 2.
    ENDIF.

  ENDMETHOD.