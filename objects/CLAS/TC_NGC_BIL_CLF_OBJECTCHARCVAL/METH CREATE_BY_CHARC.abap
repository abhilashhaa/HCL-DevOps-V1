  METHOD create_by_charc.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA:
      lt_classification_key TYPE ngct_classification_key,
      lt_create_by_charc    TYPE if_ngc_bil_clf=>ts_objcharcval-create-t_input.

    DATA(lt_test_data) = th_ngc_bil_clf_data=>gt_objectcharcval_cret_by_chr.

    DATA(lo_clf_api_result) = setup_api_result( ).
    DATA(lv_lines) = REDUCE i( INIT x = 0 FOR ls_test_data IN lt_test_data NEXT x = x + lines( ls_test_data-%target ) ).

    setup_charc_get_header(
      iv_number_of_expected_calling = lv_lines
      iv_charcdatatype              = if_ngc_c=>gc_charcdatatype-char
    ).

    LOOP AT lt_test_data ASSIGNING FIELD-SYMBOL(<ls_test_data>).
      LOOP AT <ls_test_data>-%target ASSIGNING FIELD-SYMBOL(<ls_test_data_target>).
        APPEND VALUE #(
          classtype       = <ls_test_data>-classtype
          charcinternalid = <ls_test_data>-charcinternalid ) TO lt_create_by_charc.
      ENDLOOP.
    ENDLOOP.

    setup_set_value(
      iv_charcdatatype              = if_ngc_c=>gc_charcdatatype-char
      iv_number_of_expected_calling = 1
      it_test_data                  = lt_create_by_charc
      io_clf_api_result             = lo_clf_api_result
    ).

    setup_get_characteristics(
      iv_number_of_expected_calling = 1
      it_characteristic             = VALUE ngct_clf_characteristic_object(
                                        ( charcinternalid       = lt_test_data[ 1 ]-charcinternalid
                                          characteristic_object = mo_ngc_characteristic )
                                        ( charcinternalid       = lt_test_data[ 2 ]-charcinternalid
                                          characteristic_object = mo_ngc_characteristic )
                                        ( charcinternalid       = lt_test_data[ 3 ]-charcinternalid
                                          characteristic_object = mo_ngc_characteristic )
                                      )
      io_ngc_clf_api_result         = lo_clf_api_result ).

    LOOP AT lt_test_data ASSIGNING <ls_test_data>.
      APPEND VALUE #( object_key       = <ls_test_data>-clfnobjectid
                      technical_object = <ls_test_data>-clfnobjecttable
                      change_number    = space
                      key_date         = sy-datum ) TO lt_classification_key.
    ENDLOOP.

    setup_api_read_multi(
      it_classification_key = lt_classification_key
      io_ngc_clf_api_result = lo_clf_api_result ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_clf~create_objcharc_objcharcval(
      EXPORTING
        it_input    = lt_test_data
      IMPORTING
        es_mapped   = DATA(ls_mapped)
        es_failed   = DATA(ls_failed)
        es_reported = DATA(ls_reported) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_equals(
      act = lines( ls_mapped-objectcharcvalue )
      exp = lines( lt_test_data ) ).

    cl_abap_unit_assert=>assert_initial(
      act = ls_failed
      msg = 'No failed entry was expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = ls_reported
      msg = 'No reported entry was expected' ).

    verify_classification_setup( ).

    verify_characteristic_setup( ).

  ENDMETHOD.