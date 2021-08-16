METHOD set_value_check.

  DATA ls_new_entry LIKE LINE OF cl_ngc_core_chr_check_factory=>gt_datatype_instance_map.

  DELETE cl_ngc_core_chr_check_factory=>gt_datatype_instance_map WHERE datatype = iv_charc_data_type.

  ls_new_entry-datatype = iv_charc_data_type.
  ls_new_entry-instance = io_value_check.
  APPEND ls_new_entry TO cl_ngc_core_chr_check_factory=>gt_datatype_instance_map.

ENDMETHOD.