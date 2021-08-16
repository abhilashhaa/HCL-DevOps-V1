  METHOD dependencies_popup.

    DATA: lt_met_status TYPE tt_dependency_status.

    lt_met_status = get_dependencies_met_status( it_dependencies ).

    show_dependencies_popup( lt_met_status ).

  ENDMETHOD.