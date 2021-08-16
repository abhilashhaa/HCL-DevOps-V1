  METHOD factory.

    CASE iv_tool.
      WHEN cl_enh_tool_badi_impl=>tooltype.
        CREATE OBJECT ri_enho TYPE zcl_abapgit_object_enho_badi
          EXPORTING
            is_item  = ms_item
            io_files = mo_files.
      WHEN cl_enh_tool_hook_impl=>tooltype.
        CREATE OBJECT ri_enho TYPE zcl_abapgit_object_enho_hook
          EXPORTING
            is_item  = ms_item
            io_files = mo_files.
      WHEN cl_enh_tool_class=>tooltype.
        CREATE OBJECT ri_enho TYPE zcl_abapgit_object_enho_class
          EXPORTING
            is_item  = ms_item
            io_files = mo_files.
      WHEN cl_enh_tool_intf=>tooltype.
        CREATE OBJECT ri_enho TYPE zcl_abapgit_object_enho_intf
          EXPORTING
            is_item  = ms_item
            io_files = mo_files.
      WHEN cl_wdr_cfg_enhancement=>tooltype.
        CREATE OBJECT ri_enho TYPE zcl_abapgit_object_enho_wdyc
          EXPORTING
            is_item  = ms_item
            io_files = mo_files.
      WHEN 'FUGRENH'.
        CREATE OBJECT ri_enho TYPE zcl_abapgit_object_enho_fugr
          EXPORTING
            is_item  = ms_item
            io_files = mo_files.
      WHEN 'WDYENH'.
        CREATE OBJECT ri_enho TYPE zcl_abapgit_object_enho_wdyn
          EXPORTING
            is_item  = ms_item
            io_files = mo_files.
      WHEN OTHERS.
        zcx_abapgit_exception=>raise( |Unsupported ENHO type { iv_tool }| ).
    ENDCASE.

  ENDMETHOD.