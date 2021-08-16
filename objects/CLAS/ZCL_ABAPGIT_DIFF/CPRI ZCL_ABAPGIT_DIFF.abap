  PRIVATE SECTION.
    TYPES ty_regexset_tt TYPE STANDARD TABLE OF REF TO cl_abap_regex WITH KEY table_line.

    DATA mt_beacons TYPE zif_abapgit_definitions=>ty_string_tt .
    DATA mt_diff TYPE zif_abapgit_definitions=>ty_diffs_tt .
    DATA ms_stats TYPE zif_abapgit_definitions=>ty_count .

    CLASS-METHODS unpack
      IMPORTING
        !iv_new TYPE xstring
        !iv_old TYPE xstring
      EXPORTING
        !et_new TYPE abaptxt255_tab
        !et_old TYPE abaptxt255_tab .
    CLASS-METHODS render
      IMPORTING
        !it_new        TYPE abaptxt255_tab
        !it_old        TYPE abaptxt255_tab
        !it_delta      TYPE vxabapt255_tab
      RETURNING
        VALUE(rt_diff) TYPE zif_abapgit_definitions=>ty_diffs_tt .
    CLASS-METHODS compute
      IMPORTING
        !it_new         TYPE abaptxt255_tab
        !it_old         TYPE abaptxt255_tab
      RETURNING
        VALUE(rt_delta) TYPE vxabapt255_tab .
    METHODS calculate_line_num_and_stats .
    METHODS map_beacons .
    METHODS shortlist .
    METHODS create_regex_set
      RETURNING
        VALUE(rt_regex_set) TYPE ty_regexset_tt.