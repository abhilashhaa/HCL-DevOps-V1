  METHOD unlock.

    ASSERT iv_classtype    IS NOT INITIAL
       AND iv_class        IS NOT INITIAL
       AND iv_clfnobjectid IS NOT INITIAL.

    mo_locking->clen_dequeue_classification(
      EXPORTING
        iv_enqmode = COND #( WHEN iv_write = abap_false THEN if_ngc_core_c=>gc_enqmode-shared ELSE if_ngc_core_c=>gc_enqmode-exclusive )
        iv_klart   = iv_classtype
        iv_class   = iv_class
        iv_mafid   = if_ngc_core_c=>gc_clf_object_class_indicator-object
        iv_objek   = iv_clfnobjectid ).

  ENDMETHOD.