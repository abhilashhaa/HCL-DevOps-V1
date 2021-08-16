METHOD if_ngc_class~get_characteristics.

  DATA:
    lo_cls_api_result             TYPE REF TO cl_ngc_cls_api_result,
    ls_characteristic_header      TYPE ngcs_characteristic,
    lt_characteristic_values      TYPE ngct_characteristic_value,
    lt_ref_for_char               TYPE ngct_characteristic_ref,
    lt_class_charcs_for_class     TYPE ngct_class_characteristic,
    lt_class_charc_vals_for_class TYPE ngct_class_charc_value,
    lt_charc_ref_for_class        TYPE ngct_characteristic_ref.

  CLEAR: et_characteristic, et_characteristic_org_area.

  lo_cls_api_result = NEW cl_ngc_cls_api_result( ).

  IF mv_characteristics_populated = abap_false.

    " get characteristics data from persistency
    mo_cls_persistency->read_by_internal_key(
      EXPORTING
        it_keys                        = VALUE #( ( classinternalid = ms_class_header-classinternalid key_date = ms_class_header-key_date ) )
      IMPORTING
        et_class_characteristics       = DATA(lt_class_characteristics)
        et_class_characteristic_values = DATA(lt_class_characteristic_value)
        et_characteristic_reference    = DATA(lt_characteristic_reference)
        et_message                     = DATA(lt_core_message)
    ).

    lo_cls_api_result->add_messages_from_core( lt_core_message ).

    " characteristics
    LOOP AT lt_class_characteristics ASSIGNING FIELD-SYMBOL(<ls_class_characteristic>).

      APPEND <ls_class_characteristic> TO lt_class_charcs_for_class.

      LOOP AT lt_characteristic_reference ASSIGNING FIELD-SYMBOL(<ls_characteristic_reference>)
        WHERE charcinternalid = <ls_class_characteristic>-charcinternalid.

        CHECK NOT line_exists( lt_charc_ref_for_class[
          charcinternalid          = <ls_characteristic_reference>-charcinternalid
          charcreferencetable      = <ls_characteristic_reference>-charcreferencetable
          charcreferencetablefield = <ls_characteristic_reference>-charcreferencetablefield ] ).

        APPEND INITIAL LINE TO lt_charc_ref_for_class ASSIGNING FIELD-SYMBOL(<ls_charc_ref_for_class>).
        MOVE-CORRESPONDING <ls_characteristic_reference> TO <ls_charc_ref_for_class>.
      ENDLOOP.
    ENDLOOP.

    MOVE-CORRESPONDING lt_class_characteristics TO mt_characteristic.

    LOOP AT mt_characteristic ASSIGNING FIELD-SYMBOL(<ls_characteristic>).

      APPEND INITIAL LINE TO mt_characteristic_org_area ASSIGNING FIELD-SYMBOL(<ls_characteristic_org_area>).
      <ls_characteristic_org_area>-charcinternalid        = <ls_characteristic>-charcinternalid.
      <ls_characteristic_org_area>-key_date               = <ls_characteristic>-key_date.
      <ls_characteristic_org_area>-clfnorganizationalarea = <ls_characteristic>-clfnorganizationalarea.

      APPEND INITIAL LINE TO mt_characteristic_object ASSIGNING FIELD-SYMBOL(<ls_characteristic_object>).
      <ls_characteristic_object>-charcinternalid = <ls_characteristic>-charcinternalid.
      <ls_characteristic_object>-key_date        = <ls_characteristic>-key_date.

      MOVE-CORRESPONDING <ls_characteristic>-characteristic_header TO  ls_characteristic_header.
      ls_characteristic_header-charcinternalid = <ls_characteristic>-charcinternalid.
      ls_characteristic_header-key_date        = <ls_characteristic>-key_date.

      LOOP AT lt_class_characteristic_value ASSIGNING FIELD-SYMBOL(<ls_class_charc_value>)
        WHERE charcinternalid = <ls_characteristic>-charcinternalid.
        APPEND INITIAL LINE TO lt_characteristic_values ASSIGNING FIELD-SYMBOL(<ls_characteristic_value>).
        MOVE-CORRESPONDING <ls_class_charc_value> TO <ls_characteristic_value>.
      ENDLOOP.

      LOOP AT lt_characteristic_reference ASSIGNING FIELD-SYMBOL(<ls_characteristic_ref>)
        WHERE charcinternalid = <ls_characteristic>-charcinternalid.

        CHECK NOT line_exists( lt_ref_for_char[
          charcinternalid          = <ls_characteristic_ref>-charcinternalid
          charcreferencetable      = <ls_characteristic_ref>-charcreferencetable
          charcreferencetablefield = <ls_characteristic_ref>-charcreferencetablefield ] ).

        APPEND <ls_characteristic_ref> TO lt_ref_for_char.
      ENDLOOP.

      <ls_characteristic_object>-characteristic_object = mo_api_factory->create_characteristic(
                                                           is_characteristic_header = ls_characteristic_header
                                                           it_characteristic_value  = lt_characteristic_values
                                                           it_characteristic_ref    = lt_ref_for_char ).

      CLEAR: ls_characteristic_header, lt_characteristic_values, lt_ref_for_char.
    ENDLOOP.

    mv_characteristics_populated = abap_true.
  ENDIF.

  et_characteristic          = mt_characteristic_object.
  et_characteristic_org_area = mt_characteristic_org_area.

  eo_cls_api_result = lo_cls_api_result.

ENDMETHOD.