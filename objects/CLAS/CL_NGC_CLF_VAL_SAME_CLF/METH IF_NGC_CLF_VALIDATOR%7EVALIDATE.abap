  METHOD if_ngc_clf_validator~validate.

    DATA:
      lo_clf_api_result TYPE REF TO cl_ngc_clf_api_result,
      lt_same_object    TYPE lty_t_clfnobjectclass,
      lv_object         TYPE cuobn.

    lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

    " Get assigned classes and valuation data
    io_classification->get_assigned_classes(
      IMPORTING
        et_assigned_class = DATA(lt_assigned_class) ).

    io_classification->get_assigned_values(
      IMPORTING
        et_valuation_data = DATA(lt_valuation_data) ).

    DATA(ls_classification) = io_classification->get_classification_key( ).

    " Check same classification for each class
    LOOP AT lt_assigned_class INTO DATA(ls_assigned_class).
      CLEAR: lt_same_object.

      DATA(lt_class_valuation_data) = me->get_valuation_for_class(
        io_assigned_class = ls_assigned_class-class_object
        it_valuation_data = lt_valuation_data ).

      CHECK lt_class_valuation_data IS NOT INITIAL.

      DATA(ls_class) = ls_assigned_class-class_object->get_header( ).

      lt_same_object = me->get_objects_with_same_clf(
          io_class          = ls_assigned_class-class_object
          it_valuation_data = lt_class_valuation_data
          is_classification = ls_classification ).

      " Add message if one or multiple same objects were found
      IF lt_same_object IS NOT INITIAL.
        IF lines( lt_same_object ) = 1.
          CALL FUNCTION 'CLCV_CONV_EXIT'
            EXPORTING
              ex_object      = lt_same_object[ 1 ]-clfnobjectid
              table          = ls_classification-technical_object
            IMPORTING
              im_object      = lv_object
            EXCEPTIONS
              tclo_not_found = 1.

          IF sy-subrc = 0.
            lt_same_object[ 1 ]-clfnobjectid = lv_object.
          ENDIF.

          MESSAGE ID 'NGC_API_BASE'
            TYPE ls_class-sameclassfctnreaction
            NUMBER '019'
            WITH ls_class-class lt_same_object[ 1 ]-clfnobjectid
            INTO DATA(ls_message) ##NEEDED.

          lo_clf_api_result->add_message_from_sy(
            is_classification_key = ls_classification ).
        ELSE.
          MESSAGE ID 'NGC_API_BASE'
            TYPE ls_class-sameclassfctnreaction
            NUMBER '018'
            WITH ls_class-class
            INTO ls_message ##NEEDED.

          lo_clf_api_result->add_message_from_sy(
            is_classification_key = ls_classification ).
        ENDIF.
      ENDIF.
    ENDLOOP.

    ro_clf_api_result = lo_clf_api_result.

  ENDMETHOD.