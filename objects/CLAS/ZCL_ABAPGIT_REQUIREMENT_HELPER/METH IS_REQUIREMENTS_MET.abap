  METHOD is_requirements_met.

    DATA: lt_met_status TYPE ty_requirement_status_tt.


    lt_met_status = get_requirement_met_status( it_requirements ).

    READ TABLE lt_met_status TRANSPORTING NO FIELDS WITH KEY met = abap_false.
    IF sy-subrc = 0.
      rv_status = zif_abapgit_definitions=>gc_no.
    ELSE.
      rv_status = zif_abapgit_definitions=>gc_yes.
    ENDIF.

  ENDMETHOD.