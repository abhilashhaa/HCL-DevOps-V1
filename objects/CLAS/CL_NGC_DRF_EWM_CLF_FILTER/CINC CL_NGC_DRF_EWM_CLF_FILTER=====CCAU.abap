*"* use this source file for your ABAP unit test classes

CLASS lth_ngc_clfmas_drf_filter DEFINITION FINAL FOR TESTING.
  PUBLIC SECTION.
    CLASS-DATA:
      gt_clf_key TYPE ngct_drf_clfmas_object_key.
    CLASS-METHODS: class_constructor.
ENDCLASS.

CLASS lth_ngc_clfmas_drf_filter IMPLEMENTATION.
  METHOD class_constructor.
    gt_clf_key = VALUE #( ( object_table = if_ngc_drf_c=>gc_batch_mat_level_dbtable
                            klart        = if_ngc_drf_c=>gc_batch_classtype_mat_level
                            objkey       = 'TEST1' )
                          ( object_table = if_ngc_drf_c=>gc_product_header_dbtable
                            klart        = if_ngc_drf_c=>gc_batch_classtype_mat_level
                            objkey       = 'TEST2' )
                          ( object_table = if_ngc_drf_c=>gc_product_header_dbtable
                            klart        = if_ngc_drf_c=>gc_batch_classtype_mat_level
                            objkey       = 'TEST3' ) ).
  ENDMETHOD.
ENDCLASS.


CLASS ltd_ngc_drf_ewm_utility DEFINITION FOR TESTING FINAL.
  PUBLIC SECTION.
    INTERFACES if_ngc_drf_ewm_util PARTIALLY IMPLEMENTED.
ENDCLASS.

CLASS ltd_ngc_drf_ewm_utility IMPLEMENTATION.
  METHOD if_ngc_drf_ewm_util~get_selected_classifications.
    CLEAR: et_clf_key.
    READ TABLE it_range_class TRANSPORTING NO FIELDS WITH KEY sign = 'I' option = 'EQ' low = 'TESTCLASS'.
    IF sy-subrc = 0.
      LOOP AT lth_ngc_clfmas_drf_filter=>gt_clf_key ASSIGNING FIELD-SYMBOL(<ls_clf_key>)
      WHERE object_table IN it_range_obtab AND klart IN it_range_klart AND objkey IN it_range_matnr.
        APPEND <ls_clf_key> TO et_clf_key.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.
  METHOD if_ngc_drf_ewm_util~get_object_filter ##NEEDED.
  ENDMETHOD.
ENDCLASS.

CLASS ltc_ngc_drf_ewm_clf_filter DEFINITION DEFERRED.
CLASS cl_ngc_drf_ewm_clf_filter DEFINITION LOCAL FRIENDS ltc_ngc_drf_ewm_clf_filter.

CLASS ltc_ngc_drf_ewm_clf_filter DEFINITION FOR TESTING FINAL
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      f_cut TYPE REF TO cl_ngc_drf_ewm_clf_filter.  "class under test

    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.
    METHODS: apply_filter FOR TESTING.
ENDCLASS.       "ltc_ngc_drf_ewm_clf_filter


CLASS ltc_ngc_drf_ewm_clf_filter IMPLEMENTATION.

  METHOD class_setup.
  ENDMETHOD.


  METHOD class_teardown.
  ENDMETHOD.


  METHOD setup.
    CREATE OBJECT f_cut.
    CREATE OBJECT f_cut->mo_ngc_drf_ewm_util TYPE ltd_ngc_drf_ewm_utility.
  ENDMETHOD.


  METHOD teardown.
  ENDMETHOD.


  METHOD apply_filter.

    DATA:
      io_bal                  TYPE REF TO cl_drf_bal ##NEEDED,
      et_filtered_objects_act TYPE ngct_drf_clfmas_object_key,
      et_filtered_objects_exp TYPE ngct_drf_clfmas_object_key.

    f_cut->if_drf_filter~apply_filter(
      EXPORTING
        iv_appl               = ''
        iv_business_system    = ''
        is_c_fobj             = VALUE #( )
        iv_outb_impl          = if_ngc_drf_c=>gc_clf_ewm_drf_outb_impl
        iv_dlmod              = ''
        iv_runmod             = ''
        is_filt               = VALUE #( strucname = 'NGCS_DRF_CLFMAS_OBJECT_KEY' )
        io_bal                = io_bal
        it_external_criteria  = VALUE #(
                                  ( tablename = 'NGCS_DRF_CLFMAS_OBJECT_KEY'
                                    frange_t  = VALUE #(
                                      ( fieldname = 'CLASS'
                                        selopt_t  = VALUE #(
                                          ( sign = 'I' option = 'EQ' low = 'TESTCLASS' )
                                        )
                                      )
                                      ( fieldname = 'MATNR'
                                        selopt_t  = VALUE #(
                                          ( sign = 'I' option = 'EQ' low = 'TEST1' )
                                        )
                                      )
                                      ( fieldname = 'LGNUM'
                                        selopt_t  = VALUE #(
                                          ( sign = 'I' option = 'EQ' low = 'EWM' )
                                        )
                                      )
                                    )
                                  )
                                )
        it_unfiltered_objects = lth_ngc_clfmas_drf_filter=>gt_clf_key
      IMPORTING
        et_filtered_objects   = et_filtered_objects_act
    ).

    et_filtered_objects_exp = lth_ngc_clfmas_drf_filter=>gt_clf_key.
    DELETE et_filtered_objects_exp WHERE object_table <> if_ngc_drf_c=>gc_batch_mat_level_dbtable.

    cl_abap_unit_assert=>assert_equals(
      act   = et_filtered_objects_act
      exp   = et_filtered_objects_exp
      msg   = 'apply_filter: et_filtered_objects is not valid'
    ).

  ENDMETHOD.

ENDCLASS.