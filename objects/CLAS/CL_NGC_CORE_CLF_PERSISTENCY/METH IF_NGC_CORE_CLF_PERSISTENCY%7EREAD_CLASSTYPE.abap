  METHOD if_ngc_core_clf_persistency~read_classtype.

    read_classtypes_int( ).

    READ TABLE mt_classtypes INTO rs_classtype
      WITH KEY clfnobjecttable = iv_clfnobjecttable
               classtype       = iv_classtype.

  ENDMETHOD.