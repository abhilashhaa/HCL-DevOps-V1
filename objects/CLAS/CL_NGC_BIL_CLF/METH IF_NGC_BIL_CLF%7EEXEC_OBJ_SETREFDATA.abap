  METHOD if_ngc_bil_clf~exec_obj_setrefdata.

    DATA:
      lr_data               TYPE REF TO data,
      lt_classification_key TYPE ngct_classification_key.

    me->get_classifications(
      EXPORTING
        it_classification_key    = CORRESPONDING #( it_input MAPPING cid  = %cid_ref )
      IMPORTING
        et_classification_object = DATA(lt_classification_object)
        eo_clf_api_result        = DATA(lo_clf_api_result) ).

    me->add_object_msg(
      EXPORTING
        it_clfnobject     = CORRESPONDING #( it_input )
        io_ngc_api_result = lo_clf_api_result
      CHANGING
        ct_failed         = es_failed
        ct_reported       = es_reported ).

    DATA(lo_clf_util) = cl_ngc_bil_factory=>get_classification_util( ).

    LOOP AT it_input ASSIGNING FIELD-SYMBOL(<ls_input>).
      TRY.
          lo_clf_util->deserialize_data(
            EXPORTING
              iv_table       = <ls_input>-%param-charcreferencetable
              iv_data_binary = <ls_input>-%param-charcreferencedatabinary
            IMPORTING
              er_data        = lr_data ).

          DATA(ls_classification_object) = VALUE #( lt_classification_object[
            object_key       = <ls_input>-clfnobjectid
            technical_object = <ls_input>-clfnobjecttable
            key_date         = sy-datum
            change_number    = space ] OPTIONAL ).

          IF ls_classification_object IS INITIAL.
            " There should be already messages returned by get_classifications
            CONTINUE.
          ENDIF.

          ls_classification_object-classification->set_reference_data(
            iv_charcreferencetable = <ls_input>-%param-charcreferencetable
            ir_data                = lr_data ).

        CATCH cx_sy_create_data_error cx_transformation_error INTO DATA(lo_error).
          MESSAGE e053(ngc_rap) INTO DATA(lv_msg) ##NEEDED.
          me->add_object_msg(
            EXPORTING
              it_clfnobject = VALUE #(
                ( clfnobjectid    = <ls_input>-clfnobjectid
                  clfnobjecttable = <ls_input>-clfnobjecttable
                  cid             = <ls_input>-%cid_ref ) )
            CHANGING
              ct_failed     = es_failed
              ct_reported   = es_reported ).

          me->add_exception_to_object_msg(
            EXPORTING
              is_clfnobject = VALUE #( cid = <ls_input>-%cid_ref clfnobjectid = <ls_input>-clfnobjectid clfnobjecttable = <ls_input>-clfnobjecttable )
              io_exception  = lo_error
            CHANGING
              ct_failed     = es_failed
              ct_reported   = es_reported ).
      ENDTRY.
    ENDLOOP.

    LOOP AT es_failed-object ASSIGNING FIELD-SYMBOL(<ls_failed_obj>).
      <ls_failed_obj>-%action-setrefdata = cl_abap_behv=>flag_changed.
    ENDLOOP.

  ENDMETHOD.