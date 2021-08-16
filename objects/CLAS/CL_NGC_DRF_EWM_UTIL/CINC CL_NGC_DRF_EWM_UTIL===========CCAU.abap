*"* use this source file for your ABAP unit test classes

CLASS lth_data DEFINITION FINAL FOR TESTING.
  PUBLIC SECTION.
    CLASS-DATA:
      gt_tcme_start      TYPE tt_tcme,
      gt_tcme_exp        TYPE tt_tcme,
      gt_tcme_exp_2      TYPE tt_tcme,
      gt_klah_start      TYPE tt_klah,
      gt_klah_exp        TYPE tt_klah,
      gt_klah_exp_2      TYPE tt_klah,
      gt_ksml_start      TYPE tt_ksml,
      gt_ksml_exp        TYPE tt_ksml,
      gt_ksml_exp_2      TYPE tt_ksml,
      gt_unf_obj_key     TYPE ngct_drf_clfmas_object_key,
      gt_unf_obj_whr_exp TYPE string.
    CLASS-METHODS: class_constructor.
ENDCLASS.

CLASS lth_data IMPLEMENTATION.
  METHOD class_constructor.
    APPEND INITIAL LINE TO gt_tcme_start ASSIGNING FIELD-SYMBOL(<gs_tcme_start>).
    <gs_tcme_start>-atinn = 1.
    <gs_tcme_start>-klart = '001'.
    APPEND INITIAL LINE TO gt_tcme_start ASSIGNING <gs_tcme_start>.
    <gs_tcme_start>-atinn = 2.
    <gs_tcme_start>-klart = '230'.
    APPEND INITIAL LINE TO gt_tcme_start ASSIGNING <gs_tcme_start>.
    <gs_tcme_start>-atinn = 3.
    <gs_tcme_start>-klart = '025'.
    APPEND INITIAL LINE TO gt_tcme_start ASSIGNING <gs_tcme_start>.
    <gs_tcme_start>-atinn = 4.
    <gs_tcme_start>-klart = '300'.
    APPEND INITIAL LINE TO gt_tcme_start ASSIGNING <gs_tcme_start>.
    <gs_tcme_start>-atinn = 5.
    <gs_tcme_start>-klart = '400'.
    APPEND INITIAL LINE TO gt_tcme_exp ASSIGNING FIELD-SYMBOL(<gs_tcme_exp>).
    <gs_tcme_exp>-atinn = 1.
    <gs_tcme_exp>-klart = '001'.
    APPEND INITIAL LINE TO gt_tcme_exp ASSIGNING <gs_tcme_exp>.
    <gs_tcme_exp>-atinn = 2.
    <gs_tcme_exp>-klart = '230'.
    APPEND INITIAL LINE TO gt_tcme_exp ASSIGNING <gs_tcme_exp>.
    <gs_tcme_exp>-atinn = 4.
    <gs_tcme_exp>-klart = '300'.
    APPEND INITIAL LINE TO gt_tcme_exp_2 ASSIGNING FIELD-SYMBOL(<gs_tcme_exp_2>).
    <gs_tcme_exp_2>-atinn = 1.
    <gs_tcme_exp_2>-klart = '001'.
    APPEND INITIAL LINE TO gt_tcme_exp_2 ASSIGNING <gs_tcme_exp_2>.
    <gs_tcme_exp_2>-atinn = 2.
    <gs_tcme_exp_2>-klart = '230'.
    APPEND INITIAL LINE TO gt_tcme_exp_2 ASSIGNING <gs_tcme_exp_2>.
    <gs_tcme_exp_2>-atinn = 3.
    <gs_tcme_exp_2>-klart = '026'.
    APPEND INITIAL LINE TO gt_tcme_exp_2 ASSIGNING <gs_tcme_exp_2>.
    <gs_tcme_exp_2>-atinn = 4.
    <gs_tcme_exp_2>-klart = '300'.
    APPEND INITIAL LINE TO gt_tcme_exp_2 ASSIGNING <gs_tcme_exp_2>.
    <gs_tcme_exp_2>-atinn = 5.
    <gs_tcme_exp_2>-klart = '400'.

    APPEND INITIAL LINE TO gt_klah_start ASSIGNING FIELD-SYMBOL(<gs_klah_start>).
    <gs_klah_start>-klart = '001'.
    APPEND INITIAL LINE TO gt_klah_start ASSIGNING <gs_klah_start>.
    <gs_klah_start>-klart = '022'.
    APPEND INITIAL LINE TO gt_ksml_start ASSIGNING FIELD-SYMBOL(<gs_ksml_start>).
    <gs_ksml_start>-klart = '001'.
    APPEND INITIAL LINE TO gt_ksml_start ASSIGNING <gs_ksml_start>.
    <gs_ksml_start>-klart = '022'.
    APPEND INITIAL LINE TO gt_klah_exp ASSIGNING FIELD-SYMBOL(<gs_klah_exp>).
    <gs_klah_exp>-klart = '001'.
    APPEND INITIAL LINE TO gt_ksml_exp ASSIGNING FIELD-SYMBOL(<gs_ksml_exp>).
    <gs_ksml_exp>-klart = '001'.
    APPEND INITIAL LINE TO gt_klah_exp_2 ASSIGNING FIELD-SYMBOL(<gs_klah_exp_2>).
    <gs_klah_exp_2>-klart = '001'.
    APPEND INITIAL LINE TO gt_klah_exp_2 ASSIGNING <gs_klah_exp_2>.
    <gs_klah_exp_2>-klart = '023'.
    APPEND INITIAL LINE TO gt_ksml_exp_2 ASSIGNING FIELD-SYMBOL(<gs_ksml_exp_2>).
    <gs_ksml_exp_2>-klart = '001'.
    APPEND INITIAL LINE TO gt_ksml_exp_2 ASSIGNING <gs_ksml_exp_2>.
    <gs_ksml_exp_2>-klart = '023'.
    gt_unf_obj_key = VALUE #( ( object_table = ''
                            klart        = if_ngc_drf_c=>gc_batch_classtype_mat_level
                            objkey       = 'TEST1*' )
                          ( object_table = if_ngc_drf_c=>gc_product_header_dbtable
                            klart        = if_ngc_drf_c=>gc_batch_classtype_mat_level
                            objkey       = '' )
                          ( object_table = if_ngc_drf_c=>gc_product_header_dbtable
                            klart        = ''
                            objkey       = `*TEST'3*` ) ).
    gt_unf_obj_whr_exp = `( ( klart EQ '023' ) AND ( objek LIKE 'TEST1%' ) ) OR ( ( obtab EQ 'MARA' ) AND ( objek LIKE '%TEST''3%' ) ) OR ( ( obtab EQ 'MARA' ) AND ( klart EQ '023' ) )`.
  ENDMETHOD.
ENDCLASS.

CLASS ltc_ngc_drf_ewm_util DEFINITION DEFERRED.
CLASS cl_ngc_drf_ewm_util DEFINITION LOCAL FRIENDS ltc_ngc_drf_ewm_util.

CLASS ltc_ngc_drf_ewm_util DEFINITION FOR TESTING FINAL
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      f_cut TYPE REF TO cl_ngc_drf_ewm_util.  "class under test

    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.

    METHODS: apo_irrelevant_tcme FOR TESTING.
    METHODS: apo_irrelevant_types_class FOR TESTING.
    METHODS: change_classtype_class FOR TESTING.
    METHODS: change_classtype_tcme FOR TESTING.
    METHODS: get_object_filter FOR TESTING.
ENDCLASS.       "ltc_ngc_drf_ewm_util


CLASS ltc_ngc_drf_ewm_util IMPLEMENTATION.

  METHOD class_setup.
  ENDMETHOD.


  METHOD class_teardown.
  ENDMETHOD.


  METHOD setup.
    f_cut ?= cl_ngc_drf_ewm_util=>get_instance( ).
*    CREATE OBJECT f_cut->mo_db_access TYPE ltd_db_access.
  ENDMETHOD.


  METHOD teardown.
  ENDMETHOD.


  METHOD apo_irrelevant_tcme.
    DATA:
      lt_tcme       TYPE tt_tcme,
      ls_ctrlparams TYPE cifctrlpar.

    lt_tcme = lth_data=>gt_tcme_start.
    f_cut->if_ngc_drf_ewm_util~apo_irrelevant_tcme(
      CHANGING
        ct_tcme       = lt_tcme
        cs_ctrlparams = ls_ctrlparams
    ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_tcme
      exp = lth_data=>gt_tcme_exp
    ).
  ENDMETHOD.

  METHOD apo_irrelevant_types_class.
    DATA:
      lt_klah       TYPE tt_klah,
      lt_ksml       TYPE tt_ksml,
      ls_ctrlparams TYPE cifctrlpar.

    lt_klah = lth_data=>gt_klah_start.
    lt_ksml = lth_data=>gt_ksml_start.
    f_cut->if_ngc_drf_ewm_util~apo_irrelevant_types_class(
      CHANGING
        ct_klah       = lt_klah
        ct_ksml       = lt_ksml
        cs_ctrlparams = ls_ctrlparams
    ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_klah
      exp = lth_data=>gt_klah_exp
    ).
    cl_abap_unit_assert=>assert_equals(
      act = lt_ksml
      exp = lth_data=>gt_ksml_exp
    ).
  ENDMETHOD.

  METHOD change_classtype_class.
    DATA:
      lt_klah       TYPE tt_klah,
      lt_ksml       TYPE tt_ksml,
      ls_ctrlparams TYPE cifctrlpar.

    lt_klah = lth_data=>gt_klah_start.
    lt_ksml = lth_data=>gt_ksml_start.
    f_cut->if_ngc_drf_ewm_util~change_classtype_class(
      EXPORTING
        iv_class_type_from = '022'
        iv_class_type_to   = '023'
        is_ctrlparams      = ls_ctrlparams
      CHANGING
        ct_klah            = lt_klah
        ct_ksml            = lt_ksml
    ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_klah
      exp = lth_data=>gt_klah_exp_2
    ).
    cl_abap_unit_assert=>assert_equals(
      act = lt_ksml
      exp = lth_data=>gt_ksml_exp_2
    ).
  ENDMETHOD.

  METHOD change_classtype_tcme.
    DATA:
      lt_tcme       TYPE tt_tcme,
      ls_ctrlparams TYPE cifctrlpar.

    lt_tcme = lth_data=>gt_tcme_start.
    f_cut->if_ngc_drf_ewm_util~change_classtype_tcme(
      EXPORTING
        iv_class_type_from = '025'
        iv_class_type_to   = '026'
      CHANGING
        ct_tcme            = lt_tcme
        cs_ctrlparams      = ls_ctrlparams
    ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_tcme
      exp = lth_data=>gt_tcme_exp_2
    ).
  ENDMETHOD.

  METHOD get_object_filter.
    DATA:
      lv_where_cond         TYPE string.

    lv_where_cond = f_cut->if_ngc_drf_ewm_util~get_object_filter(
      EXPORTING
        it_unfiltered_objects = lth_data=>gt_unf_obj_key
        it_field_names        = VALUE #( ( key_filter_field_name = 'object_table'
                                           check_against_name    = 'obtab' )
                                         ( key_filter_field_name = 'klart'
                                           check_against_name    = 'klart' )
                                         ( key_filter_field_name = 'objkey'
                                           check_against_name    = 'objek' ) )
    ).

    cl_abap_unit_assert=>assert_equals(
      act = lv_where_cond
      exp = lth_data=>gt_unf_obj_whr_exp
    ).
  ENDMETHOD.

ENDCLASS.