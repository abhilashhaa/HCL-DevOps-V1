*"* use this source file for your ABAP unit test classes

CLASS lth_ngc_clfmas_drf_filter DEFINITION FINAL.
  PUBLIC SECTION.
    CLASS-DATA: gt_clf_key TYPE ngct_drf_clfmas_object_key.
    CLASS-METHODS: class_constructor.
ENDCLASS.

CLASS lth_ngc_clfmas_drf_filter IMPLEMENTATION.
  METHOD class_constructor.
    gt_clf_key = VALUE #( ( object_table = 'MARA'
                            klart        = '001'
                            objkey       = 'TEST1' )
                          ( object_table = 'MARA'
                            klart        = '001'
                            objkey       = 'TEST2' )
                          ( object_table = 'MARA'
                            klart        = '300'
                            objkey       = 'TEST3' ) ).
  ENDMETHOD.
ENDCLASS.


CLASS ltd_ngc_drf_utility DEFINITION FOR TESTING.
  PUBLIC SECTION.
    INTERFACES if_ngc_drf_util PARTIALLY IMPLEMENTED.
ENDCLASS.

CLASS ltd_ngc_drf_utility IMPLEMENTATION.
  METHOD if_ngc_drf_util~get_selected_classifications.
    CLEAR: et_clf_key.
    READ TABLE it_selection_criteria ASSIGNING FIELD-SYMBOL(<ls_selection_criteria>)
      WITH KEY tablename = 'KSSK'.
    IF sy-subrc = 0.
      READ TABLE <ls_selection_criteria>-frange_t ASSIGNING FIELD-SYMBOL(<ls_frange_t>) WITH KEY fieldname = 'KSSK~KLART'.
      IF sy-subrc = 0.
        READ TABLE <ls_frange_t>-selopt_t ASSIGNING FIELD-SYMBOL(<ls_selopt_t>) WITH KEY sign = 'I' option = 'EQ'.
        IF sy-subrc = 0.
          LOOP AT lth_ngc_clfmas_drf_filter=>gt_clf_key ASSIGNING FIELD-SYMBOL(<ls_clf_key>) WHERE klart = <ls_selopt_t>-low.
            APPEND <ls_clf_key> TO et_clf_key.
          ENDLOOP.
        ELSE.
          READ TABLE <ls_frange_t>-selopt_t ASSIGNING <ls_selopt_t> WITH KEY sign = 'I' option = 'CP' low = '*'.
          IF sy-subrc = 0.
            et_clf_key = lth_ngc_clfmas_drf_filter=>gt_clf_key.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

CLASS ltc_ngc_clfmas_drf_filter DEFINITION DEFERRED.
CLASS cl_ngc_drf_clfmas_filter DEFINITION LOCAL FRIENDS ltc_ngc_clfmas_drf_filter.

CLASS ltc_ngc_clfmas_drf_filter DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      f_cut TYPE REF TO cl_ngc_drf_clfmas_filter.  "class under test

    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.
    METHODS: apply_filter_clstyp_001 FOR TESTING.
    METHODS: apply_filter_all FOR TESTING.
ENDCLASS.       "ltc_ngc_clfmas_drf_filter


CLASS ltc_ngc_clfmas_drf_filter IMPLEMENTATION.

  METHOD class_setup.
  ENDMETHOD.


  METHOD class_teardown.
  ENDMETHOD.


  METHOD setup.
    CREATE OBJECT f_cut.
    CREATE OBJECT f_cut->mo_ngc_drf_util TYPE ltd_ngc_drf_utility.
  ENDMETHOD.


  METHOD teardown.
  ENDMETHOD.


  METHOD apply_filter_clstyp_001.

    DATA:
      io_bal                  TYPE REF TO cl_drf_bal,
      it_unfiltered_objects   TYPE ngct_drf_clfmas_object_key,
      et_filtered_objects_act TYPE ngct_drf_clfmas_object_key,
      et_filtered_objects_exp TYPE ngct_drf_clfmas_object_key.

    f_cut->if_drf_filter~apply_filter(
      EXPORTING
        iv_appl               = ''
        iv_business_system    = ''
        is_c_fobj             = VALUE #( )
        iv_outb_impl          = 'CLF_CLFMAS'
        iv_dlmod              = ''
        iv_runmod             = ''
        is_filt               = VALUE #( )
        io_bal                = io_bal
        it_external_criteria  = VALUE #(
                                  ( tablename = 'KSSK'
                                    frange_t  = VALUE #(
                                      ( fieldname = 'KLART'
                                        selopt_t  = VALUE #(
                                          ( sign = 'I' option = 'EQ' low = '001' )
                                        )
                                      )
                                    )
                                  )
                                )
        it_unfiltered_objects = it_unfiltered_objects
*       IS_ADDITIONAL_PARAMETER =
      IMPORTING
        et_filtered_objects   = et_filtered_objects_act
    ).

    et_filtered_objects_exp = lth_ngc_clfmas_drf_filter=>gt_clf_key.
    DELETE et_filtered_objects_exp WHERE klart <> '001'.

    cl_abap_unit_assert=>assert_equals(
      act   = et_filtered_objects_act
      exp   = et_filtered_objects_exp
      msg   = 'apply_filter: et_filtered_objects is not valid'
    ).

  ENDMETHOD.

  METHOD apply_filter_all.

    DATA:
      io_bal                  TYPE REF TO cl_drf_bal,
      it_unfiltered_objects   TYPE ngct_drf_clfmas_object_key,
      et_filtered_objects_act TYPE ngct_drf_clfmas_object_key,
      et_filtered_objects_exp TYPE ngct_drf_clfmas_object_key.

    f_cut->if_drf_filter~apply_filter(
      EXPORTING
        iv_appl               = ''
        iv_business_system    = ''
        is_c_fobj             = VALUE #( )
        iv_outb_impl          = 'CLF_CLFMAS'
        iv_dlmod              = ''
        iv_runmod             = ''
        is_filt               = VALUE #( )
        io_bal                = io_bal
        it_external_criteria  = VALUE #( )
        it_unfiltered_objects = it_unfiltered_objects
*       IS_ADDITIONAL_PARAMETER =
      IMPORTING
        et_filtered_objects   = et_filtered_objects_act
    ).

    et_filtered_objects_exp = lth_ngc_clfmas_drf_filter=>gt_clf_key.

    cl_abap_unit_assert=>assert_equals(
      act   = et_filtered_objects_act
      exp   = et_filtered_objects_exp
      msg   = 'apply_filter: et_filtered_objects is not valid'
    ).

  ENDMETHOD.

ENDCLASS.