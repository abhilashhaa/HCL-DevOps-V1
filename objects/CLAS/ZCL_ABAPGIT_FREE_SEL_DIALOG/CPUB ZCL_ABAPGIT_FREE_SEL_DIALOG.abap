"! Free Selections Dialog
CLASS zcl_abapgit_free_sel_dialog DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES:
      BEGIN OF ty_free_sel_field,
        name             TYPE fieldname,
        only_parameter   TYPE abap_bool,
        param_obligatory TYPE abap_bool,
        value            TYPE string,
        value_range      TYPE rsds_selopt_t,
        ddic_tabname     TYPE tabname,
        ddic_fieldname   TYPE fieldname,
        text             TYPE rsseltext,
      END OF ty_free_sel_field,
      ty_free_sel_field_tab TYPE STANDARD TABLE OF ty_free_sel_field WITH DEFAULT KEY.

    TYPES: ty_syst_title TYPE c LENGTH 70.

    METHODS:
      constructor IMPORTING iv_title      TYPE ty_syst_title OPTIONAL
                            iv_frame_text TYPE ty_syst_title OPTIONAL,
      set_fields CHANGING ct_fields TYPE ty_free_sel_field_tab,
      show RAISING zcx_abapgit_cancel
                   zcx_abapgit_exception.