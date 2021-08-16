**"* use this source file for your ABAP unit test classes

CLASS lth_ngc_drf_ewm_chr_filter DEFINITION FINAL FOR TESTING.
  PUBLIC SECTION.
    CLASS-DATA:
      gt_cls_key TYPE ngct_drf_clsmas_object_key,
      gt_chr_key TYPE ngct_drf_chrmas_object_key.
    CLASS-METHODS: class_constructor.
ENDCLASS.

CLASS lth_ngc_drf_ewm_chr_filter IMPLEMENTATION.
  METHOD class_constructor.
    gt_cls_key = VALUE #( ( klart        = if_ngc_drf_c=>gc_batch_classtype_mat_level
                            class        = 'TEST1' )
                          ( klart        = if_ngc_drf_c=>gc_batch_classtype_mat_level
                            class        = 'TEST2' )
                          ( klart        = if_ngc_drf_c=>gc_batch_classtype_mat_level
                            class        = 'TEST3' )
                          ( klart        = '001'
                            class        = 'TEST1' ) ).
    gt_chr_key = VALUE #( ( atnam        = 'TEST1' )
                          ( atnam        = 'TEST2' ) ).
  ENDMETHOD.
ENDCLASS.

CLASS ltd_ngc_drf_ewm_utility DEFINITION FOR TESTING FINAL.
  PUBLIC SECTION.
    INTERFACES if_ngc_drf_ewm_util PARTIALLY IMPLEMENTED.
ENDCLASS.

CLASS ltd_ngc_drf_ewm_utility IMPLEMENTATION.
  METHOD if_ngc_drf_ewm_util~get_selected_characteristics.
    CLEAR: et_chr_key.
    LOOP AT lth_ngc_drf_ewm_chr_filter=>gt_cls_key ASSIGNING FIELD-SYMBOL(<ls_cls_key>) WHERE klart IN it_range_klart AND class IN it_range_class.
      LOOP AT lth_ngc_drf_ewm_chr_filter=>gt_chr_key ASSIGNING FIELD-SYMBOL(<ls_chr_key>) WHERE atnam IN it_range_atnam AND atnam = <ls_cls_key>-class.
        APPEND <ls_chr_key> TO et_chr_key.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.
  METHOD if_ngc_drf_ewm_util~get_object_filter ##NEEDED.
  ENDMETHOD.
ENDCLASS.

CLASS ltc_ngc_drf_ewm_chr_filter DEFINITION DEFERRED.
CLASS cl_ngc_drf_ewm_chr_filter DEFINITION LOCAL FRIENDS ltc_ngc_drf_ewm_chr_filter.

CLASS ltc_ngc_drf_ewm_chr_filter DEFINITION FOR TESTING FINAL
DURATION SHORT
RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      f_cut TYPE REF TO cl_ngc_drf_ewm_chr_filter.  "class under test

    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.
    METHODS: apply_filter FOR TESTING.
ENDCLASS.

CLASS ltc_ngc_drf_ewm_chr_filter IMPLEMENTATION.

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
      lo_bal                  TYPE REF TO cl_drf_bal ##NEEDED,
      lt_filtered_objects_act TYPE ngct_drf_chrmas_object_key,
      lt_filtered_objects_exp TYPE ngct_drf_chrmas_object_key.

    f_cut->if_drf_filter~apply_filter(
      EXPORTING
        iv_appl               = ''
        iv_business_system    = ''
        is_c_fobj             = VALUE #( )
        iv_outb_impl          = if_ngc_drf_c=>gc_chr_ewm_drf_outb_impl
        iv_dlmod              = ''
        iv_runmod             = ''
        is_filt               = VALUE #( strucname = 'NGCS_DRF_CHRMAS_OBJECT_KEY' )
        io_bal                = lo_bal
        it_external_criteria  = VALUE #(
                                  ( tablename = 'NGCS_DRF_CHRMAS_OBJECT_KEY'
                                    frange_t  = VALUE #(
                                      ( fieldname = 'ATNAM'
                                        selopt_t  = VALUE #(
                                          ( sign = 'I' option = 'EQ' low = 'TEST1' )
                                          ( sign = 'I' option = 'EQ' low = 'TEST2' )
                                        )
                                      )
                                      ( fieldname = 'CLASS'
                                        selopt_t  = VALUE #(
                                          ( sign = 'I' option = 'EQ' low = 'TEST1' )
                                        )
                                      )
                                    )
                                  )
                                )
        it_unfiltered_objects = lth_ngc_drf_ewm_chr_filter=>gt_chr_key
      IMPORTING
        et_filtered_objects   = lt_filtered_objects_act
    ).

    lt_filtered_objects_exp = lth_ngc_drf_ewm_chr_filter=>gt_chr_key.
    DELETE lt_filtered_objects_exp WHERE atnam <> 'TEST1'.

    cl_abap_unit_assert=>assert_equals(
      act   = lt_filtered_objects_act
      exp   = lt_filtered_objects_exp
      msg   = 'apply_filter: et_filtered_objects is not valid'
    ).

  ENDMETHOD.

ENDCLASS.