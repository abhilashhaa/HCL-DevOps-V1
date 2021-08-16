METHOD drop_objects_if_no_batch_repli.
  IF iv_dlmod <> if_drf_const=>mode_directly.
    RETURN.
  ENDIF.

  LOOP AT ct_object ASSIGNING FIELD-SYMBOL(<ls_object>).
    mo_ngc_drf_ewm_util->rep_sta_by_bo_inst_system_get(
      EXPORTING
        iv_business_system      = iv_business_system
        iv_bo                   = gc_batch_bo
        iv_object_id            = <ls_object>-matnrwerkscharg
      IMPORTING
        et_replication          = DATA(lt_replication)
    ).

    " Ensure that corresponding batch has already been sent at least once
    READ TABLE lt_replication TRANSPORTING NO FIELDS WITH KEY repstatus = if_drf_const=>replication_status_sent.
    IF sy-subrc <> 0.
      DELETE ct_object.
    ENDIF.
  ENDLOOP.
ENDMETHOD.