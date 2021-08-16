METHOD CONVERT_CORE.

  TYPES:
    lrty_mandt          TYPE RANGE OF mandt,
    ltty_named_seltab   TYPE cl_shdb_pfw_seltab=>tt_named_seltab,
    ltty_tabsplit_cols  TYPE if_shdb_pfw_package_provider=>tt_cols.

  DATA:
    ls_tabsplit         TYPE cl_shdb_pfw_pack_base=>ts_tables,
    lr_table_splitter   TYPE REF TO if_shdb_pfw_table_splitter,
    lt_tabsplit_packsel TYPE if_shdb_pfw_package_provider=>tt_packsel,
    ptab                TYPE abap_parmbind_tab,
    lt_events           TYPE ltt_event_count,
    lv_data_exists      TYPE boole_d.

  " Let's check if we have relevant data at all.
  lv_data_exists = abap_false.
  TEST-SEAM data_exists_seam.
    SELECT SINGLE @abap_true INTO @lv_data_exists FROM (iv_inputview_name) "#EC CI_DYNTAB
      CLIENT SPECIFIED WHERE mandt = @mv_client. "#EC CI_CLIENT
  END-TEST-SEAM.
  IF lv_data_exists <> abap_true.
    " Ok, do not initialize the FrameWork for nothing.
    RETURN.
  ENDIF.

  lr_table_splitter    = cl_shdb_pfw_factory=>new_table_splitter( iv_appl_name = mv_appl_name ).
  ls_tabsplit-tabname  = iv_inputview_name.
  ls_tabsplit-category = if_shdb_pfw_package_provider=>mc_cat-default.
  ls_tabsplit-pkg_size = iv_package_size.
  ls_tabsplit-range_fields_incl = VALUE ltty_tabsplit_cols( ( 'OBJEK' ) ).
  DATA(lt_sel_mandt)   = VALUE lrty_mandt( ( sign = 'I' option = 'EQ' low = mv_client high = mv_client ) ).
  ls_tabsplit-filter   = VALUE ltty_named_seltab(
    ( name = 'MANDT' dref = REF #( lt_sel_mandt ) )
  ).

  TEST-SEAM get_packsel_seam.
    lt_tabsplit_packsel = lr_table_splitter->get_packsel( is_tables = ls_tabsplit ).
  END-TEST-SEAM.
  ptab = VALUE #( ( name  = 'IT_PACKSEL'
                    kind  = cl_abap_objectdescr=>exporting
                    value = REF #( lt_tabsplit_packsel ) )
                ( name  = 'RT_EVENTS'
                  kind  = cl_abap_objectdescr=>returning
                  value = REF #( lt_events ) ) ).
  " Call PROCESS_PACKAGE
  CALL METHOD me->(iv_procpack_name)
    PARAMETER-TABLE
      ptab.

  " AFTER_PACKAGE
  me->after_package( it_events = lt_events ).

ENDMETHOD.