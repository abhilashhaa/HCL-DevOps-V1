CLASS ltc_set_ewm_relevant DEFINITION
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS
  FINAL.

  PRIVATE SECTION.
    METHODS:
      setup,
      teardown,
      set_ewm_relevant_okay  FOR TESTING,
      set_ewm_relevant_error FOR TESTING,
      set_class_error        FOR TESTING.

    DATA mo_cut               TYPE REF TO /smb/if_activity_abap.
    DATA mt_content_data      TYPE /smb/t_actv_content_data.

ENDCLASS.

CLASS ltc_set_ewm_relevant IMPLEMENTATION.

  METHOD setup.

    mo_cut = NEW cl_ngc_bpc_set_ewm_relevant( ).

    mt_content_data = VALUE #(
      ( rec_id = '0001'
        ds_fld = 'I_CLASS'
        value  = 'YB_BATCH' )
      ( rec_id = '0001'
        ds_fld = 'I_ATNAM'
        value  = 'YB_BATCH_NUMBER' )

      ( rec_id = '0002'
        ds_fld = 'I_CLASS'
        value  = 'YB_BATCH' )
      ( rec_id = '0002'
        ds_fld = 'I_ATNAM'
        value  = 'YB_SUPPLIER_BATCH_NUMBER' ) ).

    TEST-INJECTION select_class_features.
      lt_tfeatures_get = VALUE #(
        ( atnam = 'YB_BATCH_NUMBER'          atbez = 'Batch Number' atfor = 'CHAR' anzst = '10' atinn = '0000000001' abtei = abap_true selre = abap_true drure = abap_true )
        ( atnam = 'YB_SUPPLIER_BATCH_NUMBER' atbez = 'Batch Number' atfor = 'CHAR' anzst = '10' atinn = '0000000002' selre = abap_true drure = abap_true ) ).
    END-TEST-INJECTION.

  ENDMETHOD.

  METHOD teardown.
  ENDMETHOD.

  METHOD set_ewm_relevant_okay.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    TEST-INJECTION overwrite_feature.
      LOOP AT lt_tfeatures_set INTO ls_tfeatures_set.
        cl_abap_unit_assert=>assert_true(
          act = ls_tfeatures_set-ewm_rel ).

        cl_abap_unit_assert=>assert_true(
          act = ls_tfeatures_set-drure ).

        cl_abap_unit_assert=>assert_true(
          act = ls_tfeatures_set-selre ).

        cl_abap_unit_assert=>assert_initial(
          act = ls_tfeatures_set-abtei ).
      ENDLOOP.
    END-TEST-INJECTION.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->activate(
      EXPORTING
        is_content_structure = VALUE #( )
        it_content_data      = mt_content_data
      IMPORTING
        ev_success           = DATA(lv_success)
        et_message           = DATA(lt_message) ) ##NEEDED.

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_equals(
      exp = abap_true
      act = lv_success ).

  ENDMETHOD.

  METHOD set_ewm_relevant_error.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    TEST-INJECTION overwrite_feature.
      sy-subrc = 1.
    END-TEST-INJECTION.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->activate(
      EXPORTING
        is_content_structure = VALUE #( )
        it_content_data      = mt_content_data
      IMPORTING
        ev_success           = DATA(lv_success)
        et_message           = DATA(lt_message) ) ##NEEDED.

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_equals(
      exp = abap_false
      act = lv_success ).

  ENDMETHOD.

  METHOD set_class_error.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    TEST-INJECTION select_class_features.
      sy-subrc = 1.
    END-TEST-INJECTION.

    TEST-INJECTION overwrite_feature.
      sy-subrc = 1.
    END-TEST-INJECTION.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->activate(
      EXPORTING
        is_content_structure = VALUE #( )
        it_content_data      = mt_content_data
      IMPORTING
        ev_success           = DATA(lv_success)
        et_message           = DATA(lt_message) ) ##NEEDED.

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_equals(
      exp = abap_false
      act = lv_success ).

  ENDMETHOD.

ENDCLASS.