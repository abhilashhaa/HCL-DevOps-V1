  METHOD zif_abapgit_object~changed_by.

    DATA: lo_aab TYPE REF TO cl_aab_variant.

    lo_aab = create_object( ).
    lo_aab->get_author( IMPORTING ex_author = rv_user ).

  ENDMETHOD.