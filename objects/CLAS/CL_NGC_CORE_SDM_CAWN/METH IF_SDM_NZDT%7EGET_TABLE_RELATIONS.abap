  METHOD if_sdm_nzdt~get_table_relations.

    DATA:
      ls_table_group           TYPE if_sdm_nzdt~ts_table_group,
      ls_simple_table_relation TYPE if_sdm_nzdt~ts_simple_table_relation,
      ls_field_relation        TYPE if_sdm_nzdt~ts_field_relation.

    " Definition of the table group.
    CLEAR ls_table_group.
    ls_table_group-table_group_name = mc_leading_table_name.
    ls_table_group-table_group_type = if_sdm_nzdt~gc_table_group_type_main.
    ls_table_group-leading_tabname  = mc_leading_table_name.

    " Definition of the table relation.
    CLEAR ls_simple_table_relation.
    ls_simple_table_relation-tabname         = mc_leading_table_name.
    ls_simple_table_relation-related_tabname = mc_related_table_name.

    " Definition of the the key relations.
    CLEAR ls_field_relation.
    ls_field_relation-fieldname         = mc_client_field_name.
    ls_field_relation-related_fieldname = mc_client_field_name.
    APPEND ls_field_relation TO ls_simple_table_relation-field_relations.

    CLEAR ls_field_relation.
    ls_field_relation-fieldname         = mc_key_field_name.
    ls_field_relation-related_fieldname = mc_key_field_name.
    ls_field_relation-ignore_space      = abap_true. " Key field with initial value is not valid.
    APPEND ls_field_relation TO ls_simple_table_relation-field_relations.

    APPEND ls_simple_table_relation TO ls_table_group-table_relations.

    APPEND ls_table_group TO rt_table_groups.

  ENDMETHOD.