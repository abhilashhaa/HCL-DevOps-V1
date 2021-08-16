  METHOD setup_change_value.

    DATA:
      lt_char_change_value TYPE ngct_valuation_charcv_char_chg,
      lt_num_change_value  TYPE ngct_valuation_charcv_num_chg,
      lt_curr_change_value TYPE ngct_valuation_charcv_curr_chg,
      lt_date_change_value TYPE ngct_valuation_charcv_date_chg,
      lt_time_change_value TYPE ngct_valuation_charcv_time_chg.

    IF it_test_data IS NOT SUPPLIED.
      cl_abap_testdouble=>configure_call( mo_ngc_classification )->ignore_all_parameters( )->set_parameter(
        EXPORTING
          name          = 'eo_clf_api_result'
          value         = io_clf_api_result
      )->and_expect(
      )->is_called_times( times = iv_number_of_expected_calling ).

      CASE iv_charcdatatype.
        WHEN if_ngc_c=>gc_charcdatatype-char.
          mo_ngc_classification->change_character_value( it_change_value = VALUE #( ) ).
        WHEN if_ngc_c=>gc_charcdatatype-num.
          mo_ngc_classification->change_numeric_value( it_change_value = VALUE #( ) ).
        WHEN if_ngc_c=>gc_charcdatatype-curr.
          mo_ngc_classification->change_currency_value( it_change_value = VALUE #( ) ).
        WHEN if_ngc_c=>gc_charcdatatype-date.
          mo_ngc_classification->change_numeric_value( it_change_value = VALUE #( ) ).
        WHEN if_ngc_c=>gc_charcdatatype-time.
          mo_ngc_classification->change_time_value( it_change_value = VALUE #( ) ).
        WHEN OTHERS.
      ENDCASE.
    ELSE.
      CASE iv_charcdatatype.
        WHEN if_ngc_c=>gc_charcdatatype-char.
          LOOP AT it_test_data ASSIGNING FIELD-SYMBOL(<ls_test_data>).
            APPEND VALUE #( classtype = <ls_test_data>-classtype charcinternalid = <ls_test_data>-charcinternalid ) TO lt_char_change_value.
          ENDLOOP.
          cl_abap_testdouble=>configure_call( mo_ngc_classification )->ignore_all_parameters( )->set_parameter(
            EXPORTING
              name          = 'eo_clf_api_result'
              value         = io_clf_api_result
          )->set_parameter(
            EXPORTING
              name          = 'et_success_value'
              value         = lt_char_change_value
          )->and_expect(
          )->is_called_times( times = iv_number_of_expected_calling ).
          mo_ngc_classification->change_character_value( it_change_value = lt_char_change_value ).
        WHEN if_ngc_c=>gc_charcdatatype-num.
          LOOP AT it_test_data ASSIGNING <ls_test_data>.
            APPEND VALUE #( classtype = <ls_test_data>-classtype charcinternalid = <ls_test_data>-charcinternalid ) TO lt_num_change_value.
          ENDLOOP.
          cl_abap_testdouble=>configure_call( mo_ngc_classification )->ignore_all_parameters( )->set_parameter(
            EXPORTING
              name          = 'eo_clf_api_result'
              value         = io_clf_api_result
          )->set_parameter(
            EXPORTING
              name          = 'et_success_value'
              value         = lt_num_change_value
          )->and_expect(
          )->is_called_times( times = iv_number_of_expected_calling ).
          mo_ngc_classification->change_numeric_value( it_change_value = lt_num_change_value ).
        WHEN if_ngc_c=>gc_charcdatatype-curr.
          LOOP AT it_test_data ASSIGNING <ls_test_data>.
            APPEND VALUE #( classtype = <ls_test_data>-classtype charcinternalid = <ls_test_data>-charcinternalid ) TO lt_curr_change_value.
          ENDLOOP.
          cl_abap_testdouble=>configure_call( mo_ngc_classification )->ignore_all_parameters( )->set_parameter(
            EXPORTING
              name          = 'eo_clf_api_result'
              value         = io_clf_api_result
          )->set_parameter(
            EXPORTING
              name          = 'et_success_value'
              value         = lt_curr_change_value
          )->and_expect(
          )->is_called_times( times = iv_number_of_expected_calling ).
          mo_ngc_classification->change_currency_value( it_change_value = lt_curr_change_value ).
        WHEN if_ngc_c=>gc_charcdatatype-date.
          LOOP AT it_test_data ASSIGNING <ls_test_data>.
            APPEND VALUE #( classtype = <ls_test_data>-classtype charcinternalid = <ls_test_data>-charcinternalid ) TO lt_date_change_value.
          ENDLOOP.
          cl_abap_testdouble=>configure_call( mo_ngc_classification )->ignore_all_parameters( )->set_parameter(
            EXPORTING
              name          = 'eo_clf_api_result'
              value         = io_clf_api_result
          )->set_parameter(
            EXPORTING
              name          = 'et_success_value'
              value         = lt_date_change_value
          )->and_expect(
          )->is_called_times( times = iv_number_of_expected_calling ).
          mo_ngc_classification->change_date_value( it_change_value = lt_date_change_value ).
        WHEN if_ngc_c=>gc_charcdatatype-time.
          LOOP AT it_test_data ASSIGNING <ls_test_data>.
            APPEND VALUE #( classtype = <ls_test_data>-classtype charcinternalid = <ls_test_data>-charcinternalid ) TO lt_time_change_value.
          ENDLOOP.
          cl_abap_testdouble=>configure_call( mo_ngc_classification )->ignore_all_parameters( )->set_parameter(
            EXPORTING
              name          = 'eo_clf_api_result'
              value         = io_clf_api_result
          )->set_parameter(
            EXPORTING
              name          = 'et_success_value'
              value         = lt_time_change_value
          )->and_expect(
          )->is_called_times( times = iv_number_of_expected_calling ).
          mo_ngc_classification->change_time_value( it_change_value = lt_time_change_value ).
        WHEN OTHERS.
      ENDCASE.
    ENDIF.

  ENDMETHOD.