  METHOD zif_abapgit_object~serialize.

    DATA: ls_screen_variant TYPE ty_screen_variant.

    ls_screen_variant-shdsvci-scvariant = ms_item-obj_name.

    CALL FUNCTION 'RS_HDSYS_READ_SC_VARIANT_DB'
      EXPORTING
        scvariant        = ls_screen_variant-shdsvci-scvariant
      IMPORTING
        header_scvariant = ls_screen_variant-shdsvci
      TABLES
        values_scvariant = ls_screen_variant-shdsvfvci[]
        guixt_scripts    = ls_screen_variant-shdguixt[]
      EXCEPTIONS
        no_variant       = 1
        OTHERS           = 2.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

*   Clear all user details
    CLEAR: ls_screen_variant-shdsvci-crdate,
           ls_screen_variant-shdsvci-cruser,
           ls_screen_variant-shdsvci-chdate,
           ls_screen_variant-shdsvci-chuser.

    SELECT *
    FROM shdsvtxci
    INTO TABLE ls_screen_variant-shdsvtxci[]
    WHERE scvariant = ls_screen_variant-shdsvci-scvariant.

    SELECT *
    FROM shdgxtcode
    INTO TABLE ls_screen_variant-shdgxtcode[]
    WHERE scvariant = ls_screen_variant-shdsvci-scvariant.

    io_xml->add( iv_name = 'SCVI'
                 ig_data = ls_screen_variant ).

  ENDMETHOD.