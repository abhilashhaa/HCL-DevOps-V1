  PRIVATE SECTION.

    METHODS create_views
      RETURNING
        VALUE(rv_success) TYPE boole_d .
    METHODS delete_views
      IMPORTING
        !iv_log_error TYPE boole_d DEFAULT abap_true .
    METHODS lock_tables
      RETURNING
        VALUE(rv_error) TYPE boole_d .
    METHODS unlock_tables .
    METHODS read_ref_values
      IMPORTING
        !iv_obtab         TYPE tabelle
        !iv_objek         TYPE cuobn
        !iv_datuv         TYPE datuv
      CHANGING
        !ct_events        TYPE cl_ngc_core_conv_refchar_clnup=>ltt_event_count
      RETURNING
        VALUE(rt_reftabs) TYPE ltt_reftabs .
    METHODS get_objchk_name
      IMPORTING
        !iv_obtab             TYPE tabelle
      RETURNING
        VALUE(rv_objchk_name) TYPE rs38l_fnam .
    METHODS refval_exists
      IMPORTING
        !it_reftabs             TYPE ltt_reftabs
        !iv_attab               TYPE attab
        !iv_atfel               TYPE atfel
      RETURNING
        VALUE(rv_refval_exists) TYPE boole_d .
    METHODS delete_ausp
      IMPORTING
        !it_delete_ausp           TYPE ltt_delete_ausp
      RETURNING
        VALUE(rt_num_del_entries) TYPE i .