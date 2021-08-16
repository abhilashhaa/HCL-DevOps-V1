  METHOD deserialize_includes.

    DATA: lt_tab_methods TYPE enhnewmeth_tab,
          lv_editorder   TYPE n LENGTH 3,
          lv_methname    TYPE seocpdname,
          lt_abap        TYPE rswsourcet,
          lx_enh         TYPE REF TO cx_enh_root.

    FIELD-SYMBOLS: <ls_method> LIKE LINE OF lt_tab_methods.

    ii_xml->read( EXPORTING iv_name = 'TAB_METHODS'
                  CHANGING cg_data = lt_tab_methods ).

    LOOP AT lt_tab_methods ASSIGNING <ls_method>.

      lv_editorder = <ls_method>-meth_header-editorder.
      lv_methname = <ls_method>-methkey-cmpname.
      lt_abap = mo_files->read_abap( iv_extra = 'em' && lv_editorder ).

      TRY.
          io_class->add_change_new_method_source(
              clsname    = <ls_method>-methkey-clsname
              methname   = lv_methname
              methsource = lt_abap ).
        CATCH cx_enh_mod_not_allowed cx_enh_is_not_enhanceable INTO lx_enh.
          zcx_abapgit_exception=>raise( iv_text = 'Error deserializing ENHO method include'
                                        ix_previous = lx_enh ).
      ENDTRY.

    ENDLOOP.

  ENDMETHOD.