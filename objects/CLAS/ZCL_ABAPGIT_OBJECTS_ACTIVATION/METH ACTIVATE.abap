  METHOD activate.

    IF use_new_activation_logic( ) = abap_true.
      activate_new( iv_ddic ).
    ELSE.
      activate_old( iv_ddic ).
    ENDIF.

    update_where_used( ).

  ENDMETHOD.