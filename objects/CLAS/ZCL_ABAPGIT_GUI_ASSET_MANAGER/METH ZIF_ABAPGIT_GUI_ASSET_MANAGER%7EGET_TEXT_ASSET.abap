  METHOD zif_abapgit_gui_asset_manager~get_text_asset.

    DATA ls_asset TYPE zif_abapgit_gui_asset_manager~ty_web_asset.
    ls_asset = me->zif_abapgit_gui_asset_manager~get_asset( iv_url ).

    IF ls_asset-type <> 'text'.
      zcx_abapgit_exception=>raise( |Not a text asset: { iv_url }| ).
    ENDIF.

    IF iv_assert_subtype IS NOT INITIAL AND ls_asset-subtype <> iv_assert_subtype.
      zcx_abapgit_exception=>raise( |Wrong subtype ({ iv_assert_subtype }): { iv_url }| ).
    ENDIF.

    rv_asset = zcl_abapgit_convert=>xstring_to_string_utf8( ls_asset-content ).

  ENDMETHOD.