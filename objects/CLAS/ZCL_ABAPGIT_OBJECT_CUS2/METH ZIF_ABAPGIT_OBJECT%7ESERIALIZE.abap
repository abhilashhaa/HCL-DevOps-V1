  METHOD zif_abapgit_object~serialize.

    DATA: ls_customizing_attribute TYPE ty_customizing_attribute.

    CALL FUNCTION 'S_CUS_ATTRIBUTES_READ'
      EXPORTING
        img_attribute                 = mv_img_attribute
      IMPORTING
        attribute_header              = ls_customizing_attribute-header
      TABLES
        attribute_title               = ls_customizing_attribute-titles
        attribute_countries           = ls_customizing_attribute-countries
        attribute_components          = ls_customizing_attribute-components
        attribute_components_variants = ls_customizing_attribute-components_variants.

    CLEAR: ls_customizing_attribute-header-fdatetime,
           ls_customizing_attribute-header-fuser,
           ls_customizing_attribute-header-ldatetime,
           ls_customizing_attribute-header-luser.

    IF io_xml->i18n_params( )-serialize_master_lang_only = abap_true.
      DELETE ls_customizing_attribute-titles WHERE spras <> mv_language.
    ENDIF.

    io_xml->add( iv_name = 'CUS2'
                 ig_data = ls_customizing_attribute ).

  ENDMETHOD.