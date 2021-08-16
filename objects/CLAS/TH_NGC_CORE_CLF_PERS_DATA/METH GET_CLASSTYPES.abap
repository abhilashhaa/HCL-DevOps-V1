  METHOD get_classtypes.

    rt_classtype = VALUE #(
      ( classtype                     = cv_classtype_001
        clfnobjecttable               = cv_object_table_mara
        multipleobjtableclfnisallowed = abap_true
        clfnnewnumberingisallowed     = abap_true
        classtypeisusableinvarconfign = abap_true
        engchangemgmtisallowed        = abap_true
        multipleclassisallowed        = abap_true )
      ( classtype                     = cv_classtype_001
        clfnobjecttable               = 'MCHA'
        multipleobjtableclfnisallowed = abap_true
        clfnnewnumberingisallowed     = abap_true
        classtypeisusableinvarconfign = abap_false
        engchangemgmtisallowed        = abap_true
        multipleclassisallowed        = abap_false )
      ( classtype                     = '300'
        clfnobjecttable               = cv_object_table_mara )
      ( classtype                     = '026'
        clfnobjecttable               = cv_object_table_mara
        multipleobjtableclfnisallowed = abap_true )
      ( classtype                     = '026'
        clfnobjecttable               = cv_object_table_marat
        multipleobjtableclfnisallowed = abap_true ) ).

  ENDMETHOD.