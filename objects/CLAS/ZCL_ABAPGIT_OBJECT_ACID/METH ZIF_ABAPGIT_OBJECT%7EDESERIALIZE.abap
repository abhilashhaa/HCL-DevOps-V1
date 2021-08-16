  METHOD zif_abapgit_object~deserialize.

    DATA: lv_description TYPE aab_id_descript,
          lo_aab         TYPE REF TO cl_aab_id.


    io_xml->read( EXPORTING iv_name = 'DESCRIPTION'
                  CHANGING cg_data = lv_description ).

    lo_aab = create_object( ).
    lo_aab->enqueue( ).
    lo_aab->set_descript( lv_description ).
    tadir_insert( iv_package ).
    lo_aab->save( ).

  ENDMETHOD.