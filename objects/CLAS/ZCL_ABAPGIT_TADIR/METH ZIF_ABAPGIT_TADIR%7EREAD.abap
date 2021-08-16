  METHOD zif_abapgit_tadir~read.

    DATA: li_exit TYPE REF TO zif_abapgit_exit.

* start recursion
* hmm, some problems here, should TADIR also build path?
    rt_tadir = build( iv_package            = iv_package
                      iv_top                = iv_package
                      io_dot                = io_dot
                      iv_ignore_subpackages = iv_ignore_subpackages
                      iv_only_local_objects = iv_only_local_objects
                      ii_log                = ii_log ).

    li_exit = zcl_abapgit_exit=>get_instance( ).
    li_exit->change_tadir(
      EXPORTING
        iv_package = iv_package
        ii_log     = ii_log
      CHANGING
        ct_tadir   = rt_tadir ).

    rt_tadir = check_exists( rt_tadir ).

  ENDMETHOD.