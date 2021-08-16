  METHOD zif_abapgit_object~delete.

    DATA: lv_odsonam    TYPE c LENGTH 30,
          lv_objname    TYPE sobj_name,
          lo_collection TYPE REF TO object,
          lt_msg        TYPE STANDARD TABLE OF bal_s_msg,
          ls_msg        TYPE bal_s_msg.

    TRY.
        CREATE OBJECT lo_collection TYPE ('CL_RSD_ODSO_COLLECTION').
      CATCH cx_sy_create_data_error.
        zcx_abapgit_exception=>raise( |ODSO is not supported on this system| ).
    ENDTRY.

    lv_odsonam = ms_item-obj_name.
    lv_objname = ms_item-obj_name.

    TRY.
        CALL METHOD lo_collection->('ADD_TLOGO')
          EXPORTING
            i_objnm  = lv_objname
            i_modify = abap_true
            i_delete = abap_true.

        CALL METHOD lo_collection->('DELETE').

        CALL METHOD ('CL_RSO_APPLICATION_LOG')=>('APPL_LOG_MSG_READ')
          IMPORTING
            e_t_msg = lt_msg.

        READ TABLE lt_msg WITH KEY msgty = 'E' INTO ls_msg.
        IF sy-subrc = 0.
          zcx_abapgit_exception=>raise(
          |Error when deleting ODSO: { ms_item-obj_name } { ls_msg-msgv1 } { ls_msg-msgv2 }| ).
        ENDIF.

      CATCH cx_rs_cancelled.
        zcx_abapgit_exception=>raise( |Canceled deletion of ODSO: { ms_item-obj_name }| ).
      CATCH cx_rs_existing.
        zcx_abapgit_exception=>raise( |ODSO not exist: { ms_item-obj_name }| ).
      CATCH cx_rs_not_found.
        zcx_abapgit_exception=>raise( |ODSO not found: { ms_item-obj_name }| ).
    ENDTRY.

  ENDMETHOD.