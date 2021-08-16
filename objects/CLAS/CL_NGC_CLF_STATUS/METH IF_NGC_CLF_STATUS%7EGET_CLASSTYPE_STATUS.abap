  METHOD if_ngc_clf_status~get_classtype_status.

    ev_released     = abap_true.
    ev_inconsistent = abap_false.

    me->get_statuses_for_classtype(
      EXPORTING
        iv_classtype = iv_classtype
      IMPORTING
        es_released_status = DATA(ls_released_status) ).

    io_classification->get_assigned_classes(
      IMPORTING
        et_classification_data = DATA(lt_classification_data) ).

    LOOP AT lt_classification_data INTO DATA(ls_classification_data)
      WHERE
        classtype = iv_classtype.
      IF ls_classification_data-clfnstatus <> ls_released_status-statu.
        ev_released = abap_false.

        IF ev_inconsistent = abap_true OR ev_inconsistent IS NOT REQUESTED.
          EXIT.
        ENDIF.
      ENDIF.

      IF me->check_inconsistent( io_classification = io_classification is_classification_data = ls_classification_data ) = abap_true.
        ev_inconsistent = abap_true.

        IF ev_released = abap_false OR ev_released IS NOT REQUESTED.
          EXIT.
        ENDIF.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.