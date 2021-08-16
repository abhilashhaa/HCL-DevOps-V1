  METHOD delete_obj.

    DATA: li_obj TYPE REF TO zif_abapgit_object.


    IF is_supported( is_item ) = abap_true.
      li_obj = create_object( is_item     = is_item
                              iv_language = zif_abapgit_definitions=>c_english ).

      li_obj->delete( iv_package ).

      IF li_obj->get_metadata( )-delete_tadir = abap_true.
        CALL FUNCTION 'TR_TADIR_INTERFACE'
          EXPORTING
            wi_delete_tadir_entry = abap_true
            wi_tadir_pgmid        = 'R3TR'
            wi_tadir_object       = is_item-obj_type
            wi_tadir_obj_name     = is_item-obj_name
            wi_test_modus         = abap_false
          EXCEPTIONS
            OTHERS                = 1 ##FM_SUBRC_OK.

        " We deliberately ignore the subrc, because throwing an exception would
        " break the deletion of lots of object types. On the other hand we have
        " to catch the exceptions because otherwise messages would directly be issued
        " by the function module and change the control flow. Thus breaking the
        " deletion of TOBJ and other object types.
        " TODO: This is not very clean and has to be improved in the future. See PR 2741.

      ENDIF.
    ENDIF.

  ENDMETHOD.