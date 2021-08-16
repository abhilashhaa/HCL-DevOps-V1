FUNCTION ngc_int_drf_bte_00004000.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(I_ACTIVITY_TYPE) TYPE  CDPOS-CHNGIND
*"  TABLES
*"      I_CHARACT_TAB STRUCTURE  CABN OPTIONAL
*"      I_CHARACT_DESCR_TAB STRUCTURE  CABNT OPTIONAL
*"      I_VALUE_TAB STRUCTURE  CAWN OPTIONAL
*"      I_VALUE_DESCR_TAB STRUCTURE  CAWNT OPTIONAL
*"      I_RESTRICTIONS_TAB STRUCTURE  TCME OPTIONAL
*"      I_REFERENCES_TAB STRUCTURE  CABNZ OPTIONAL
*"----------------------------------------------------------------------

  DATA:
    ls_drf_key_characteristic TYPE ngcs_drf_chrmas_object_key,
    lt_bo_keys                TYPE drf_t_bo_tabfield.

  APPEND INITIAL LINE TO lt_bo_keys ASSIGNING FIELD-SYMBOL(<lt_bo_keys>).
  <lt_bo_keys>-bo_type = if_ngc_drf_c=>gc_chr_drf_bo_type.

  LOOP AT i_charact_tab ASSIGNING FIELD-SYMBOL(<ls_charact_tab>).
    APPEND INITIAL LINE TO <lt_bo_keys>-bo_keys ASSIGNING FIELD-SYMBOL(<lt_bo_key>).
    ls_drf_key_characteristic-atnam = <ls_charact_tab>-atnam.
    <lt_bo_key>-bo_key = ls_drf_key_characteristic.
  ENDLOOP.

  TRY.
    cl_drf_replication=>replicate_multi(
      it_bo_keys    = lt_bo_keys
      iv_skip_auth  = abap_true
    ).
  CATCH cx_mdg_missing_input_parameter.
  CATCH cx_mdg_obj_id_struc_not_exist.
  ENDTRY.
ENDFUNCTION.