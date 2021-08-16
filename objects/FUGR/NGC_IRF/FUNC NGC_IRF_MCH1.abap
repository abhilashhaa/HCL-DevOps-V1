FUNCTION ngc_irf_mch1 .
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(I_TAB) TYPE  TABNAME
*"     REFERENCE(I_ADD_TAB) TYPE  GTB_TAB
*"     REFERENCE(I_EVENT) TYPE  CHAR1
*"     REFERENCE(I_FATHER_ID) TYPE  GSS_DEP_FATHER DEFAULT 0
*"     REFERENCE(I_EXIT_DATA) TYPE  GSS_S_EXIT OPTIONAL
*"     REFERENCE(I_DATA_REF) TYPE REF TO  DATA
*"  EXPORTING
*"     REFERENCE(E_ACTION) TYPE  CHAR1
*"     REFERENCE(E_ROWS) TYPE  GSS_COUNT
*"     REFERENCE(E_DONE) TYPE  BOOLEAN
*"     REFERENCE(E_DATA) TYPE  GSS_T_TRANSFER
*"  CHANGING
*"     REFERENCE(IT_OR_SELTAB) TYPE  GTB_T_OR_CLAUSE
*"----------------------------------------------------------------------

  DATA: lt_clf_data LIKE e_data,
        ls_rmclf    TYPE rmclf.

  FIELD-SYMBOLS: <lt_mch1> TYPE tt_charge.

  CHECK i_tab     EQ 'MCH1'. " Object-specific part: object table for Cross-Plant Batch (primary table)

  CHECK i_add_tab EQ 'AUSP'. " Characteristic Values table (secondary table)
  CHECK i_event   EQ 'D'.    " Determination

  ASSIGN i_data_ref->* TO <lt_mch1>. " I_DATA_REF contains the data pointer to the data of the primary table

  LOOP AT <lt_mch1> ASSIGNING FIELD-SYMBOL(<ls_mch1>).

    ls_rmclf-matnr = <ls_mch1>-matnr.
    ls_rmclf-charg = <ls_mch1>-charg.

    " Key fields of the main object have to be converted to concatenated object key
    " ls_rmclf-objek = ls_rmclf-matnr + ls_rmclf-charg
    CALL FUNCTION 'CLCV_CONVERT_FIELDS_TO_OBJECT'
      EXPORTING
        rmclfstru      = ls_rmclf
        table          = i_tab
      IMPORTING
        rmclfstru      = ls_rmclf
      EXCEPTIONS
        tclo_not_found = 1
        OTHERS         = 2.
    CHECK sy-subrc EQ 0.

    " Get Classification data
    CALL FUNCTION 'NGC_IRF_GET_CLF_DATA'
      EXPORTING
        iv_obj_tab   = i_tab
        iv_objek     = ls_rmclf-objek
        iv_father_id = i_father_id
        is_exit_data = i_exit_data
      IMPORTING
        et_clf_data  = lt_clf_data.

    APPEND LINES OF lt_clf_data TO e_data.

  ENDLOOP.

  DESCRIBE TABLE e_data LINES e_rows.
  e_done = abap_true.
  e_action = 'F'.

ENDFUNCTION.