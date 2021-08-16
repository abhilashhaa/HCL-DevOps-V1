CLASS ltc_ngc_core_cls_persistency DEFINITION
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS
  FINAl
  INHERITING FROM tc_ngc_core_cls_persistency.
ENDCLASS.

*CLASS lth_ngc_core_cls_pers_testdata DEFINITION DEFERRED.
*CLASS cl_ngc_core_cls_persistency DEFINITION LOCAL FRIENDS lth_ngc_core_cls_pers_testdata.
*
*CLASS lth_ngc_core_cls_pers_testdata DEFINITION.
*  PUBLIC SECTION.
*    CONSTANTS: gc_classinternalid_one TYPE clint VALUE '0000000001'.
*    CONSTANTS: gc_classinternalid_two TYPE clint VALUE '0000000002'.
*    CONSTANTS: gc_classinternalid_nonexisting TYPE clint VALUE '9999999999'.
*    CONSTANTS: gc_class_nonexisting TYPE klasse_d VALUE 'DOESNTEXIST'.
*    CONSTANTS: gc_class_one TYPE klasse_d VALUE 'TEST_CLASS_1'.
*    CONSTANTS: gc_class_two TYPE klasse_d VALUE 'TEST_CLASS_2'.
*    CONSTANTS: gc_classtype_nonexisting TYPE klassenart VALUE '123'.
*    CONSTANTS: gc_classtype_one TYPE klassenart VALUE '001'.
*    CONSTANTS: gc_classtype_two TYPE klassenart VALUE '300'.
*    CLASS-DATA: gt_charcs TYPE cl_ngc_core_cls_persistency=>tt_clfnclasshiercharcforkeydat.
*    CLASS-METHODS: class_constructor.
*    CLASS-METHODS: get_cds_view_sel_data_int
*      IMPORTING
*        iv_classinternalid   TYPE clint
*        iv_key_date          TYPE dats DEFAULT sy-datum
*      EXPORTING
*        et_cds_view_sel_data TYPE STANDARD TABLE.
*    CLASS-METHODS: get_cds_view_sel_data_ext
*      IMPORTING
*        iv_classtype         TYPE klassenart
*        iv_class             TYPE klasse_d
*        iv_key_date          TYPE dats DEFAULT sy-datum
*      EXPORTING
*        et_cds_view_sel_data TYPE STANDARD TABLE.
*    CLASS-METHODS: get_expected_core_class_data
*      IMPORTING iv_classinternalid                 TYPE clint
*                iv_key_date                        TYPE dats DEFAULT sy-datum
*      RETURNING VALUE(rt_expected_core_class_data) TYPE ngct_core_class.
*  PRIVATE SECTION.
*    CLASS-DATA gt_cds_view_i_clfnclass_data TYPE STANDARD TABLE OF i_clfnclassforkeydate.
*ENDCLASS.
*
*CLASS lth_ngc_core_cls_pers_testdata IMPLEMENTATION.
*
*  METHOD class_constructor.
*
*    gt_cds_view_i_clfnclass_data  = VALUE #(
*
*      ( classinternalid               = gc_classinternalid_one
*        classtype                     = gc_classtype_one
*        class                         = gc_class_one
*        classstatus                   = '1'
*        classsearchauthgrp            = 'TST'
*        classclassfctnauthgrp         = ''
*        classmaintauthgrp             = ''
*        documentinforecorddocnumber   = ''
*        documentinforecorddoctype     = ''
*        documentinforecorddocpart     = ''
*        documentinforecorddocversion  = ''
*        sameclassfctnreaction         = ''
*        clfnorganizationalarea        = ''
*        classstandardorgname          = ''
*        classstandardnumber           = ''
*        classstandardstartdate        = ''
*        classstandardversion          = ''
*        classstandardcharctable       = ''
*        classislocal                  = ''
*        validitystartdate             = '20170117'
*        validityenddate               = '99991231' )
*
*      ( classinternalid               = gc_classinternalid_two
*        classtype                     = gc_classtype_two
*        class                         = gc_class_two
*        classstatus                   = '2'
*        classsearchauthgrp            = 'TST'
*        classclassfctnauthgrp         = ''
*        classmaintauthgrp             = ''
*        documentinforecorddocnumber   = ''
*        documentinforecorddoctype     = ''
*        documentinforecorddocpart     = ''
*        documentinforecorddocversion  = ''
*        sameclassfctnreaction         = ''
*        clfnorganizationalarea        = ''
*        classstandardorgname          = ''
*        classstandardnumber           = ''
*        classstandardstartdate        = ''
*        classstandardversion          = ''
*        classstandardcharctable       = ''
*        classislocal                  = ''
*        validitystartdate             = '20010117'
*        validityenddate               = '99991231' )
*
*      ( classinternalid               = '0000000003'
*        classtype                     = '001'
*        class                         = 'TEST_CLASS_3'
*        classstatus                   = '3'
*        classsearchauthgrp            = 'TST'
*        classclassfctnauthgrp         = ''
*        classmaintauthgrp             = ''
*        documentinforecorddocnumber   = ''
*        documentinforecorddoctype     = ''
*        documentinforecorddocpart     = ''
*        documentinforecorddocversion  = ''
*        sameclassfctnreaction         = ''
*        clfnorganizationalarea        = ''
*        classstandardorgname          = ''
*        classstandardnumber           = ''
*        classstandardstartdate        = ''
*        classstandardversion          = ''
*        classstandardcharctable       = ''
*        classislocal                  = ''
*        validitystartdate             = '20200117'
*        validityenddate               = '99991231' )
*
*    ).
*
*    gt_charcs = VALUE #(
*     ( classinternalid            = '0000000001'
*       class                      = 'TEST_CLASS_1'
*       ancestorclassinternalid    = '0000000002'
*       ancestorclass              = 'TEST_CLASS_2'
*       charcinternalid            = '0000000002'
*       characteristic             = 'TEST_CHAR_02'
*       classtype                  = '001'
*       charcisinherited           = abap_true
*       overwrittencharcinternalid = '0000000000'
*       key_date                   = '20170130' )
*
*     ( classinternalid            = '0000000001'
*       class                      = 'TEST_CLASS_1'
*       ancestorclassinternalid    = '0000000004'
*       ancestorclass              = 'TEST_CLASS_4'
*       charcinternalid            = '0000000004'
*       characteristic             = 'TEST_CHAR_04'
*       classtype                  = '001'
*       charcisinherited           = abap_true
*       overwrittencharcinternalid = '0000000000'
*       key_date                   = '20170130' )
*
*     ( classinternalid            = '0000000001'
*       class                      = 'TEST_CLASS_1'
*       ancestorclassinternalid    = '0000000001'
*       ancestorclass              = 'TEST_CLASS_1'
*       charcinternalid            = '0000000001'
*       characteristic             = 'TEST_CHAR_01'
*       classtype                  = '001'
*       charcisinherited           = abap_false
*       overwrittencharcinternalid = '0000000005'
*       key_date                   = '20170130' )
*
*     ( classinternalid            = '0000000001'
*       class                      = 'TEST_CLASS_1'
*       ancestorclassinternalid    = '0000000003'
*       ancestorclass              = 'TEST_CLASS_3'
*       charcinternalid            = '0000000003'
*       characteristic             = 'TEST_CHAR_03'
*       classtype                  = '001'
*       charcisinherited           = abap_true
*       overwrittencharcinternalid = '0000000006'
*       key_date                   = '20170130' )
*
*     ( classinternalid            = '0000000002'
*       class                      = 'TEST_CLASS_2'
*       ancestorclassinternalid    = '0000000002'
*       ancestorclass              = 'TEST_CLASS_2'
*       charcinternalid            = '0000000002'
*       characteristic             = 'TEST_CHAR_02'
*       classtype                  = '001'
*       charcisinherited           = abap_false
*       overwrittencharcinternalid = '0000000000'
*       key_date                   = '20170130' )
*
*     ( classinternalid            = '0000000002'
*       class                      = 'TEST_CLASS_2'
*       ancestorclassinternalid    = '0000000004'
*       ancestorclass              = 'TEST_CLASS_4'
*       charcinternalid            = '0000000004'
*       characteristic             = 'TEST_CHAR_04'
*       classtype                  = '001'
*       charcisinherited           = abap_true
*       overwrittencharcinternalid = '0000000000'
*       key_date                   = '20170130' )
*
*     ( classinternalid            = '0000000004'
*       class                      = 'TEST_CLASS_4'
*       ancestorclassinternalid    = '0000000004'
*       ancestorclass              = 'TEST_CLASS_4'
*       charcinternalid            = '0000000004'
*       characteristic             = 'TEST_CHAR_04'
*       classtype                  = '001'
*       charcisinherited           = abap_false
*       overwrittencharcinternalid = '0000000000'
*       key_date                   = '20170130' )
*
*     ( classinternalid            = '0000000003'
*       class                      = 'TEST_CLASS_3'
*       ancestorclassinternalid    = '0000000003'
*       ancestorclass              = 'TEST_CLASS_3'
*       charcinternalid            = '0000000003'
*       characteristic             = 'TEST_CHAR_03'
*       classtype                  = '001'
*       charcisinherited           = abap_false
*       overwrittencharcinternalid = '0000000006'
*       key_date                   = '20170130' )
*    ).
*
*  ENDMETHOD.
*
*  METHOD get_expected_core_class_data.
*    DATA: ls_exp_core_class_data LIKE LINE OF rt_expected_core_class_data.
*    LOOP AT gt_cds_view_i_clfnclass_data ASSIGNING FIELD-SYMBOL(<ls_cds_view_i_clfnclass_data>)
*      WHERE classinternalid = iv_classinternalid.
*      MOVE-CORRESPONDING <ls_cds_view_i_clfnclass_data> TO ls_exp_core_class_data.
*      ls_exp_core_class_data-key_date = iv_key_date.
*      APPEND ls_exp_core_class_data TO rt_expected_core_class_data.
*    ENDLOOP.
*  ENDMETHOD.
*
*  METHOD get_cds_view_sel_data_int.
*    CLEAR: et_cds_view_sel_data.
*    DATA: ls_core_class TYPE ngcs_core_class.
*    LOOP AT gt_cds_view_i_clfnclass_data ASSIGNING FIELD-SYMBOL(<ls_cds_view_i_clfnclass_data>)
*      WHERE
*        classinternalid = iv_classinternalid.
*      MOVE-CORRESPONDING <ls_cds_view_i_clfnclass_data> TO ls_core_class.
*      ls_core_class-key_date = iv_key_date.
*      APPEND ls_core_class TO et_cds_view_sel_data.
*    ENDLOOP.
*  ENDMETHOD.
*
*  METHOD get_cds_view_sel_data_ext.
*    CLEAR: et_cds_view_sel_data.
*    DATA: ls_core_class TYPE ngcs_core_class.
*    LOOP AT gt_cds_view_i_clfnclass_data ASSIGNING FIELD-SYMBOL(<ls_cds_view_i_clfnclass_data>)
*      WHERE classtype = iv_classtype
*        AND class     = iv_class.
*      MOVE-CORRESPONDING <ls_cds_view_i_clfnclass_data> TO ls_core_class.
*      ls_core_class-key_date = iv_key_date.
*      APPEND ls_core_class TO et_cds_view_sel_data.
*    ENDLOOP.
*  ENDMETHOD.
*
*ENDCLASS.
*
*CLASS ltc_ngc_core_cls_pers DEFINITION DEFERRED.
*CLASS cl_ngc_core_cls_persistency DEFINITION LOCAL FRIENDS ltc_ngc_core_cls_pers.
*
*CLASS ltc_ngc_core_cls_pers DEFINITION FOR TESTING
*  DURATION SHORT
*  RISK LEVEL HARMLESS.
*
*  PRIVATE SECTION.
*    DATA: mo_cut TYPE REF TO cl_ngc_core_cls_persistency.
*    CLASS-METHODS: class_setup.
*    CLASS-METHODS: class_teardown.
*    METHODS: setup.
*    METHODS: teardown.
*    METHODS: read_intkey_nonexisting_class FOR TESTING.
*    METHODS: read_intkey_one_exist_cls FOR TESTING.
*    METHODS: read_intkey_one_exist_cls_chr FOR TESTING.
*    METHODS: read_intkey_two_existing_class FOR TESTING.
*    METHODS: read_extkey_nonexisting_class FOR TESTING.
*    METHODS: read_extkey_one_exist_cls FOR TESTING.
*    METHODS: read_extkey_two_existing_class FOR TESTING.
*    METHODS: read_class_status FOR TESTING.
*    METHODS: read_class_statuses FOR TESTING.
*    METHODS: check_org_area FOR TESTING.
*
*ENDCLASS.
*
*
*CLASS ltc_ngc_core_cls_pers IMPLEMENTATION.
*
*  METHOD class_setup.
*
*  ENDMETHOD.
*
*
*  METHOD class_teardown.
*
*  ENDMETHOD.
*
*
*  METHOD setup.
*
*    DATA lo_cls_util_intersect TYPE REF TO if_ngc_core_cls_util_intersect.
*    DATA lo_chr_persistency TYPE REF TO if_ngc_core_chr_persistency.
*
*    TEST-INJECTION sel_cds_class_int_key.
*      DATA: lt_clfnclass_temp LIKE lt_core_class.
*      LOOP AT <ls_class_range_by_clint>-classinternalid INTO ls_classinternalid_range.
*        lth_ngc_core_cls_pers_testdata=>get_cds_view_sel_data_int( EXPORTING iv_classinternalid   = ls_classinternalid_range-low
*                                                                             iv_key_date          = <ls_class_range_by_clint>-key_date
*                                                                   IMPORTING et_cds_view_sel_data = lt_clfnclass_temp ).
*        APPEND LINES OF lt_clfnclass_temp TO lt_core_class.
*      ENDLOOP.
*
*    END-TEST-INJECTION.
*
*    TEST-INJECTION sel_cds_class_ext_key.
*      DATA: lt_clfnclass_temp LIKE lt_core_class.
*      LOOP AT <ls_class_range_by_classtype>-class INTO ls_class_range.
*        lth_ngc_core_cls_pers_testdata=>get_cds_view_sel_data_ext( EXPORTING iv_classtype         = <ls_class_range_by_classtype>-classtype
*                                                                             iv_class             = ls_class_range-low
*                                                                             iv_key_date          = <ls_class_range_by_classtype>-key_date
*                                                                   IMPORTING et_cds_view_sel_data = lt_clfnclass_temp ).
*        APPEND LINES OF lt_clfnclass_temp TO lt_core_class.
*      ENDLOOP.
*    END-TEST-INJECTION.
*
*    TEST-INJECTION sel_cds_org_area.
*      mt_org_area_w_auth = VALUE #(
*        ( classtype                = '001'
*          clfnorganizationalareaid = 'Z' )
*        ( classtype                = '001'
*          clfnorganizationalareaid = 'Y' ) ).
*      mt_org_area_w_disp_auth = VALUE #(
*        ( classtype                = '001'
*          clfnorganizationalareaid = 'X' )
*        ( classtype                = '001'
*          clfnorganizationalareaid = 'Y' ) ).
*    END-TEST-INJECTION.
*
*    TEST-INJECTION sel_cds_classcharc_int_key.
*      LOOP AT lth_ngc_core_cls_pers_testdata=>gt_charcs INTO DATA(ls_charc) WHERE classinternalid IN <ls_class_int_key_with_range>-classinternalid.
*        APPEND ls_charc TO lt_clfnclasshiercharcforkeydat.
*      ENDLOOP.
*    END-TEST-INJECTION.
*
*    TEST-INJECTION sel_cds_anc_classcharc_int_key.
*      LOOP AT lth_ngc_core_cls_pers_testdata=>gt_charcs INTO ls_charc
*        WHERE classinternalid IN lt_ancestor_range
*        AND charcinternalid <> ''.
*        APPEND ls_charc TO lt_classhiercharc_buffer.
*      ENDLOOP.
*    END-TEST-INJECTION.
*
*    TEST-INJECTION sel_cds_anc_classcharc_ext_key.
*      DATA lt_chars LIKE mt_clfnclasshiercharcforkeydat.
*
*      lt_chars = VALUE #(
*        ( classinternalid            = '0000000002'
*          class                      = 'TEST_CL_02'
*          ancestorclassinternalid    = '0000000002'
*          ancestorclass              = 'TEST_CL_02'
*          charcinternalid            = '0000000002'
*          characteristic             = 'TEST_CHAR_02'
*          classtype                  = '001'
*          charcisinherited           = abap_false
*          overwrittencharcinternalid = '0000000000'
*          key_date                   = '20170130' )
*
*        ( classinternalid            = '0000000002'
*          class                      = 'TEST_CL_02'
*          ancestorclassinternalid    = '0000000004'
*          ancestorclass              = 'TEST_CL_04'
*          charcinternalid            = '0000000004'
*          characteristic             = 'TEST_CHAR_04'
*          classtype                  = '001'
*          charcisinherited           = abap_true
*          overwrittencharcinternalid = '0000000000'
*          key_date                   = '20170130' )
*
*        ( classinternalid            = '0000000004'
*          class                      = 'TEST_CL_04'
*          ancestorclassinternalid    = '0000000004'
*          ancestorclass              = 'TEST_CL_04'
*          charcinternalid            = '0000000004'
*          characteristic             = 'TEST_CHAR_04'
*          classtype                  = '001'
*          charcisinherited           = abap_false
*          overwrittencharcinternalid = '0000000000'
*          key_date                   = '20170130' )
*
*        ( classinternalid            = '0000000003'
*          class                      = 'TEST_CL_03'
*          ancestorclassinternalid    = '0000000003'
*          ancestorclass              = 'TEST_CL_03'
*          charcinternalid            = '0000000003'
*          characteristic             = 'TEST_CHAR_03'
*          classtype                  = '001'
*          charcisinherited           = abap_false
*          overwrittencharcinternalid = '0000000006'
*          key_date                   = '20170130' ) ).
*
*      LOOP AT lt_chars ASSIGNING FIELD-SYMBOL(<ls_char>)
*        WHERE ancestorclassinternalid IN lt_ancestor_range
*        AND charcinternalid <> ''.
*        APPEND <ls_char> TO lt_classhiercharc_buffer.
*      ENDLOOP.
*    END-TEST-INJECTION.
*
*    TEST-INJECTION sel_cds_clfnobjcharwithvalue.
*      DATA lt_clfchars LIKE mt_clfnobjectcharcvalue.
*
*      lt_clfchars = VALUE #(
*        ( clfnobjectid             = '0000000001'
*          charcinternalid          = '0000000002'
*          charcvaluepositionnumber = '01'
*          clfnobjecttype           = 'K'
*          classtype                = '001'
*          timeintervalnumber       = '001'
*          charcvalue               = 'VALUE02' ) ).
*
*      LOOP AT lt_inheritance_keys ASSIGNING FIELD-SYMBOL(<ls_inheritance_key>).
*        LOOP AT lt_clfchars ASSIGNING FIELD-SYMBOL(<ls_clfchar>) WHERE clfnobjectid IN <ls_inheritance_key>-ancestorclassinternalid.
*          APPEND <ls_clfchar> TO mt_clfnobjectcharcvalue.
*        ENDLOOP.
*      ENDLOOP.
*    END-TEST-INJECTION.
*
*    TEST-INJECTION sel_cds_parents_objclassbasic.
*      DATA lt_parents LIKE mt_parent_objectclassbasic.
*
*      lt_parents = VALUE #(
*        ( clfnobjectid = '0000000002'
*          classinternalid = '0000000004'
*          clfnobjecttype = 'K'
*          classtype = '001'
*          timeintervalnumber = '001' )
*
*        ( clfnobjectid = '0000000001'
*          classinternalid = '0000000002'
*          clfnobjecttype = 'K'
*          classtype = '001'
*          timeintervalnumber = '001' )
*
*        ( clfnobjectid = '0000000001'
*          classinternalid = '0000000003'
*          clfnobjecttype = 'K'
*          classtype = '001'
*          timeintervalnumber = '001' ) ).
*
*      LOOP AT lt_inheritance_keys ASSIGNING <ls_inheritance_key>.
*        LOOP AT lt_parents ASSIGNING FIELD-SYMBOL(<ls_parent>) WHERE clfnobjectid IN <ls_inheritance_key>-ancestorclassinternalid.
*          APPEND <ls_parent> TO mt_parent_objectclassbasic.
*        ENDLOOP.
*      ENDLOOP.
*    END-TEST-INJECTION.
*
*    TEST-INJECTION sel_cds_classcharc_ext_key.
*      DATA lt_classhiercharacts LIKE lt_clfnclasshiercharcforkeydat.
*
*      lt_classhiercharacts = VALUE #(
*        ( classinternalid            = '0000000001'
*          class                      = 'TEST_CL_01'
*          ancestorclassinternalid    = '0000000002'
*          ancestorclass              = 'TEST_CL_02'
*          charcinternalid            = '0000000002'
*          characteristic             = 'TEST_CHAR_02'
*          classtype                  = '001'
*          charcisinherited           = abap_true
*          overwrittencharcinternalid = '0000000000'
*          key_date                   = '20170130' )
*
*        ( classinternalid            = '0000000001'
*          class                      = 'TEST_CL_01'
*          ancestorclassinternalid    = '0000000004'
*          ancestorclass              = 'TEST_CL_04'
*          charcinternalid            = '0000000004'
*          characteristic             = 'TEST_CHAR_04'
*          classtype                  = '001'
*          charcisinherited           = abap_true
*          overwrittencharcinternalid = '0000000000'
*          key_date                   = '20170130' )
*
*        ( classinternalid            = '0000000001'
*          class                      = 'TEST_CL_01'
*          ancestorclassinternalid    = '0000000001'
*          ancestorclass              = 'TEST_CL_01'
*          charcinternalid            = '0000000001'
*          characteristic             = 'TEST_CHAR_01'
*          classtype                  = '001'
*          charcisinherited           = abap_false
*          overwrittencharcinternalid = '0000000005'
*          key_date                   = '20170130' )
*
*        ( classinternalid            = '0000000001'
*          class                      = 'TEST_CL_01'
*          ancestorclassinternalid    = '0000000003'
*          ancestorclass              = 'TEST_CL_03'
*          charcinternalid            = '0000000003'
*          characteristic             = 'TEST_CHAR_03'
*          classtype                  = '001'
*          charcisinherited           = abap_true
*          overwrittencharcinternalid = '0000000006'
*          key_date                   = '20170130' )
*
*        ( classinternalid            = '0000000002'
*          class                      = 'TEST_CL_02'
*          ancestorclassinternalid    = '0000000002'
*          ancestorclass              = 'TEST_CL_02'
*          charcinternalid            = '0000000002'
*          characteristic             = 'TEST_CHAR_02'
*          classtype                  = '001'
*          charcisinherited           = abap_false
*          overwrittencharcinternalid = '0000000000'
*          key_date                   = '20170130' )
*
*        ( classinternalid            = '0000000002'
*          class                      = 'TEST_CL_02'
*          ancestorclassinternalid    = '0000000004'
*          ancestorclass              = 'TEST_CL_04'
*          charcinternalid            = '0000000004'
*          characteristic             = 'TEST_CHAR_04'
*          classtype                  = '001'
*          charcisinherited           = abap_true
*          overwrittencharcinternalid = '0000000000'
*          key_date                   = '20170130' ) ).
*
*      LOOP AT lth_ngc_core_cls_pers_testdata=>gt_charcs ASSIGNING FIELD-SYMBOL(<ls_classhiercharact>)
*        WHERE classtype =  <ls_class_range_by_classtype>-classtype
*          AND class     IN <ls_class_range_by_classtype>-class.
*        APPEND <ls_classhiercharact> TO lt_clfnclasshiercharcforkeydat.
*      ENDLOOP.
*
*    END-TEST-INJECTION.
*
*    lo_cls_util_intersect ?= cl_abap_testdouble=>create( 'if_ngc_core_cls_util_intersect' ).
*    lo_chr_persistency ?= cl_abap_testdouble=>create( 'if_ngc_core_chr_persistency' ).
*    mo_cut = cl_ngc_core_cls_persistency=>get_instance( ).
*    mo_cut->mo_util_intersect = lo_cls_util_intersect.
*    mo_cut->mo_chr_persistency = lo_chr_persistency.
*
**--------------------------------------------------------------------*
**   Configure CHR Persistency calls
**--------------------------------------------------------------------*
*    DATA lt_charc TYPE ngct_core_charc.
*    lt_charc = VALUE #(
*      ( key_date         = '20170130'
*        charcinternalid  = '0000000001'
*        characteristic   = 'TEST_CHAR_01' )
*
*      ( key_date         = '20170130'
*        charcinternalid  = '0000000002'
*        characteristic   = 'TEST_CHAR_02' )
*
*      ( key_date         = '20170130'
*        charcinternalid  = '0000000003'
*        characteristic   = 'TEST_CHAR_03' )
*
*      ( key_date         = '20170130'
*        charcinternalid  = '0000000004'
*        characteristic   = 'TEST_CHAR_04' )
*
*      ( key_date         = '20170130'
*        charcinternalid  = '0000000005'
*        characteristic   = '' )
*
*      ( key_date         = '20170130'
*        charcinternalid  = '0000000006'
*        characteristic   = '' ) ).
*
*    DATA lt_charc_value TYPE ngct_core_charc_value.
*    lt_charc_value = VALUE #(
*      ( charcinternalid          = '0000000001'
*        key_date                 = '20170130'
*        charcvaluepositionnumber = '01'
*        charcvalue               = 'VALUE01' )
*
*      ( charcinternalid          = '0000000001'
*        key_date                 = '20170130'
*        charcvaluepositionnumber = '02'
*        charcvalue               = 'VALUE02' )
*
*      ( charcinternalid          = '0000000002'
*        key_date                 = '20170130'
*        charcvaluepositionnumber = '01'
*        charcvalue               = 'VALUE01' )
*
*      ( charcinternalid          = '0000000002'
*        key_date                 = '20170130'
*        charcvaluepositionnumber = '02'
*        charcvalue               = 'VALUE02' )
*
*      ( charcinternalid          = '0000000003'
*        key_date                 = '20170130'
*        charcvaluepositionnumber = '01'
*        charcvalue               = 'VALUE01' )
*
*      ( charcinternalid          = '0000000003'
*        key_date                 = '20170130'
*        charcvaluepositionnumber = '02'
*        charcvalue               = 'VALUE02' )
*
*      ( charcinternalid          = '0000000004'
*        key_date                 = '20170130'
*        charcvaluepositionnumber = '01'
*        charcvalue               = 'VALUE01' )
*
*      ( charcinternalid          = '0000000004'
*        key_date                 = '20170130'
*        charcvaluepositionnumber = '02'
*        charcvalue               = 'VALUE02' )
*
*      ( charcinternalid          = '0000000005'
*        key_date                 = '20170130'
*        charcvaluepositionnumber = '01'
*        charcvalue               = 'VALUE02' )
*
*      ( charcinternalid          = '0000000006'
*        key_date                 = '20170130'
*        charcvaluepositionnumber = '01'
*        charcvalue               = 'VALUE02' ) ).
*
*    cl_abap_testdouble=>configure_call(
*      mo_cut->mo_chr_persistency
*    )->ignore_parameter(
*      name = 'IV_LOCK'
*    )->set_parameter(
*      name  = 'ET_CHARACTERISTIC'
*      value = lt_charc
*    )->set_parameter(
*      name  = 'ET_CHARACTERISTIC_VALUE'
*      value = lt_charc_value
*    ).
*    mo_cut->mo_chr_persistency->read_by_internal_key(
*      it_key = VALUE ngct_core_charc_key( ( charcinternalid = '0000000001' key_date = '20170130' )
*                                          ( charcinternalid = '0000000002' key_date = '20170130' )
*                                          ( charcinternalid = '0000000003' key_date = '20170130' )
*                                          ( charcinternalid = '0000000004' key_date = '20170130' )
*                                          ( charcinternalid = '0000000005' key_date = '20170130' )
*                                          ( charcinternalid = '0000000006' key_date = '20170130' ) ) ).
*
*
*    DELETE lt_charc WHERE charcinternalid <> '0000000002'
*                      AND charcinternalid <> '0000000004'.
*    DELETE lt_charc_value WHERE charcinternalid <> '0000000002'
*                            AND charcinternalid <> '0000000004'.
*    cl_abap_testdouble=>configure_call(
*      mo_cut->mo_chr_persistency
*    )->ignore_parameter(
*      name = 'IV_LOCK'
*    )->set_parameter(
*      name  = 'ET_CHARACTERISTIC'
*      value = lt_charc
*    )->set_parameter(
*      name  = 'ET_CHARACTERISTIC_VALUE'
*      value = lt_charc_value
*    ).
*    mo_cut->mo_chr_persistency->read_by_internal_key(
*      it_key = VALUE ngct_core_charc_key( ( charcinternalid = '0000000002' key_date = '20170130' )
*                                          ( charcinternalid = '0000000004' key_date = '20170130' ) ) ).
*
**--------------------------------------------------------------------*
**   Configure intersection calculation calls
**--------------------------------------------------------------------*
*    cl_abap_testdouble=>configure_call( mo_cut->mo_util_intersect )->ignore_parameter( 'iv_charcdatatype' )->set_parameter(
*      name = 'es_collected_char_value'
*      value = VALUE ngcs_core_class_charc_inter(
*        classinternalid = '0000000001'
*        charcinternalid = '0000000004'
*        characteristic  = 'TEST_CHAR_04'
*        key_date        = '20170130'
*        charc_values    = VALUE #(
*          ( charcvaluepositionnumber = '001'
*            charcvalue               = 'VALUE01' )
*          ( charcvaluepositionnumber = '002'
*            charcvalue               = 'VALUE02' ) ) ) ).
*    mo_cut->mo_util_intersect->calculate_intersection(
*      iv_charcdatatype         = ''
*      it_collected_char_values = VALUE #(
*        ( classinternalid = '0000000001'
*          charcinternalid = '0000000004'
*          characteristic  = 'TEST_CHAR_04'
*          key_date        = '20170130'
*          charc_values    = VALUE #(
*            ( charcvaluepositionnumber = '001'
*              charcvalue               = 'VALUE01' )
*            ( charcvaluepositionnumber = '002'
*              charcvalue               = 'VALUE02' ) ) ) ) ).
*
*    cl_abap_testdouble=>configure_call( mo_cut->mo_util_intersect )->ignore_parameter( 'iv_charcdatatype' )->set_parameter(
*      name = 'es_collected_char_value'
*      value = VALUE ngcs_core_class_charc_inter(
*        classinternalid = '0000000001'
*        charcinternalid = '0000000004'
*        characteristic  = 'TEST_CHAR_04'
*        key_date        = '20170130'
*        charc_values    = VALUE #(
*          ( charcvaluepositionnumber = '001'
*            charcvalue               = 'VALUE01' )
*          ( charcvaluepositionnumber = '002'
*            charcvalue               = 'VALUE02' ) ) ) ).
*    mo_cut->mo_util_intersect->calculate_intersection(
*      iv_charcdatatype         = ''
*      it_collected_char_values = VALUE #(
*        ( classinternalid = '0000000001'
*          charcinternalid = '0000000004'
*          characteristic  = 'TEST_CHAR_04'
*          key_date        = '20170130'
*          charc_values    = VALUE #(
*            ( charcvaluepositionnumber = '001'
*              charcvalue               = 'VALUE01' )
*            ( charcvaluepositionnumber = '002'
*              charcvalue               = 'VALUE02' ) ) )
*        ( classinternalid = '0000000001'
*          charcinternalid = '0000000004'
*          characteristic  = 'TEST_CHAR_04'
*          key_date        = '20170130'
*          charc_values    = VALUE #(
*            ( charcvaluepositionnumber = '001'
*              charcvalue               = 'VALUE01' )
*            ( charcvaluepositionnumber = '002'
*              charcvalue               = 'VALUE02' ) ) ) ) ).
*
*  ENDMETHOD.
*
*
*  METHOD teardown.
*
*    cl_ngc_core_cls_persistency=>if_ngc_core_cls_persistency~cleanup( ).
*
*  ENDMETHOD.
*
*  METHOD read_intkey_nonexisting_class.
*
*    cl_abap_unit_assert=>assert_bound( act = mo_cut
*                                       msg = 'persistency instance not bound' ).
*
*    mo_cut->if_ngc_core_cls_persistency~read_by_internal_key(
*      EXPORTING it_keys    = VALUE #( ( classinternalid = lth_ngc_core_cls_pers_testdata=>gc_classinternalid_nonexisting
*                                        key_date        = '20170130' ) )
*                iv_lock    = abap_false
*      IMPORTING et_classes = DATA(lt_classes)
*                et_message = DATA(lt_message) ).
*
*    cl_abap_unit_assert=>assert_initial( act = lt_classes
*                                         msg = 'unexpected read data' ).
*
*    cl_abap_unit_assert=>assert_not_initial( act = lt_message
*                                             msg = 'unexpected read data' ).
*
*  ENDMETHOD.
*
*  METHOD read_intkey_one_exist_cls.
*
*    cl_abap_unit_assert=>assert_bound( act = mo_cut
*                                       msg = 'persistency instance not bound' ).
*
*    mo_cut->if_ngc_core_cls_persistency~read_by_internal_key(
*      EXPORTING it_keys                        = VALUE #( ( classinternalid = lth_ngc_core_cls_pers_testdata=>gc_classinternalid_one
*                                                            key_date        = '20170130' ) )
*                iv_lock                        = abap_false
*      IMPORTING et_classes                     = DATA(lt_classes)
*                et_class_characteristics       = DATA(lt_characteristics)
*                et_class_characteristic_values = DATA(lt_characeristic_values)
*                et_message                     = DATA(lt_message) ).
*
*    DATA(lt_expected_classes) = lth_ngc_core_cls_pers_testdata=>get_expected_core_class_data( iv_classinternalid = lth_ngc_core_cls_pers_testdata=>gc_classinternalid_one
*                                                                                              iv_key_date        = '20170130' ).
*
*    cl_abap_unit_assert=>assert_equals( act = lt_classes
*                                        exp = lt_expected_classes
*                                        msg = 'unexpected read data' ).
*
*    cl_abap_unit_assert=>assert_equals( act = lines( lt_characteristics )
*                                        exp = 4
*                                        msg = 'unexpected read data' ).
*
*    cl_abap_unit_assert=>assert_equals( act = lines( lt_characeristic_values )
*                                        exp = 5
*                                        msg = 'unexpected read data' ).
*
*    cl_abap_unit_assert=>assert_initial( act = lt_message
*                                         msg = 'unexpected messages' ).
*
*  ENDMETHOD.
*
*  METHOD read_intkey_one_exist_cls_chr.
*
*    DATA:
*          lt_message_all TYPE ngct_core_class_msg.
*
*    cl_abap_unit_assert=>assert_bound( act = mo_cut
*                                       msg = 'persistency instance not bound' ).
*
*    mo_cut->if_ngc_core_cls_persistency~read_by_internal_key(
*      EXPORTING it_keys    = VALUE #( ( classinternalid = lth_ngc_core_cls_pers_testdata=>gc_classinternalid_one
*                                        key_date        = '20170130' ) )
*                iv_lock    = abap_false
*      IMPORTING et_classes = DATA(lt_classes)
*                et_message = DATA(lt_message) ).
*
*    APPEND LINES OF lt_message TO lt_message_all.
*
*    mo_cut->if_ngc_core_cls_persistency~read_by_internal_key(
*      EXPORTING it_keys                        = VALUE #( ( classinternalid = lth_ngc_core_cls_pers_testdata=>gc_classinternalid_one
*                                                            key_date        = '20170130' ) )
*                iv_lock                        = abap_false
*      IMPORTING et_class_characteristics       = DATA(lt_characteristics)
*                et_class_characteristic_values = DATA(lt_characeristic_values)
*                et_characteristic_reference    = DATA(lt_characeristic_reference)
*                et_message = lt_message ).
*
*    APPEND LINES OF lt_message TO lt_message_all.
*
*    DATA(lt_expected_classes) = lth_ngc_core_cls_pers_testdata=>get_expected_core_class_data( iv_classinternalid = lth_ngc_core_cls_pers_testdata=>gc_classinternalid_one
*                                                                                              iv_key_date        = '20170130' ).
*
*    cl_abap_unit_assert=>assert_equals( act = lt_classes
*                                        exp = lt_expected_classes
*                                        msg = 'unexpected read data' ).
*
*    cl_abap_unit_assert=>assert_equals( act = lines( lt_characteristics )
*                                        exp = 4
*                                        msg = 'unexpected read data' ).
*
*    cl_abap_unit_assert=>assert_equals( act = lines( lt_characeristic_values )
*                                        exp = 5
*                                        msg = 'unexpected read data' ).
*
*    cl_abap_unit_assert=>assert_initial( act = lt_message_all
*                                         msg = 'unexpected messages' ).
*
*  ENDMETHOD.
*
*  METHOD read_intkey_two_existing_class.
*
*    cl_abap_unit_assert=>assert_bound( act = mo_cut
*                                       msg = 'persistency instance not bound' ).
*
*    mo_cut->if_ngc_core_cls_persistency~read_by_internal_key(
*      EXPORTING it_keys                        = VALUE #( ( classinternalid = lth_ngc_core_cls_pers_testdata=>gc_classinternalid_one key_date = '20170130' )
*                                                          ( classinternalid = lth_ngc_core_cls_pers_testdata=>gc_classinternalid_two key_date = '20170130' ) )
*                iv_lock                        = abap_false
*      IMPORTING et_classes                     = DATA(lt_classes)
*                et_class_characteristics       = DATA(lt_characteristics)
*                et_class_characteristic_values = DATA(lt_characeristic_values)
*                et_message                     = DATA(lt_message) ).
*
*    DATA(lt_expected_class) = VALUE ngct_core_class( ).
*
*    APPEND LINES OF lth_ngc_core_cls_pers_testdata=>get_expected_core_class_data( iv_classinternalid = lth_ngc_core_cls_pers_testdata=>gc_classinternalid_one
*                                                                                  iv_key_date        = '20170130' ) TO lt_expected_class.
*
*    APPEND LINES OF lth_ngc_core_cls_pers_testdata=>get_expected_core_class_data( iv_classinternalid = lth_ngc_core_cls_pers_testdata=>gc_classinternalid_two
*                                                                                  iv_key_date        = '20170130' ) TO lt_expected_class.
*
*    cl_abap_unit_assert=>assert_equals( act = lt_classes
*                                        exp = lt_expected_class
*                                        msg = 'unexpected read data' ).
*
*    cl_abap_unit_assert=>assert_equals( act = lines( lt_characteristics )
*                                        exp = 6
*                                        msg = 'unexpected read data' ).
*
*    cl_abap_unit_assert=>assert_equals( act = lines( lt_characeristic_values )
*                                        exp = 9
*                                        msg = 'unexpected read data' ).
*
*    cl_abap_unit_assert=>assert_initial( act = lt_message
*                                         msg = 'unexpected read data' ).
*
*  ENDMETHOD.
*
*  METHOD read_extkey_nonexisting_class.
*
*    cl_abap_unit_assert=>assert_bound( act = mo_cut
*                                       msg = 'persistency instance not bound' ).
*
*    mo_cut->if_ngc_core_cls_persistency~read_by_external_key(
*      EXPORTING it_keys    = VALUE #( ( classtype = lth_ngc_core_cls_pers_testdata=>gc_classtype_nonexisting
*                                        class     = lth_ngc_core_cls_pers_testdata=>gc_class_nonexisting
*                                        key_date  = '20170130' ) )
*                iv_lock    = abap_false
*      IMPORTING et_classes = DATA(lt_classes)
*                et_message = DATA(lt_core_message) ).
*
*    cl_abap_unit_assert=>assert_initial( act = lt_classes
*                                         msg = 'unexpected read data' ).
*
*    cl_abap_unit_assert=>assert_not_initial( act = lt_core_message
*                                             msg = 'unexpected messages' ).
*
*
*  ENDMETHOD.
*
*  METHOD read_extkey_one_exist_cls.
*
*    cl_abap_unit_assert=>assert_bound( act = mo_cut
*                                       msg = 'persistency instance not bound' ).
*
*    mo_cut->if_ngc_core_cls_persistency~read_by_external_key(
*      EXPORTING it_keys                        = VALUE #( ( classtype = lth_ngc_core_cls_pers_testdata=>gc_classtype_one
*                                                            class     = lth_ngc_core_cls_pers_testdata=>gc_class_one
*                                                            key_date  = '20170130' ) )
*                iv_lock                        = abap_false
*      IMPORTING et_classes                     = DATA(lt_classes)
*                et_message                     = DATA(lt_core_message) ).
*
*    DATA(lt_expected) = lth_ngc_core_cls_pers_testdata=>get_expected_core_class_data( iv_classinternalid = lth_ngc_core_cls_pers_testdata=>gc_classinternalid_one
*                                                                                      iv_key_date        = '20170130' ).
*
*    cl_abap_unit_assert=>assert_equals( act = lt_classes
*                                        exp = lt_expected
*                                        msg = 'unexpected read data' ).
*
*    cl_abap_unit_assert=>assert_initial( act = lt_core_message
*                                         msg = 'unexpected messages' ).
*
*  ENDMETHOD.
*
*  METHOD read_extkey_two_existing_class.
*
*    cl_abap_unit_assert=>assert_bound( act = mo_cut
*                                       msg = 'persistency instance not bound' ).
*
*    mo_cut->if_ngc_core_cls_persistency~read_by_external_key(
*      EXPORTING it_keys    = VALUE #( ( classtype = lth_ngc_core_cls_pers_testdata=>gc_classtype_one
*                                        class     = lth_ngc_core_cls_pers_testdata=>gc_class_one
*                                        key_date  = '20170130' )
*                                      ( classtype = lth_ngc_core_cls_pers_testdata=>gc_classtype_two
*                                        class     = lth_ngc_core_cls_pers_testdata=>gc_class_two
*                                        key_date  = '20170130' ) )
*                iv_lock    = abap_false
*      IMPORTING et_classes = DATA(lt_classes)
*                et_message = DATA(lt_core_message) ).
*
*    DATA(lt_expected_class) = VALUE ngct_core_class( ).
*
*    APPEND LINES OF lth_ngc_core_cls_pers_testdata=>get_expected_core_class_data( iv_classinternalid = lth_ngc_core_cls_pers_testdata=>gc_classinternalid_one
*                                                                                  iv_key_date        = '20170130' ) TO lt_expected_class.
*
*    APPEND LINES OF lth_ngc_core_cls_pers_testdata=>get_expected_core_class_data( iv_classinternalid = lth_ngc_core_cls_pers_testdata=>gc_classinternalid_two
*                                                                                  iv_key_date        = '20170130' ) TO lt_expected_class.
*
*    cl_abap_unit_assert=>assert_equals( act = lt_classes
*                                        exp = lt_expected_class
*                                        msg = 'unexpected read data' ).
*
*    cl_abap_unit_assert=>assert_initial( act = lt_core_message
*                                         msg = 'unexpected messages' ).
*
*  ENDMETHOD.
*
*  METHOD read_class_status.
*
*    cl_abap_unit_assert=>assert_bound( act = mo_cut
*                                       msg = 'persistency instance not bound' ).
*
*    TEST-INJECTION select_class_status.
*      mt_class_status = VALUE #(
*        ( classtype               = '001'
*          classstatus             = '1'
*          classificationisallowed = abap_true
*          classstatusname         = 'Released' )
*        ( classtype               = '001'
*          classstatus             = '2'
*          classificationisallowed = abap_false
*          classstatusname         = 'Locked' )
*        ( classtype               = '300'
*          classstatus             = '1'
*          classificationisallowed = abap_true
*          classstatusname         = 'Released' ) ).
*    END-TEST-INJECTION.
*
*    DATA(ls_expected_status) = VALUE ngcs_core_class_status(
*      classtype               = '001'
*      classstatus             = '1'
*      classificationisallowed = abap_true
*      classstatusname         = 'Released' ).
*    DATA(ls_status) = mo_cut->if_ngc_core_cls_persistency~read_class_status( iv_classstatus = '1' iv_classtype = '001' ).
*
*    cl_abap_unit_assert=>assert_equals(
*      act = ls_status
*      exp = ls_expected_status
*      msg = 'Incorrect status returned' ).
*
*  ENDMETHOD.
*
*  METHOD read_class_statuses.
*
*    cl_abap_unit_assert=>assert_bound( act = mo_cut
*                                       msg = 'persistency instance not bound' ).
*
*    TEST-INJECTION select_class_status.
*      mt_class_status = VALUE #(
*        ( classtype               = '001'
*          classstatus             = '1'
*          classificationisallowed = abap_true
*          classstatusname         = 'Released' )
*        ( classtype               = '001'
*          classstatus             = '2'
*          classificationisallowed = abap_false
*          classstatusname         = 'Locked' )
*        ( classtype               = '300'
*          classstatus             = '1'
*          classificationisallowed = abap_true
*          classstatusname         = 'Released' ) ).
*    END-TEST-INJECTION.
*
*    DATA(lt_expected_statuses) = VALUE ngct_core_class_status(
*      ( classtype               = '001'
*        classstatus             = '1'
*        classificationisallowed = abap_true
*        classstatusname         = 'Released' )
*      ( classtype               = '001'
*        classstatus             = '2'
*        classificationisallowed = abap_false
*        classstatusname         = 'Locked' ) ).
*    DATA(lt_statuses) = mo_cut->if_ngc_core_cls_persistency~read_class_statuses( iv_classtype = '001' ).
*
*    cl_abap_unit_assert=>assert_equals(
*      act = lt_statuses
*      exp = lt_expected_statuses
*      msg = 'Incorrect status returned' ).
*
*  ENDMETHOD.
*
*  METHOD check_org_area.
*
*    DATA: lt_class_hier_charc TYPE ngct_core_class_characteristic,
*          lt_expected         TYPE ngct_core_class_characteristic.
*
*
*    mo_cut->mt_org_area_w_auth = VALUE #(
*      ( classtype                = '001'
*        clfnorganizationalareaid = 'Z' )
*      ( classtype                = '001'
*        clfnorganizationalareaid = 'Y' ) ).
*    mo_cut->mt_org_area_w_disp_auth = VALUE #(
*      ( classtype                = '001'
*        clfnorganizationalareaid = 'X' )
*      ( classtype                = '001'
*        clfnorganizationalareaid = 'Y' ) ).
*
*    lt_class_hier_charc = VALUE #(
*      ( classtype               = '001'
*        characteristic          = 'TEST_01'
*        charcisreadonly         = ''
*        charcishidden           = ''
*        clfnorganizationalarea  = 'X' )
*      ( classtype               = '001'
*        characteristic          = 'TEST_02'
*        charcisreadonly         = ''
*        charcishidden           = ''
*        clfnorganizationalarea  = 'ZY' )
*      ( classtype               = '001'
*        characteristic          = 'TEST_03'
*        charcisreadonly         = ''
*        charcishidden           = ''
*        clfnorganizationalarea  = 'QZ' )
*      ( classtype               = '001'
*        characteristic          = 'TEST_04'
*        charcisreadonly         = ''
*        charcishidden           = ''
*        clfnorganizationalarea  = 'QXZY' )
*        ).
*
*    mo_cut->check_org_area( CHANGING ct_class_characteristic = lt_class_hier_charc ).
*
*    lt_expected = VALUE #(
*      ( classtype               = '001'
*        characteristic          = 'TEST_01'
*        charcisreadonly         = ''
*        charcishidden           = 'X'
*        clfnorganizationalarea  = 'X' )
*      ( classtype               = '001'
*        characteristic          = 'TEST_02'
*        charcisreadonly         = ''
*        charcishidden           = ''
*        clfnorganizationalarea  = 'ZY' )
*      ( classtype               = '001'
*        characteristic          = 'TEST_03'
*        charcisreadonly         = 'X'
*        charcishidden           = ''
*        clfnorganizationalarea  = 'QZ' )
*      ( classtype               = '001'
*        characteristic          = 'TEST_04'
*        charcisreadonly         = ''
*        charcishidden           = ''
*        clfnorganizationalarea  = 'QXZY' )
*        ).
*
*    cl_abap_unit_assert=>assert_equals(
*      act = lt_class_hier_charc
*      exp = lt_expected
*      msg = 'Incorrect organization area check' ).
*
*  ENDMETHOD.
*
*ENDCLASS.