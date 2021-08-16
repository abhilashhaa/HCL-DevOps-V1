  METHOD zif_abapgit_object~delete.
    DATA: ls_t100a          TYPE t100a,
          lv_frozen         TYPE abap_bool,
          lv_message_id     TYPE arbgb,
          lv_access_granted TYPE abap_bool.

* parameter SUPPRESS_DIALOG doesnt exist in all versions of FM RS_DELETE_MESSAGE_ID
* replaced with a copy
    lv_message_id = ms_item-obj_name.
    IF ms_item-obj_name = space.
      zcx_abapgit_exception=>raise( 'Error from (copy of) RS_DELETE_MESSAGE_ID' )."blank message id
    ENDIF.

    SELECT SINGLE * FROM t100a INTO ls_t100a WHERE arbgb = ms_item-obj_name.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'Error from (copy of) RS_DELETE_MESSAGE_ID' )."not found
    ENDIF.

    CLEAR lv_frozen.
    CALL FUNCTION 'RS_ACCESS_PERMISSION'
      EXPORTING
        authority_check = 'X'
        global_lock     = 'X'
        mode            = 'MODIFY'
        object          = lv_message_id
        object_class    = 'T100'
      IMPORTING
        frozen          = lv_frozen
      EXCEPTIONS
        OTHERS          = 1.

    IF sy-subrc <> 0 OR lv_frozen <> space.
      zcx_abapgit_exception=>raise( 'Error from (copy of) RS_DELETE_MESSAGE_ID' )."can't access
    ENDIF.

    lv_access_granted = abap_true.

    CALL FUNCTION 'RS_CORR_INSERT'
      EXPORTING
        global_lock        = 'X'
        object             = lv_message_id
        object_class       = 'MSAG'
        mode               = 'D'
        suppress_dialog    = abap_true
      EXCEPTIONS
        cancelled          = 01
        permission_failure = 02.

    IF sy-subrc <> 0.
      IF lv_access_granted = abap_true.
        free_access_permission( lv_message_id ).
      ENDIF.
      zcx_abapgit_exception=>raise( 'Error from (copy of) RS_DELETE_MESSAGE_ID' )."can't access
    ENDIF.

    delete_msgid( lv_message_id ).

    IF lv_access_granted = abap_true.
      free_access_permission( lv_message_id ).
    ENDIF.

  ENDMETHOD.