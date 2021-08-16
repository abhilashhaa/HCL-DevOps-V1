  METHOD update_report.

    DATA: lt_old TYPE string_table.

    READ REPORT iv_program INTO lt_old.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Fatal error. Include { iv_program } should have been created previously!| ).
    ENDIF.

    IF lt_old <> it_source.
      INSERT REPORT iv_program FROM it_source.
      ASSERT sy-subrc = 0.
      rv_updated = abap_true.
    ELSE.
      rv_updated = abap_false.
    ENDIF.

  ENDMETHOD.