  METHOD get_local_intf_implementations.

    DATA: ls_type_infos             TYPE saboo_vseot,
          lt_method_implementations TYPE saboo_method_impl_tab,
          lt_source                 TYPE saboo_sourt.

    IF gt_interface_implementations IS INITIAL.

      READ REPORT sy-cprog INTO lt_source.
      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise( |Cannot read { sy-cprog }| ).
      ENDIF.

      CALL FUNCTION 'SCAN_ABAP_OBJECTS_CLASSES'
        CHANGING
          vseo_tabs                   = ls_type_infos
          method_impls                = lt_method_implementations
          sourc_tab                   = lt_source
        EXCEPTIONS
          scan_abap_source_error      = 1
          scan_abap_src_line_too_long = 2
          OTHERS                      = 3.
      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise_t100( ).
      ENDIF.

      gt_interface_implementations = ls_type_infos-iimpl_tab.

    ENDIF.

    rt_interface_implementations = gt_interface_implementations.

  ENDMETHOD.