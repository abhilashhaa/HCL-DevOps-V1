  METHOD save.

    DATA: lt_source   TYPE w3htmltabtype,
          lv_source   TYPE string,
          li_template TYPE REF TO if_w3_api_template.


    li_template = w3_api_create_new( is_template_data = is_attr ).

    w3_api_set_attributes( ii_template = li_template
                           is_attr     = is_attr ).

    lv_source = iv_source.
    WHILE strlen( lv_source ) >= 255.
      APPEND lv_source(255) TO lt_source.
      lv_source = lv_source+255.
    ENDWHILE.
    IF NOT lv_source IS INITIAL.
      APPEND lv_source TO lt_source.
    ENDIF.

    w3_api_set_source( ii_template = li_template
                       it_source   = lt_source ).

    w3_api_save( li_template ).

  ENDMETHOD.