  METHOD zif_abapgit_object~deserialize.

    DATA: ls_avas TYPE ty_avas.


    io_xml->read( EXPORTING iv_name = 'AVAS'
                  CHANGING cg_data = ls_avas ).

* The AVAS API cannot be used in this case, as it will always create a new GUID

    ASSERT NOT ls_avas-header-guid IS INITIAL.

    tadir_insert( iv_package ).

    insert_assignments( ls_avas ).
* todo, how does links work?

* corr_insert?

  ENDMETHOD.