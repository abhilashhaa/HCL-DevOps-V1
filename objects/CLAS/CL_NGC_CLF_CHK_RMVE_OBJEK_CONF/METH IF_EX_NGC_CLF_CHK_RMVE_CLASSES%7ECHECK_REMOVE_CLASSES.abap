  METHOD if_ex_ngc_clf_chk_rmve_classes~check_remove_classes.

    " Implementation is adapted from form LCLFMF2D.
    " Check usage in configuration.

    DATA:
      lv_rcuobn_temp TYPE rcuobn,
      ls_message     TYPE ngcs_msg_with_index.

    DATA(ls_classtype) = mo_clf_persistency->read_classtype(
      iv_clfnobjecttable = is_classification_key-technical_object
      iv_classtype       = iv_classtype ).

    IF ls_classtype-classtypeisusableinvarconfign = abap_false.
      RETURN.
    ENDIF.

    TRY.

        SELECT SINGLE status FROM tcuos INTO @DATA(ls_tcuos) WHERE obtab = @is_classification_key-technical_object ##WARN_OK.

        IF sy-subrc = 0.

          lv_rcuobn_temp = is_classification_key-object_key.

          mo_check->cucp_check_del_obj_class_conf(
            EXPORTING
              cucp_var_class_type       = iv_classtype
              cucp_root_object_key      = lv_rcuobn_temp
              cucp_root_object_table    = is_classification_key-technical_object
              cucp_datuv                = is_classification_key-key_date
              cucp_aennr                = is_classification_key-change_number
            EXCEPTIONS
              deletion_allowed          = 1
              deletion_allowed_with_ecm = 2
              OTHERS                    = 3
          ).

          CASE sy-subrc.
            WHEN 0.
              MESSAGE e572(cl) INTO DATA(lv_dummy) ##NEEDED .
              MOVE-CORRESPONDING sy TO ls_message ##ENH_OK .
              APPEND ls_message TO ct_message.
              cv_allowed = abap_false.
            WHEN 2.
              MESSAGE w576(cl) WITH is_classification_key-change_number is_classification_key-key_date INTO lv_dummy.
              MOVE-CORRESPONDING sy TO ls_message ##ENH_OK .
              APPEND ls_message TO ct_message.
              cv_allowed = abap_true.
            WHEN OTHERS.
          ENDCASE.

        ENDIF.

      CATCH cx_sy_dyn_call_param_not_found
            cx_sy_dyn_call_illegal_func ##NO_HANDLER.
    ENDTRY.

  ENDMETHOD.