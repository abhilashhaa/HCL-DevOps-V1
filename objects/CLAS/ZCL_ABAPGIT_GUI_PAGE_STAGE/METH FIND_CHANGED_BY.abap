  METHOD find_changed_by.

    DATA: ls_local      LIKE LINE OF it_local,
          ls_changed_by LIKE LINE OF rt_changed_by.

    FIELD-SYMBOLS: <ls_changed_by> LIKE LINE OF rt_changed_by.


    LOOP AT it_local INTO ls_local WHERE NOT item IS INITIAL.
      ls_changed_by-item = ls_local-item.
      INSERT ls_changed_by INTO TABLE rt_changed_by.
    ENDLOOP.

    LOOP AT rt_changed_by ASSIGNING <ls_changed_by>.
      TRY.
          <ls_changed_by>-name = to_lower( zcl_abapgit_objects=>changed_by( <ls_changed_by>-item ) ).
        CATCH zcx_abapgit_exception.
      ENDTRY.
    ENDLOOP.

  ENDMETHOD.