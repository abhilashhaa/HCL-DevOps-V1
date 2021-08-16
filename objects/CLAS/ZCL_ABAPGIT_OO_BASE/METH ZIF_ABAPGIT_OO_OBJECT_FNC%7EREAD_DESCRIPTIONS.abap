  METHOD zif_abapgit_oo_object_fnc~read_descriptions.
    IF iv_language IS INITIAL.
      " load all languages
      SELECT * FROM seocompotx INTO TABLE rt_descriptions
             WHERE clsname   = iv_obejct_name
               AND descript <> ''
             ORDER BY PRIMARY KEY.                        "#EC CI_SUBRC
    ELSE.
      " load master language
      SELECT * FROM seocompotx INTO TABLE rt_descriptions
              WHERE clsname   = iv_obejct_name
                AND langu = iv_language
                AND descript <> ''
              ORDER BY PRIMARY KEY.                       "#EC CI_SUBRC
    ENDIF.
  ENDMETHOD.