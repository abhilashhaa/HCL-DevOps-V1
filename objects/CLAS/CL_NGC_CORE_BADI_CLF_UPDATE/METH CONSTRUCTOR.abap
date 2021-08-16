  METHOD constructor.
    mo_cls_hier_maint = NEW cl_ngc_core_cls_hier_maint( NEW cl_ngc_core_cls_hier_dbaccess( ) ).
  ENDMETHOD.