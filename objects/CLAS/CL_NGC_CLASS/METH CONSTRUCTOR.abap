METHOD constructor.

  DATA:
    ls_characteristic_header TYPE ngcs_characteristic,
    lt_characteristic_values TYPE ngct_characteristic_value,
    lt_ref_for_char          TYPE ngct_characteristic_ref.

  mo_api_factory     = cl_ngc_api_factory=>get_instance( ).
  mo_cls_persistency = cl_ngc_core_factory=>get_cls_persistency( ).

  ms_class_header = is_class_header.

  IF it_class_characteristics IS SUPPLIED.

    mv_characteristics_populated = abap_true.

    MOVE-CORRESPONDING it_class_characteristics TO mt_characteristic.

    LOOP AT mt_characteristic ASSIGNING FIELD-SYMBOL(<ls_characteristic>).

      APPEND INITIAL LINE TO mt_characteristic_org_area ASSIGNING FIELD-SYMBOL(<ls_characteristic_org_area>).
      <ls_characteristic_org_area>-charcinternalid        = <ls_characteristic>-charcinternalid.
      <ls_characteristic_org_area>-key_date               = <ls_characteristic>-key_date.
      <ls_characteristic_org_area>-clfnorganizationalarea = <ls_characteristic>-clfnorganizationalarea.

      APPEND INITIAL LINE TO mt_characteristic_object ASSIGNING FIELD-SYMBOL(<ls_characteristic_object>).
      <ls_characteristic_object>-charcinternalid = <ls_characteristic>-charcinternalid.
      <ls_characteristic_object>-key_date        = <ls_characteristic>-key_date.

      MOVE-CORRESPONDING <ls_characteristic>-characteristic_header TO ls_characteristic_header.
      ls_characteristic_header-charcinternalid = <ls_characteristic>-charcinternalid.
      ls_characteristic_header-key_date        = <ls_characteristic>-key_date.

      LOOP AT it_class_characteristic_values ASSIGNING FIELD-SYMBOL(<ls_class_charc_value>)
        WHERE charcinternalid = <ls_characteristic>-charcinternalid.
        APPEND INITIAL LINE TO lt_characteristic_values ASSIGNING FIELD-SYMBOL(<ls_characteristic_value>).
        MOVE-CORRESPONDING <ls_class_charc_value> TO <ls_characteristic_value>.
      ENDLOOP.

      LOOP AT it_characteristic_ref ASSIGNING FIELD-SYMBOL(<ls_characteristic_ref>)
        WHERE
          charcinternalid = <ls_characteristic>-charcinternalid.
        CHECK NOT line_exists( lt_ref_for_char[
          charcinternalid          = <ls_characteristic_ref>-charcinternalid
          charcreferencetable      = <ls_characteristic_ref>-charcreferencetable
          charcreferencetablefield = <ls_characteristic_ref>-charcreferencetablefield ] ).

        APPEND <ls_characteristic_ref> TO lt_ref_for_char.
      ENDLOOP.

      IF lt_characteristic_values IS INITIAL.
        <ls_characteristic_object>-characteristic_object = mo_api_factory->create_characteristic(
          is_characteristic_header = ls_characteristic_header
          it_characteristic_ref    = lt_ref_for_char
        ).
      ELSE.
        <ls_characteristic_object>-characteristic_object = mo_api_factory->create_characteristic(
          is_characteristic_header = ls_characteristic_header
          it_characteristic_value  = lt_characteristic_values
          it_characteristic_ref    = lt_ref_for_char
        ).
      ENDIF.

      CLEAR: ls_characteristic_header, lt_characteristic_values, lt_ref_for_char.
    ENDLOOP.
  ENDIF.

ENDMETHOD.