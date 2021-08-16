  METHOD zif_abapgit_object~deserialize.

    DATA: ls_tsp1t TYPE tsp1t,
          ls_tsp1d TYPE tsp1d,
          ls_tsp0p TYPE tsp0p.


    io_xml->read( EXPORTING iv_name = 'TSPLT'
                  CHANGING cg_data = ls_tsp1t ).
    io_xml->read( EXPORTING iv_name = 'TSPLD'
                  CHANGING cg_data = ls_tsp1d ).
    io_xml->read( EXPORTING iv_name = 'TSP0P'
                  CHANGING cg_data = ls_tsp0p ).

    MODIFY tsp1t FROM ls_tsp1t.                           "#EC CI_SUBRC
    MODIFY tsp1d FROM ls_tsp1d.                           "#EC CI_SUBRC
    MODIFY tsp0p FROM ls_tsp0p.                           "#EC CI_SUBRC

    tadir_insert( iv_package ).

  ENDMETHOD.