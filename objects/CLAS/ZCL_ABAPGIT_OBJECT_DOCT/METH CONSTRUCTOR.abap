  METHOD constructor.

    super->constructor(
        is_item     = is_item
        iv_language = iv_language ).

    mi_longtexts = zcl_abapgit_factory=>get_longtexts( ).

  ENDMETHOD.