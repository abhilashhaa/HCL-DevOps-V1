  PROTECTED SECTION.

    TYPES:
      ty_spaces_tt TYPE STANDARD TABLE OF i WITH DEFAULT KEY .
    TYPES:
      BEGIN OF ty_dynpro,
        header     TYPE rpy_dyhead,
        containers TYPE dycatt_tab,
        fields     TYPE dyfatc_tab,
        flow_logic TYPE swydyflow,
        spaces     TYPE ty_spaces_tt,
      END OF ty_dynpro .
    TYPES:
      ty_dynpro_tt TYPE STANDARD TABLE OF ty_dynpro WITH DEFAULT KEY .
    TYPES:
      BEGIN OF ty_cua,
        adm TYPE rsmpe_adm,
        sta TYPE STANDARD TABLE OF rsmpe_stat WITH DEFAULT KEY,
        fun TYPE STANDARD TABLE OF rsmpe_funt WITH DEFAULT KEY,
        men TYPE STANDARD TABLE OF rsmpe_men WITH DEFAULT KEY,
        mtx TYPE STANDARD TABLE OF rsmpe_mnlt WITH DEFAULT KEY,
        act TYPE STANDARD TABLE OF rsmpe_act WITH DEFAULT KEY,
        but TYPE STANDARD TABLE OF rsmpe_but WITH DEFAULT KEY,
        pfk TYPE STANDARD TABLE OF rsmpe_pfk WITH DEFAULT KEY,
        set TYPE STANDARD TABLE OF rsmpe_staf WITH DEFAULT KEY,
        doc TYPE STANDARD TABLE OF rsmpe_atrt WITH DEFAULT KEY,
        tit TYPE STANDARD TABLE OF rsmpe_titt WITH DEFAULT KEY,
        biv TYPE STANDARD TABLE OF rsmpe_buts WITH DEFAULT KEY,
      END OF ty_cua .

    METHODS serialize_dynpros
      IMPORTING
        !iv_program_name TYPE programm
      RETURNING
        VALUE(rt_dynpro) TYPE ty_dynpro_tt
      RAISING
        zcx_abapgit_exception .
    METHODS serialize_cua
      IMPORTING
        !iv_program_name TYPE programm
      RETURNING
        VALUE(rs_cua)    TYPE ty_cua
      RAISING
        zcx_abapgit_exception .
    METHODS deserialize_dynpros
      IMPORTING
        !it_dynpros TYPE ty_dynpro_tt
      RAISING
        zcx_abapgit_exception .
    METHODS deserialize_textpool
      IMPORTING
        !iv_program    TYPE programm
        !it_tpool      TYPE textpool_table
        !iv_language   TYPE langu OPTIONAL
        !iv_is_include TYPE abap_bool DEFAULT abap_false
      RAISING
        zcx_abapgit_exception .
    METHODS deserialize_cua
      IMPORTING
        !iv_program_name TYPE programm
        !is_cua          TYPE ty_cua
      RAISING
        zcx_abapgit_exception .
    METHODS is_any_dynpro_locked
      IMPORTING
        !iv_program                    TYPE programm
      RETURNING
        VALUE(rv_is_any_dynpro_locked) TYPE abap_bool
      RAISING
        zcx_abapgit_exception .
    METHODS is_cua_locked
      IMPORTING
        !iv_program             TYPE programm
      RETURNING
        VALUE(rv_is_cua_locked) TYPE abap_bool
      RAISING
        zcx_abapgit_exception .
    METHODS is_text_locked
      IMPORTING
        !iv_program              TYPE programm
      RETURNING
        VALUE(rv_is_text_locked) TYPE abap_bool
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS add_tpool
      IMPORTING
        !it_tpool       TYPE textpool_table
      RETURNING
        VALUE(rt_tpool) TYPE zif_abapgit_definitions=>ty_tpool_tt .
    CLASS-METHODS read_tpool
      IMPORTING
        !it_tpool       TYPE zif_abapgit_definitions=>ty_tpool_tt
      RETURNING
        VALUE(rt_tpool) TYPE zif_abapgit_definitions=>ty_tpool_tt .