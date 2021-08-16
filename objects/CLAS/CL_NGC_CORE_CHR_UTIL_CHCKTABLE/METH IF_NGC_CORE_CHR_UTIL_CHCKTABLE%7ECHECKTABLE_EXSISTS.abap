  METHOD if_ngc_core_chr_util_chcktable~checktable_exsists.

    rv_exists = mo_table_data_handler->check_table_exists( iv_table_name ).

  ENDMETHOD.