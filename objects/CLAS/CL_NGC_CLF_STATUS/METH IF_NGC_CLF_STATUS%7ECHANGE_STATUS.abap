  METHOD if_ngc_clf_status~change_status.

    CLEAR eo_clf_api_result.

    io_classification->get_assigned_classes(
      IMPORTING
        et_classification_data = DATA(lt_classification_data) ).

    READ TABLE lt_classification_data
      INTO DATA(ls_classification_data)
      WITH KEY
        classinternalid = iv_classinternalid.

    ASSERT sy-subrc = 0.
    ASSERT ls_classification_data <> iv_status.

    " Check if status exists
    DATA(lt_clf_status) = mo_clf_persistency->read_clf_statuses( ls_classification_data-classtype ).

    READ TABLE lt_clf_status
      TRANSPORTING NO FIELDS
      WITH KEY
        statu = iv_status.

    IF sy-subrc <> 0.
      RAISE invalid_status_code.
    ENDIF.

    me->get_statuses_for_classtype(
        EXPORTING
          iv_classtype = ls_classification_data-classtype
        IMPORTING
          es_released_status          = DATA(ls_released_status)
          es_incomplete_system_status = DATA(ls_incomplete_system_status) ).

    CHECK iv_status <> ls_incomplete_system_status-statu.

    DATA(lv_status) = iv_status.

    IF iv_status = ls_released_status-statu.
      DATA(lt_incomplete_char_for_class) = me->check_incomplete_by_system(
        io_classification = io_classification
        is_classification_data = ls_classification_data ).
      IF lt_incomplete_char_for_class IS NOT INITIAL.
        lv_status = ls_incomplete_system_status-statu.
      ENDIF.
    ENDIF.

    DATA(lt_classification_data_mod) = VALUE ngct_classification_data_mod(
      ( classinternalid     = ls_classification_data-classinternalid
        classpositionnumber = ls_classification_data-classpositionnumber
        clfnstatus          = lv_status ) ).

    io_classification->modify_classification_data(
      EXPORTING
        it_classification_data_mod = lt_classification_data_mod
      IMPORTING
        eo_clf_api_result          = eo_clf_api_result ).

  ENDMETHOD.