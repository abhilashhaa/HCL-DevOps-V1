  METHOD zif_abapgit_object~exists.

    DATA: lv_state TYPE abap_bool,
          lo_aab   TYPE REF TO cl_aab_id.


    lo_aab = create_object( ).

    lo_aab->get_state( IMPORTING ex_state = lv_state ).
    rv_bool = boolc( lv_state = abap_true ).

  ENDMETHOD.