  METHOD zif_abapgit_object~deserialize.

    DATA: lv_ddtext    TYPE ddtypet-ddtext,
          lt_source    TYPE abaptxt255_tab,
          lv_progname  TYPE reposrc-progname,
          lv_typegroup TYPE rsedd0-typegroup.


    lv_typegroup = ms_item-obj_name.


    io_xml->read( EXPORTING iv_name = 'DDTEXT'
                  CHANGING cg_data = lv_ddtext ).

    lt_source = mo_files->read_abap( ).

    IF zif_abapgit_object~exists( ) = abap_false.
      create( iv_ddtext   = lv_ddtext
              it_source   = lt_source
              iv_devclass = iv_package ).
    ELSE.
      CONCATENATE c_prefix lv_typegroup INTO lv_progname.
      INSERT REPORT lv_progname FROM lt_source STATE 'I'.
    ENDIF.

    zcl_abapgit_objects_activation=>add_item( ms_item ).

  ENDMETHOD.