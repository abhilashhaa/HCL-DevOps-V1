  PRIVATE SECTION.

    TYPES:
      ty_rs38l_incl_tt TYPE STANDARD TABLE OF rs38l_incl WITH DEFAULT KEY .
    TYPES:
      BEGIN OF ty_function,
        funcname          TYPE rs38l_fnam,
        global_flag       TYPE rs38l-global,
        remote_call       TYPE rs38l-remote,
        update_task       TYPE rs38l-utask,
        short_text        TYPE tftit-stext,
        remote_basxml     TYPE rs38l-basxml_enabled,
        import            TYPE STANDARD TABLE OF rsimp WITH DEFAULT KEY,
        changing          TYPE STANDARD TABLE OF rscha WITH DEFAULT KEY,
        export            TYPE STANDARD TABLE OF rsexp WITH DEFAULT KEY,
        tables            TYPE STANDARD TABLE OF rstbl WITH DEFAULT KEY,
        exception         TYPE STANDARD TABLE OF rsexc WITH DEFAULT KEY,
        documentation     TYPE STANDARD TABLE OF rsfdo WITH DEFAULT KEY,
        exception_classes TYPE abap_bool,
      END OF ty_function .
    TYPES:
      ty_function_tt TYPE STANDARD TABLE OF ty_function WITH DEFAULT KEY .
    TYPES:
      ty_sobj_name_tt TYPE STANDARD TABLE OF sobj_name  WITH DEFAULT KEY .
    TYPES:
      BEGIN OF ty_tpool_i18n,
        language TYPE langu,
        textpool TYPE zif_abapgit_definitions=>ty_tpool_tt,
      END OF ty_tpool_i18n .
    TYPES:
      tt_tpool_i18n TYPE STANDARD TABLE OF ty_tpool_i18n .

    DATA mt_includes_cache TYPE ty_sobj_name_tt .

    METHODS check_rfc_parameters
      IMPORTING
        !is_function TYPE ty_function
      RAISING
        zcx_abapgit_exception .
    METHODS update_where_used
      IMPORTING
        !it_includes TYPE ty_sobj_name_tt .
    METHODS main_name
      RETURNING
        VALUE(rv_program) TYPE program
      RAISING
        zcx_abapgit_exception .
    METHODS functions
      RETURNING
        VALUE(rt_functab) TYPE ty_rs38l_incl_tt
      RAISING
        zcx_abapgit_exception .
    METHODS includes
      RETURNING
        VALUE(rt_includes) TYPE ty_sobj_name_tt
      RAISING
        zcx_abapgit_exception .
    METHODS serialize_functions
      RETURNING
        VALUE(rt_functions) TYPE ty_function_tt
      RAISING
        zcx_abapgit_exception .
    METHODS deserialize_functions
      IMPORTING
        !it_functions TYPE ty_function_tt
        !ii_log       TYPE REF TO zif_abapgit_log
      RAISING
        zcx_abapgit_exception .
    METHODS serialize_xml
      IMPORTING
        !ii_xml TYPE REF TO zif_abapgit_xml_output
      RAISING
        zcx_abapgit_exception .
    METHODS deserialize_xml
      IMPORTING
        !ii_xml     TYPE REF TO zif_abapgit_xml_input
        !iv_package TYPE devclass
      RAISING
        zcx_abapgit_exception .
    METHODS serialize_includes
      RAISING
        zcx_abapgit_exception .
    METHODS deserialize_includes
      IMPORTING
        !ii_xml     TYPE REF TO zif_abapgit_xml_input
        !iv_package TYPE devclass
        !ii_log     TYPE REF TO zif_abapgit_log
      RAISING
        zcx_abapgit_exception .
    METHODS is_function_group_locked
      RETURNING
        VALUE(rv_is_functions_group_locked) TYPE abap_bool
      RAISING
        zcx_abapgit_exception .
    METHODS is_any_include_locked
      RETURNING
        VALUE(rv_is_any_include_locked) TYPE abap_bool
      RAISING
        zcx_abapgit_exception .
    METHODS is_any_function_module_locked
      RETURNING
        VALUE(rv_any_function_module_locked) TYPE abap_bool
      RAISING
        zcx_abapgit_exception .
    METHODS get_abap_version
      IMPORTING
        !ii_xml                TYPE REF TO zif_abapgit_xml_input
      RETURNING
        VALUE(rv_abap_version) TYPE progdir-uccheck
      RAISING
        zcx_abapgit_exception .
    METHODS update_func_group_short_text
      IMPORTING
        !iv_group      TYPE rs38l-area
        !iv_short_text TYPE tftit-stext .
    METHODS serialize_texts
      IMPORTING
        !iv_prog_name TYPE programm
        !ii_xml       TYPE REF TO zif_abapgit_xml_output
      RAISING
        zcx_abapgit_exception .
    METHODS deserialize_texts
      IMPORTING
        !iv_prog_name TYPE programm
        !ii_xml       TYPE REF TO zif_abapgit_xml_input
      RAISING
        zcx_abapgit_exception .