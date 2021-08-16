FUNCTION ngc_irf_get_clf_data .
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_OBJ_TAB) TYPE  TABELLE
*"     REFERENCE(IV_OBJEK) TYPE  AUSP-OBJEK
*"     REFERENCE(IV_FATHER_ID) TYPE  GSS_DEP_FATHER
*"     REFERENCE(IS_EXIT_DATA) TYPE  GSS_S_EXIT
*"  EXPORTING
*"     REFERENCE(ET_CLF_DATA) TYPE  GSS_T_TRANSFER
*"----------------------------------------------------------------------

  DATA:
    lt_class        TYPE STANDARD TABLE OF sclass,
    lt_class_type   TYPE STANDARD TABLE OF rmclklart,
    lt_clf_obj_data TYPE STANDARD TABLE OF clobjdat.

  CLEAR et_clf_data.

  CHECK iv_objek IS NOT INITIAL.

  DATA(lv_langu) = is_exit_data-langu.
  IF lv_langu IS INITIAL.
    lv_langu = sy-langu.
  ENDIF.

  " get class types for an object table
  CALL FUNCTION 'CLCA_GET_CLASSTYPES_FROM_TABLE'
    EXPORTING
      table              = iv_obj_tab
      with_text          = ''
    TABLES
      iklart             = lt_class_type
    EXCEPTIONS
      no_classtype_found = 1
      OTHERS             = 2.
  CHECK sy-subrc EQ 0.

  " get classification data
  LOOP AT lt_class_type ASSIGNING FIELD-SYMBOL(<ls_class_type>).

    CLEAR: lt_clf_obj_data.

    CALL FUNCTION 'CLAF_CLASSIFICATION_OF_OBJECTS'
      EXPORTING
        classtype          = <ls_class_type>-klart
        language           = lv_langu
        object             = iv_objek
        objecttable        = iv_obj_tab
      TABLES
        t_class            = lt_class
        t_objectdata       = lt_clf_obj_data
      EXCEPTIONS
        no_classification  = 1
        no_classtypes      = 2
        invalid_class_type = 3
        OTHERS             = 4.
    CHECK sy-subrc EQ 0.

    LOOP AT lt_clf_obj_data ASSIGNING FIELD-SYMBOL(<ls_clf_obj_data>).
      APPEND INITIAL LINE TO et_clf_data ASSIGNING FIELD-SYMBOL(<data>).
      <data>-tabname            = 'AUSP'.                  " Table name
      <data>-fieldname          = <ls_clf_obj_data>-atnam. " Characteristic Name
      <data>-fieldvalue         = <ls_clf_obj_data>-ausp1. " Characteristic Value
      <data>-scrtext_l          = <ls_clf_obj_data>-smbez. " Characteristic description
      <data>-exit_dep_father    = iv_father_id.
    ENDLOOP.

  ENDLOOP.

ENDFUNCTION.