FUNCTION ngc_int_drf_bte_00004002.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  TABLES
*"      I_ALLOCATION_TAB STRUCTURE  RMCLKSSK OPTIONAL
*"      I_VALUE_TAB STRUCTURE  RMCLAUSP OPTIONAL
*"      I_DELOB_TAB STRUCTURE  RMCLDOB OPTIONAL
*"----------------------------------------------------------------------

  DATA:
    ls_drf_key_classification TYPE cmd_bs_clf_key_objkey,
    lv_drf_key                TYPE drf_object_id,
    lt_bo_keys                TYPE drf_t_bo_tabfield.

  APPEND INITIAL LINE TO lt_bo_keys ASSIGNING FIELD-SYMBOL(<lt_bo_keys>).
  <lt_bo_keys>-bo_type = if_ngc_drf_c=>gc_clf_drf_bo_type.

  " we only process batch (table MCH1) and class type 023
  " don't transfer deletions, notes: 1866090; 1787870
  " We can have only 1 relevant allocation in the I_ALLOCATION_TAB currently.
  LOOP AT i_allocation_tab ASSIGNING FIELD-SYMBOL(<ls_allocation_tab>) WHERE vbkz <> 'D'.
    APPEND INITIAL LINE TO <lt_bo_keys>-bo_keys ASSIGNING FIELD-SYMBOL(<lt_bo_key>).
    ls_drf_key_classification-object_table = <ls_allocation_tab>-obtab.
    ls_drf_key_classification-klart        = <ls_allocation_tab>-klart.
    ls_drf_key_classification-objkey       = <ls_allocation_tab>-cuobj.
    <lt_bo_key>-bo_key                     = ls_drf_key_classification.
  ENDLOOP.

  " Call replication ------------------------------------------------
  TRY.
    cl_drf_replication=>replicate_multi(
      it_bo_keys    = lt_bo_keys
      iv_skip_auth  = abap_true
    ).

  CATCH cx_mdg_missing_input_parameter.
  CATCH cx_mdg_obj_id_struc_not_exist.
  ENDTRY.

ENDFUNCTION.