FUNCTION ngc_irf_equi .
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(I_TAB) TYPE  TABNAME
*"     REFERENCE(I_ADD_TAB) TYPE  GTB_TAB
*"     REFERENCE(I_EVENT) TYPE  CHAR1
*"     REFERENCE(I_FATHER_ID) TYPE  GSS_DEP_FATHER DEFAULT 0
*"     REFERENCE(I_EXIT_DATA) TYPE  GSS_S_EXIT OPTIONAL
*"  EXPORTING
*"     REFERENCE(E_ACTION) TYPE  CHAR1
*"     REFERENCE(E_ROWS) TYPE  GSS_COUNT
*"     REFERENCE(E_DONE) TYPE  BOOLEAN
*"     REFERENCE(E_DATA) TYPE  GSS_T_TRANSFER
*"  CHANGING
*"     REFERENCE(IT_OR_SELTAB) TYPE  GTB_T_OR_CLAUSE
*"----------------------------------------------------------------------

  DATA: lt_clf_data LIKE e_data.

  CHECK i_tab     EQ 'EQUI'. " Object-specific part: object table for Equipment master data

  CHECK i_add_tab EQ 'AUSP'. " Characteristic Values table
  CHECK i_event   EQ 'D'.    " Determination

  LOOP AT it_or_seltab ASSIGNING FIELD-SYMBOL(<sel>).

    CHECK <sel>-seltab IS NOT INITIAL.
    DATA(ls_objek_sel) = <sel>-seltab.

    IF ls_objek_sel[ 1 ]-field  EQ 'OBJEK' AND
       ls_objek_sel[ 1 ]-sign   EQ 'I' AND
       ls_objek_sel[ 1 ]-option EQ 'EQ'.

      CALL FUNCTION 'NGC_IRF_GET_CLF_DATA'
        EXPORTING
          iv_obj_tab   = i_tab
          iv_objek     = CONV cuobn( ls_objek_sel[ 1 ]-low ) " Object key of the main object
          iv_father_id = i_father_id
          is_exit_data = i_exit_data
        IMPORTING
          et_clf_data  = lt_clf_data.

      APPEND LINES OF lt_clf_data TO e_data.

    ENDIF.

  ENDLOOP.

  DESCRIBE TABLE e_data LINES e_rows.
  e_done = abap_true.
  e_action = 'F'.

ENDFUNCTION.