  METHOD zif_abapgit_object~serialize.

    DATA: lv_ddtext TYPE ddtypet-ddtext,
          lt_source TYPE abaptxt255_tab.


    TRY.
        read( IMPORTING
                ev_ddtext = lv_ddtext
                et_source = lt_source ).
      CATCH zcx_abapgit_not_found.
        RETURN.
    ENDTRY.

    io_xml->add( iv_name = 'DDTEXT'
                 ig_data = lv_ddtext ).

    mo_files->add_abap( lt_source ).

  ENDMETHOD.