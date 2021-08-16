  METHOD zif_abapgit_ajson_reader~to_abap.

    DATA lo_to_abap TYPE REF TO lcl_json_to_abap.

    CLEAR ev_container.
    lcl_json_to_abap=>bind(
      CHANGING
        cv_obj = ev_container
        co_instance = lo_to_abap ).
    lo_to_abap->to_abap( mt_json_tree ).

  ENDMETHOD.