  METHOD if_ngc_core_chr_util_chcktable~select_table_data.

    CHECK me->if_ngc_core_chr_util_chcktable~checktable_exsists( iv_table_name ).

    SELECT * FROM (iv_table_name) INTO TABLE et_values. "#EC CI_DYNTAB

  ENDMETHOD.