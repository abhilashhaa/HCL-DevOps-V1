  METHOD select_tadir_entries.
    rt_tadir = zcl_abapgit_factory=>get_tadir( )->read(
      iv_package            = mv_package
      iv_ignore_subpackages = boolc( mv_include_sub_packages = abap_false ) ).

    DELETE rt_tadir WHERE object NOT IN ms_filter_parameters-object_type_range
                       OR obj_name NOT IN ms_filter_parameters-object_name_range.
  ENDMETHOD.