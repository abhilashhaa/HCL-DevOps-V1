  PRIVATE SECTION.
    CLASS-METHODS:
      get_adt_objects_and_names
        IMPORTING
          iv_obj_name       TYPE zif_abapgit_definitions=>ty_item-obj_name
          iv_obj_type       TYPE zif_abapgit_definitions=>ty_item-obj_type
        EXPORTING
          eo_adt_uri_mapper TYPE REF TO object
          eo_adt_objectref  TYPE REF TO object
          ev_program        TYPE progname
          ev_include        TYPE progname
        RAISING
          zcx_abapgit_exception.

    CLASS-METHODS:
      is_adt_jump_possible
        IMPORTING io_object                      TYPE REF TO cl_wb_object
                  io_adt                         TYPE REF TO object
        RETURNING VALUE(rv_is_adt_jump_possible) TYPE abap_bool
        RAISING   zcx_abapgit_exception.