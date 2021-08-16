  METHOD zif_abapgit_object~serialize.

    DATA: ls_tsp1t TYPE tsp1t,
          ls_tsp1d TYPE tsp1d,
          ls_tsp0p TYPE tsp0p.


    IF zif_abapgit_object~exists( ) = abap_false.
      RETURN.
    ENDIF.

    SELECT SINGLE * FROM tsp1t INTO ls_tsp1t
      WHERE papart = ms_item-obj_name
      AND spras = mv_language.            "#EC CI_GENBUFF "#EC CI_SUBRC
    SELECT SINGLE * FROM tsp1d INTO ls_tsp1d
      WHERE papart = ms_item-obj_name.                    "#EC CI_SUBRC
    SELECT SINGLE * FROM tsp0p INTO ls_tsp0p
      WHERE pdpaper = ms_item-obj_name.                   "#EC CI_SUBRC

    CLEAR: ls_tsp1d-chgname1,
           ls_tsp1d-chgtstmp1,
           ls_tsp1d-chgsaprel1,
           ls_tsp1d-chgsapsys1.

    io_xml->add( iv_name = 'TSPLT'
                 ig_data = ls_tsp1t ).
    io_xml->add( iv_name = 'TSPLD'
                 ig_data = ls_tsp1d ).
    io_xml->add( iv_name = 'TSP0P'
                 ig_data = ls_tsp0p ).

  ENDMETHOD.