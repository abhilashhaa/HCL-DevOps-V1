  METHOD if_ngc_classification~get_characteristics.

    DATA:
      lo_clf_api_result  TYPE REF TO cl_ngc_clf_api_result,
      lt_charcinternalid TYPE SORTED TABLE OF atinn WITH UNIQUE DEFAULT KEY,
      lt_classtypes      TYPE SORTED TABLE OF klassenart WITH UNIQUE DEFAULT KEY.

    CLEAR: et_characteristic, eo_clf_api_result.

    lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

    me->if_ngc_classification~get_assigned_classes(
      IMPORTING
        et_assigned_class = DATA(lt_assigned_class) ).

    IF iv_classtype IS NOT INITIAL.
      IF iv_charcinternalid IS NOT INITIAL.
        me->mo_clf_util_intersect->get_charc_and_dom_vals(
          EXPORTING
            iv_classtype             = iv_classtype
            iv_charcinternalid       = iv_charcinternalid
            is_classification_key    = me->ms_classification_key
            it_classes               = lt_assigned_class
          IMPORTING
            es_characteristic_header = DATA(ls_characteristic_header)
            et_domain_values         = DATA(lt_characteristic_value)
            et_characteristic_ref    = DATA(lt_characteristic_ref)
            eo_clf_api_result        = DATA(lo_clf_api_result_tmp) ).

        lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).

        ASSERT ls_characteristic_header IS NOT INITIAL.

        " reference characteristic: set to read only
        set_reference_charc_hdr(
          CHANGING
            cs_characteristic_header = ls_characteristic_header
        ).

        APPEND VALUE #( classtype             = iv_classtype
                        charcinternalid       = iv_charcinternalid
                        key_date              = ms_classification_key-key_date
                        characteristic_object = mo_ngc_api_factory->create_characteristic(
                          is_characteristic_header = ls_characteristic_header
                          it_characteristic_value  = lt_characteristic_value
                          it_characteristic_ref    = lt_characteristic_ref )
        ) TO et_characteristic.

      ELSE.
        LOOP AT mt_assigned_class ASSIGNING FIELD-SYMBOL(<ls_assigned_classes>)
          WHERE object_state <> if_ngc_c=>gc_object_state-deleted.
          DATA(ls_class_header) = <ls_assigned_classes>-class_object->get_header( ).
          IF ls_class_header-classtype <> iv_classtype.
            CONTINUE.
          ENDIF.
          <ls_assigned_classes>-class_object->get_characteristics(
            IMPORTING
              et_characteristic = DATA(lt_class_characteristic) ).
          LOOP AT lt_class_characteristic ASSIGNING FIELD-SYMBOL(<ls_class_characteristic>).
            READ TABLE lt_charcinternalid TRANSPORTING NO FIELDS WITH KEY table_line = <ls_class_characteristic>-charcinternalid.
            IF sy-subrc <> 0.
              INSERT <ls_class_characteristic>-charcinternalid INTO TABLE lt_charcinternalid.
            ENDIF.
          ENDLOOP.
        ENDLOOP.
        LOOP AT lt_charcinternalid ASSIGNING FIELD-SYMBOL(<lv_charcinternalid>).
          me->mo_clf_util_intersect->get_charc_and_dom_vals(
            EXPORTING
              iv_classtype             = iv_classtype
              iv_charcinternalid       = <lv_charcinternalid>
              is_classification_key    = me->ms_classification_key
              it_classes               = lt_assigned_class
            IMPORTING
              es_characteristic_header = ls_characteristic_header
              et_domain_values         = lt_characteristic_value
              et_characteristic_ref    = lt_characteristic_ref
              eo_clf_api_result        = lo_clf_api_result_tmp ).

          lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).

          " reference characteristic: set to read only
          set_reference_charc_hdr(
            CHANGING
              cs_characteristic_header = ls_characteristic_header
          ).

          APPEND VALUE #( classtype             = iv_classtype
                          charcinternalid       = ls_characteristic_header-charcinternalid
                          key_date              = ms_classification_key-key_date
                          characteristic_object = mo_ngc_api_factory->create_characteristic(
                            is_characteristic_header = ls_characteristic_header
                            it_characteristic_value  = lt_characteristic_value
                            it_characteristic_ref    = lt_characteristic_ref )
          ) TO et_characteristic.

        ENDLOOP.
      ENDIF.
    ELSE.
      LOOP AT mt_assigned_class ASSIGNING <ls_assigned_classes>
        WHERE object_state <> if_ngc_c=>gc_object_state-deleted.
        ls_class_header = <ls_assigned_classes>-class_object->get_header( ).
        READ TABLE lt_classtypes TRANSPORTING NO FIELDS WITH TABLE KEY table_line = ls_class_header-classtype.
        IF sy-subrc <> 0.
          INSERT ls_class_header-classtype INTO TABLE lt_classtypes.
        ENDIF.
      ENDLOOP.

      LOOP AT lt_classtypes ASSIGNING FIELD-SYMBOL(<lv_classtype>).

        CLEAR: lt_charcinternalid.
        LOOP AT mt_assigned_class ASSIGNING <ls_assigned_classes>
          WHERE object_state <> if_ngc_c=>gc_object_state-deleted.
          ls_class_header = <ls_assigned_classes>-class_object->get_header( ).
          IF ls_class_header-classtype <> <lv_classtype>.
            CONTINUE.
          ENDIF.

          <ls_assigned_classes>-class_object->get_characteristics(
            IMPORTING
              et_characteristic = lt_class_characteristic ).
          LOOP AT lt_class_characteristic ASSIGNING <ls_class_characteristic>.
            READ TABLE lt_charcinternalid TRANSPORTING NO FIELDS WITH KEY table_line = <ls_class_characteristic>-charcinternalid.
            IF sy-subrc <> 0.
              INSERT <ls_class_characteristic>-charcinternalid INTO TABLE lt_charcinternalid.
            ENDIF.
          ENDLOOP.
        ENDLOOP.

        LOOP AT lt_charcinternalid ASSIGNING <lv_charcinternalid>.
          me->mo_clf_util_intersect->get_charc_and_dom_vals(
            EXPORTING
              iv_classtype             = <lv_classtype>
              iv_charcinternalid       = <lv_charcinternalid>
              is_classification_key    = me->ms_classification_key
              it_classes               = lt_assigned_class
            IMPORTING
              es_characteristic_header = ls_characteristic_header
              et_domain_values         = lt_characteristic_value
              et_characteristic_ref    = lt_characteristic_ref
              eo_clf_api_result        = lo_clf_api_result_tmp ).

          lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).

          " reference characteristic: set to read only
          set_reference_charc_hdr(
            CHANGING
              cs_characteristic_header = ls_characteristic_header
          ).

          APPEND VALUE #( classtype             = <lv_classtype>
                          charcinternalid       = <lv_charcinternalid>
                          key_date              = ms_classification_key-key_date
                          characteristic_object = mo_ngc_api_factory->create_characteristic(
                            is_characteristic_header = ls_characteristic_header
                            it_characteristic_value  = lt_characteristic_value
                            it_characteristic_ref    = lt_characteristic_ref )
          ) TO et_characteristic.

        ENDLOOP.
      ENDLOOP.
    ENDIF.

    eo_clf_api_result = lo_clf_api_result.

  ENDMETHOD.