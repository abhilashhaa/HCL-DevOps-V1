  METHOD class_setup.

    DATA:
      lt_charcvalue TYPE STANDARD TABLE OF I_ClfnObjectCharcValue,
      lo_charcvalue TYPE REF TO if_cds_test_data.


    go_environment = cl_cds_test_environment=>create( i_for_entity = 'I_ClfnObjectCharcValForKeyDate' ).

    " Stub characteristic values
    lt_charcvalue = VALUE #(
      ( clfnobjectid             = 'OBJECT_1'
        clfnobjecttable          = 'MARA'
        charcinternalid          = '0000000001'
        charcvaluepositionnumber = 1
        clfnobjecttype           = 'O'
        classtype                = '001'
        timeintervalnumber       = 0
        charcvalue               = 'VALUE01'
        isdeleted                = abap_false
        validitystartdate        = '20000101'
        validityenddate          = '20181231' )
      ( clfnobjectid             = 'OBJECT_2'
        clfnobjecttable          = 'MARA'
        charcinternalid          = '0000000002'
        charcvaluepositionnumber = 1
        clfnobjecttype           = 'O'
        classtype                = '001'
        timeintervalnumber       = 0
        charcvalue               = 111
        isdeleted                = abap_false
        validitystartdate        = '20000101'
        validityenddate          = '20121231' )
      ( clfnobjectid             = 'OBJECT_2'
        clfnobjecttable          = 'MARA'
        charcinternalid          = '0000000002'
        charcvaluepositionnumber = 1
        clfnobjecttype           = 'O'
        classtype                = '001'
        timeintervalnumber       = 1
        charcvalue               = 111
        isdeleted                = abap_true
        validitystartdate        = '20130101'
        validityenddate          = '20151231' )
      ( clfnobjectid             = 'OBJECT_2'
        clfnobjecttable          = 'MARA'
        charcinternalid          = '0000000002'
        charcvaluepositionnumber = 1
        clfnobjecttype           = 'O'
        classtype                = '001'
        timeintervalnumber       = 2
        charcvalue               = 111
        isdeleted                = abap_false
        validitystartdate        = '20160101'
        validityenddate          = '20181231' )
      ( clfnobjectid             = 'OBJECT_2'
        clfnobjecttable          = 'MARA'
        charcinternalid          = '0000000003'
        charcvaluepositionnumber = 2
        clfnobjecttype           = 'O'
        classtype                = '001'
        timeintervalnumber       = 2
        charcvalue               = 222
        isdeleted                = abap_true
        validitystartdate        = '00010101'
        validityenddate          = '99991231' ) ).

    lo_charcvalue = cl_cds_test_data=>create( lt_charcvalue ).
    DATA(lo_charcvalue_stub) = go_environment->get_double( 'I_ClfnObjectCharcValue' ).
    lo_charcvalue_stub->insert( lo_charcvalue ).

  ENDMETHOD.