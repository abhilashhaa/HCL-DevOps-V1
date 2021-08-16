FUNCTION ngc_int_drf_bte_00004001.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(I_ACTIVITY_TYPE) TYPE  CDPOS-CHNGIND
*"     VALUE(I_CLASS_HEADER) TYPE  KLAH
*"     REFERENCE(I_KLAH_UPDATE) TYPE  SY-BATCH
*"     REFERENCE(I_KLAT_UPDATE) TYPE  SY-BATCH
*"     REFERENCE(I_KSML_UPDATE) TYPE  SY-BATCH
*"     REFERENCE(I_SWOR_UPDATE) TYPE  SY-BATCH
*"  TABLES
*"      I_CHARACT_TAB STRUCTURE  KSML OPTIONAL
*"      I_CATCHWORD_TAB STRUCTURE  SWOR OPTIONAL
*"      I_TEXTS STRUCTURE  KLAT OPTIONAL
*"      I_CHARACT_TAB_O STRUCTURE  KSML OPTIONAL
*"----------------------------------------------------------------------

  DATA:
    ls_drf_key_class TYPE ngcs_drf_clsmas_object_key,
    lt_bo_keys       TYPE drf_t_bo_tabfield.

  IF i_class_header IS INITIAL.
    RETURN.
  ENDIF.

  APPEND INITIAL LINE TO lt_bo_keys ASSIGNING FIELD-SYMBOL(<lt_bo_keys>).
  <lt_bo_keys>-bo_type   = if_ngc_drf_c=>gc_cls_drf_bo_type.
  APPEND INITIAL LINE TO <lt_bo_keys>-bo_keys ASSIGNING FIELD-SYMBOL(<lt_bo_key>).
  ls_drf_key_class-class = i_class_header-class.
  ls_drf_key_class-klart = i_class_header-klart.
  <lt_bo_key>-bo_key     = ls_drf_key_class.

  TRY.
      cl_drf_replication=>replicate_multi(
        EXPORTING
          it_bo_keys    = lt_bo_keys
          iv_skip_auth  = abap_true
      ).
    CATCH cx_mdg_missing_input_parameter.
    CATCH cx_mdg_obj_id_struc_not_exist.
  ENDTRY.

ENDFUNCTION.