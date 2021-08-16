  METHOD zif_abapgit_oo_object_fnc~update_descriptions.
    DELETE FROM seocompotx WHERE clsname = is_key-clsname. "#EC CI_SUBRC
    INSERT seocompotx FROM TABLE it_descriptions.         "#EC CI_SUBRC
  ENDMETHOD.