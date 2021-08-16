  METHOD register_asset.

    DATA ls_asset LIKE LINE OF mt_asset_register.

    SPLIT iv_type AT '/' INTO ls_asset-type ls_asset-subtype.
    ls_asset-url          = iv_url.
    ls_asset-mime_name    = iv_mime_name.
    ls_asset-is_cacheable = iv_cachable.
    IF iv_base64 IS NOT INITIAL.
      ls_asset-content = zcl_abapgit_convert=>base64_to_xstring( iv_base64 ).
    ELSEIF iv_inline IS NOT INITIAL.
      ls_asset-content = zcl_abapgit_convert=>string_to_xstring( iv_inline ).
    ENDIF.

    APPEND ls_asset TO mt_asset_register.

  ENDMETHOD.