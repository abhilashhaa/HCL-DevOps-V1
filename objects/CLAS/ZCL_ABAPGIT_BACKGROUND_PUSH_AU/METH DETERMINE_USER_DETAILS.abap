  METHOD determine_user_details.

    DATA: lo_user_master_record TYPE REF TO zcl_abapgit_user_master_record.


    lo_user_master_record = zcl_abapgit_user_master_record=>get_instance( iv_changed_by ).
    rs_user-name = lo_user_master_record->get_name( ).
    rs_user-email = lo_user_master_record->get_email( ).

*   If no email, fall back to localhost/default email
    IF rs_user-email IS INITIAL.
      rs_user-email = |{ iv_changed_by }@localhost|.
    ENDIF.

*   If no full name maintained, just use changed by user name
    IF rs_user-name IS INITIAL.
      rs_user-name  = iv_changed_by.
    ENDIF.

  ENDMETHOD.