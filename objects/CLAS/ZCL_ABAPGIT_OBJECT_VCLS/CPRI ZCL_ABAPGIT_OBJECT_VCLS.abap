  PRIVATE SECTION.

* See include MTOBJCON:
    CONSTANTS c_cluster_type TYPE c VALUE 'C' ##NO_TEXT.
    CONSTANTS c_mode_insert TYPE obj_para-maint_mode VALUE 'I' ##NO_TEXT.

    METHODS check_lock
      IMPORTING
        !iv_tabname         TYPE tabname
        !iv_argument        TYPE seqg3-garg
      RETURNING
        VALUE(rv_is_locked) TYPE abap_bool
      RAISING
        zcx_abapgit_exception .