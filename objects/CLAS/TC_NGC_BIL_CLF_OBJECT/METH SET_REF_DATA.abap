  METHOD set_ref_data.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA: lr_data               TYPE REF TO data,
          lt_input              TYPE if_ngc_bil_clf=>ts_obj-action-setrefdata-t_input,
          lt_classification_key TYPE ngct_classification_key.


    FIELD-SYMBOLS: <lv_string> TYPE string.

    CREATE DATA lr_data TYPE string.
    ASSIGN lr_data->* TO <lv_string>.
    <lv_string> = 'Test'.

    APPEND INITIAL LINE TO lt_input ASSIGNING FIELD-SYMBOL(<ls_input>).
    <ls_input>-%param-charcreferencetable = 'STRING'.

    CALL TRANSFORMATION id
      SOURCE ref = lr_data
      RESULT XML <ls_input>-%param-charcreferencedatabinary
      OPTIONS data_refs = 'heap-or-error'.

    DATA(lo_clf_api_result) = setup_api_result( ).
    LOOP AT lt_input ASSIGNING <ls_input>.
      APPEND VALUE #( object_key       = <ls_input>-clfnobjectid
                      technical_object = <ls_input>-clfnobjecttable
                      change_number    = space
                      key_date         = sy-datum ) TO lt_classification_key.
    ENDLOOP.
    setup_api_read_multi(
      it_classification_key = lt_classification_key
      io_ngc_clf_api_result = lo_clf_api_result ).

    setup_set_reference_data( iv_number_of_expected_calling = 1 ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_clf~exec_obj_setrefdata(
      EXPORTING
        it_input    = lt_input
      IMPORTING
        es_failed   = DATA(ls_failed)
        es_reported = DATA(ls_reported) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_initial(
      act = ls_failed
      msg = 'No failed entry was expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = ls_reported
      msg = 'No reported entry was expected' ).

    verify_classification_setup( ).

  ENDMETHOD.