  METHOD deserialize_includes.

    DATA: lo_xml       TYPE REF TO zif_abapgit_xml_input,
          ls_progdir   TYPE ty_progdir,
          lt_includes  TYPE ty_sobj_name_tt,
          lt_tpool     TYPE textpool_table,
          lt_tpool_ext TYPE zif_abapgit_definitions=>ty_tpool_tt,
          lt_source    TYPE TABLE OF abaptxt255,
          lx_exc       TYPE REF TO zcx_abapgit_exception.

    FIELD-SYMBOLS: <lv_include> LIKE LINE OF lt_includes.


    tadir_insert( iv_package ).

    ii_xml->read( EXPORTING iv_name = 'INCLUDES'
                  CHANGING cg_data = lt_includes ).

    LOOP AT lt_includes ASSIGNING <lv_include>.

      "ignore simple transformation includes (as long as they remain in existing repositories)
      IF strlen( <lv_include> ) = 33 AND <lv_include>+30(3) = 'XTI'.
        ii_log->add_warning( iv_msg = |Simple Transformation include { <lv_include> } ignored|
                             is_item = ms_item ).
        CONTINUE.
      ENDIF.

      TRY.
          lt_source = mo_files->read_abap( iv_extra = <lv_include> ).

          lo_xml = mo_files->read_xml( <lv_include> ).

          lo_xml->read( EXPORTING iv_name = 'PROGDIR'
                        CHANGING cg_data = ls_progdir ).

          lo_xml->read( EXPORTING iv_name = 'TPOOL'
                        CHANGING cg_data = lt_tpool_ext ).
          lt_tpool = read_tpool( lt_tpool_ext ).

          deserialize_program( is_progdir = ls_progdir
                               it_source  = lt_source
                               it_tpool   = lt_tpool
                               iv_package = iv_package ).

          deserialize_textpool( iv_program    = <lv_include>
                                it_tpool      = lt_tpool
                                iv_is_include = abap_true ).

          ii_log->add_success( iv_msg = |Include { ls_progdir-name } imported|
                               is_item = ms_item ).

        CATCH zcx_abapgit_exception INTO lx_exc.
          ii_log->add_exception( ix_exc = lx_exc
                                 is_item = ms_item ).
          CONTINUE.
      ENDTRY.

    ENDLOOP.

  ENDMETHOD.