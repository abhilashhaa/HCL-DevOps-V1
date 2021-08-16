  METHOD zif_abapgit_object~deserialize.

    " We cannot use STREE_EXTENSION_NAME_CREATE
    " the create logic is directly tied to the UI
    "
    " Do it like here LSHI20F01 -> SAVE_DATA

    DATA: ls_extension TYPE ty_extension.

    io_xml->read(
      EXPORTING
        iv_name = 'SHI5'
      CHANGING
        cg_data = ls_extension ).

    INSERT ttree_ext  FROM ls_extension-header.

    DELETE FROM ttrees WHERE extension = ls_extension-header-extension.
    MODIFY ttrees FROM TABLE ls_extension-sequences.

    DELETE FROM ttree_extt WHERE extension = ls_extension-header-extension.
    MODIFY ttree_extt FROM TABLE ls_extension-texts.

    tadir_insert( iv_package ).

  ENDMETHOD.