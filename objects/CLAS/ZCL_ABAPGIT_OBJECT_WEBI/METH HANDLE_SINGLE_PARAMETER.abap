  METHOD handle_single_parameter.
    CONSTANTS:
      BEGIN OF lc_parameter_type,
        import TYPE vepparamtype VALUE 'I',
        export TYPE vepparamtype VALUE 'O',
      END OF lc_parameter_type.

    CASE iv_parameter_type.
      WHEN lc_parameter_type-import.
        ri_parameter = ii_function->get_incoming_parameter( parameter_name  = iv_name
                                                            version         = 'I' ).
        IF ri_parameter IS BOUND.
          ii_function->delete_incoming_parameter( ri_parameter ).
        ENDIF.
        ri_parameter = ii_function->create_incoming_parameter( iv_name ).

      WHEN lc_parameter_type-export.

        ri_parameter = ii_function->get_outgoing_parameter( parameter_name  = iv_name
                                                            version         = 'I' ).
        IF ri_parameter IS BOUND.
          ii_function->delete_outgoing_parameter( parameter = ri_parameter ).
        ENDIF.

        ri_parameter = ii_function->create_outgoing_parameter( iv_name ).

      WHEN OTHERS.
        ASSERT 0 = 1.
    ENDCASE.

  ENDMETHOD.