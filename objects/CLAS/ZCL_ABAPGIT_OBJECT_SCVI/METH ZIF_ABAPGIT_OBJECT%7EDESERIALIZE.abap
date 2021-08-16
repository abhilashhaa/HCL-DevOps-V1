  METHOD zif_abapgit_object~deserialize.

    DATA: ls_screen_variant TYPE ty_screen_variant.

    DATA: lv_text TYPE natxt.

    io_xml->read(
      EXPORTING
        iv_name = 'SCVI'
      CHANGING
        cg_data = ls_screen_variant ).

    CALL FUNCTION 'ENQUEUE_ESSCVARCIU'
      EXPORTING
        scvariant = ls_screen_variant-shdsvci-scvariant
      EXCEPTIONS
        OTHERS    = 01.
    IF sy-subrc <> 0.
      MESSAGE e413(ms) WITH ls_screen_variant-shdsvci-scvariant INTO lv_text.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

    corr_insert( iv_package = iv_package ).

*   Populate user details
    ls_screen_variant-shdsvci-crdate = sy-datum.
    ls_screen_variant-shdsvci-cruser = sy-uname.
    ls_screen_variant-shdsvci-chdate = sy-datum.
    ls_screen_variant-shdsvci-chuser = sy-uname.

    MODIFY shdsvci    FROM ls_screen_variant-shdsvci.
    MODIFY shdsvtxci  FROM TABLE ls_screen_variant-shdsvtxci[].
    MODIFY shdsvfvci  FROM TABLE ls_screen_variant-shdsvfvci[].
    MODIFY shdguixt   FROM TABLE ls_screen_variant-shdguixt[].
    MODIFY shdgxtcode FROM TABLE ls_screen_variant-shdgxtcode[].

    CALL FUNCTION 'DEQUEUE_ESSCVARCIU'
      EXPORTING
        scvariant = ls_screen_variant-shdsvci-scvariant.

  ENDMETHOD.