  PRIVATE SECTION.
    METHODS:
      select_tadir_entries RETURNING VALUE(rt_tadir) TYPE zif_abapgit_definitions=>ty_tadir_tt
                           RAISING   zcx_abapgit_exception.
    DATA:
      mv_package                    TYPE devclass,
      mv_include_sub_packages       TYPE abap_bool,
      mv_serialize_master_lang_only TYPE abap_bool,
      BEGIN OF ms_filter_parameters,
        object_type_range TYPE zif_abapgit_definitions=>ty_object_type_range,
        object_name_range TYPE zif_abapgit_definitions=>ty_object_name_range,
      END OF ms_filter_parameters,
      mt_result TYPE gty_result_tab.