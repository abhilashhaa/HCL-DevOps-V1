  METHOD factory.

    CASE iv_tool.
      WHEN cl_enh_tool_badi_def=>tooltype.
        CREATE OBJECT ri_enho TYPE zcl_abapgit_object_enhs_badi_d.
      WHEN cl_enh_tool_hook_def=>tool_type.
        CREATE OBJECT ri_enho TYPE zcl_abapgit_object_enhs_hook_d.
      WHEN OTHERS.
        zcx_abapgit_exception=>raise( |ENHS: Unsupported tool { iv_tool }| ).
    ENDCASE.

  ENDMETHOD.