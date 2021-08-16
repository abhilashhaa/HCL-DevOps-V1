CLASS zcl_abapgit_objects_program DEFINITION PUBLIC INHERITING FROM zcl_abapgit_objects_super.

  PUBLIC SECTION.
    TYPES: BEGIN OF ty_progdir,
             name    TYPE progdir-name,
             state   TYPE progdir-state,
             sqlx    TYPE progdir-sqlx,
             edtx    TYPE progdir-edtx,
             varcl   TYPE progdir-varcl,
             dbapl   TYPE progdir-dbapl,
             dbna    TYPE progdir-dbna,
             clas    TYPE progdir-clas,
             type    TYPE progdir-type,
             occurs  TYPE progdir-occurs,
             subc    TYPE progdir-subc,
             appl    TYPE progdir-appl,
             secu    TYPE progdir-secu,
             cnam    TYPE progdir-cnam,
             cdat    TYPE progdir-cdat,
             unam    TYPE progdir-unam,
             udat    TYPE progdir-udat,
             vern    TYPE progdir-vern,
             levl    TYPE progdir-levl,
             rstat   TYPE progdir-rstat,
             rmand   TYPE progdir-rmand,
             rload   TYPE progdir-rload,
             fixpt   TYPE progdir-fixpt,
             sset    TYPE progdir-sset,
             sdate   TYPE progdir-sdate,
             stime   TYPE progdir-stime,
             idate   TYPE progdir-idate,
             itime   TYPE progdir-itime,
             ldbname TYPE progdir-ldbname,
             uccheck TYPE progdir-uccheck,
           END OF ty_progdir.

    METHODS serialize_program
      IMPORTING io_xml     TYPE REF TO zif_abapgit_xml_output OPTIONAL
                is_item    TYPE zif_abapgit_definitions=>ty_item
                io_files   TYPE REF TO zcl_abapgit_objects_files
                iv_program TYPE programm OPTIONAL
                iv_extra   TYPE clike OPTIONAL
      RAISING   zcx_abapgit_exception.

    METHODS read_progdir
      IMPORTING iv_program        TYPE programm
      RETURNING VALUE(rs_progdir) TYPE ty_progdir.

    METHODS deserialize_program
      IMPORTING is_progdir TYPE ty_progdir
                it_source  TYPE abaptxt255_tab
                it_tpool   TYPE textpool_table
                iv_package TYPE devclass
      RAISING   zcx_abapgit_exception.
