  PRIVATE SECTION.

    METHODS read
      EXPORTING
        !es_outline TYPE wdy_cfg_outline_data
        !et_data    TYPE wdy_cfg_persist_data_appl_tab
      RAISING
        zcx_abapgit_exception .
    METHODS save
      IMPORTING
        !is_outline TYPE wdy_cfg_outline_data
        !it_data    TYPE wdy_cfg_persist_data_appl_tab
        !iv_package TYPE devclass
      RAISING
        zcx_abapgit_exception .
    METHODS delete
      IMPORTING
        !iv_package TYPE devclass
      RAISING
        zcx_abapgit_exception .
    METHODS check
      IMPORTING
        !it_messages TYPE cts_messages
      RAISING
        zcx_abapgit_exception .