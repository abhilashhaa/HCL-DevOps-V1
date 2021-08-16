  METHOD zif_abapgit_object~exists.

    DATA: lv_state TYPE objstate,
          lo_ddl   TYPE REF TO object.


    CALL METHOD ('CL_DD_DDL_HANDLER_FACTORY')=>('CREATE')
      RECEIVING
        handler = lo_ddl.

    TRY.
        CALL METHOD lo_ddl->('IF_DD_DDL_HANDLER~READ')
          EXPORTING
            name      = ms_item-obj_name
            get_state = 'A'
          IMPORTING
            got_state = lv_state.
        rv_bool = boolc( NOT lv_state IS INITIAL ).
      CATCH cx_root.
        rv_bool = abap_false.
    ENDTRY.

  ENDMETHOD.