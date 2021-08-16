  METHOD /smb/if_activity_abap~activate.

    CONSTANTS:
* classname parameter in the eCATT Test Script     /SMB99/CL02_I001_3DR
      lc_classname_parameter      TYPE /smb/de_ds_fld VALUE 'I_CLASS',
* characteristic parameter
      lc_characteristic_parameter TYPE /smb/de_ds_fld VALUE 'I_ATNAM',
* Yes
      lc_yes                      TYPE xfeld VALUE 'X'.

    DATA:
      lv_classname     TYPE  klasse_d,
      lt_tfeatures_get TYPE STANDARD TABLE OF klvmera,
      ls_tfeatures_get TYPE klvmera,
      lt_tfeatures_set TYPE STANDARD TABLE OF clmerk,
      ls_tfeatures_set TYPE clmerk,
      ls_message       TYPE /smb/s_actv_message,
      lv_error         LIKE  sy-binpt.
*      lv_rec_id    TYPE /smb/de_cnt_rec_id.

    FIELD-SYMBOLS:
      <ls_tfeatures_set> TYPE clmerk.

    CLEAR et_message.

*from the content data we get the class name value and the characteristic in component DS_FLD of Structure          /SMB/S_ACTV_CONTENT_DATA
    LOOP AT it_content_data ASSIGNING FIELD-SYMBOL(<ls_content_data>).
      IF <ls_content_data>-ds_fld = lc_classname_parameter.
        lv_classname = <ls_content_data>-value.
      ELSEIF <ls_content_data>-ds_fld = lc_characteristic_parameter.
        ls_tfeatures_set-atnam = <ls_content_data>-value.
        ls_tfeatures_set-ewm_rel = lc_yes.
        APPEND ls_tfeatures_set TO lt_tfeatures_set.
      ENDIF.
    ENDLOOP.
*currently only one class can be entered.

*So first call the function to get what was there before. Do not overwrite what was there before.
    TEST-SEAM select_class_features.
      CALL FUNCTION 'CLME_FEATURE_ATTR_OF_CLASS_ALL'
        EXPORTING
          class           = lv_classname
          classtype       = '023'
        TABLES
          tfeatures       = lt_tfeatures_get
        EXCEPTIONS
          class_not_found = 1
          no_authority    = 2
          OTHERS          = 3.
    END-TEST-SEAM.

    IF sy-subrc <> 0.
      ls_message-msgid = sy-msgid.
      ls_message-msgno = sy-msgno.
      ls_message-msgty = sy-msgty.
      ls_message-msgv1 = sy-msgv1.
      ls_message-msgv2 = sy-msgv2.
      ls_message-msgv3 = sy-msgv3.
      ls_message-msgv4 = sy-msgv4.
      ls_message-rec_id = <ls_content_data>-rec_id.
      ls_message-ds_fld = <ls_content_data>-ds_fld.
      APPEND ls_message TO et_message.

      ev_success = abap_false.
* you can leave the method the class does not exist or there is any other error
      RETURN.
    ENDIF.

    LOOP AT lt_tfeatures_set ASSIGNING <ls_tfeatures_set>.
      READ TABLE lt_tfeatures_get WITH KEY atnam = <ls_tfeatures_set>-atnam INTO ls_tfeatures_get.
      IF sy-subrc = 0.
        <ls_tfeatures_set>-dinkb = ls_tfeatures_get-dinkb.
        <ls_tfeatures_set>-herku = ls_tfeatures_get-herku.
        <ls_tfeatures_set>-drure = ls_tfeatures_get-drure.
        <ls_tfeatures_set>-selre = ls_tfeatures_get-selre.
        <ls_tfeatures_set>-anzre = ls_tfeatures_get-anzre.
      ENDIF.
    ENDLOOP.

*Set the flag EWM Relevant for the given characteristic(s) in the the class
    TEST-SEAM overwrite_feature.
      CALL FUNCTION 'CLCM_CLASS_FEATURE_OVERWRITE'
        EXPORTING
          classname            = lv_classname
          classtype            = '023'
        IMPORTING
          error                = lv_error
        TABLES
          tfeatures            = lt_tfeatures_set
        EXCEPTIONS
          class_invalid_change = 1
          no_retail_class      = 2
          OTHERS               = 3.
    END-TEST-SEAM.

    IF sy-subrc <> 0
      OR lv_error IS NOT INITIAL.

      ls_message-msgid = sy-msgid.
      ls_message-msgno = sy-msgno.
      ls_message-msgty = sy-msgty.
      ls_message-msgv1 = sy-msgv1.
      ls_message-msgv2 = sy-msgv2.
      ls_message-msgv3 = sy-msgv3.
      ls_message-msgv4 = sy-msgv4.
      ls_message-rec_id = <ls_content_data>-rec_id.
      ls_message-ds_fld = <ls_content_data>-ds_fld.
      APPEND ls_message TO et_message.

      ev_success = abap_false.

    ELSE.

      ev_success = abap_true.

    ENDIF.

  ENDMETHOD.