METHOD if_ngc_cls_api_read~read.

  DATA:
    lo_cls_api_result             TYPE REF TO cl_ngc_cls_api_result,
    lt_core_class_keys            TYPE ngct_core_class_key,
    ls_core_class_key             LIKE LINE OF lt_core_class_keys,
    ls_class                      TYPE ngcs_class_object,
    ls_class_header               TYPE ngcs_class,
    lt_class_charcs_for_class     TYPE ngct_class_characteristic,
    lt_class_charc_vals_for_class TYPE ngct_class_charc_value,
    lt_charc_ref_for_class        TYPE ngct_characteristic_ref.

  CLEAR: et_class, eo_cls_api_result.

  lo_cls_api_result = NEW cl_ngc_cls_api_result( ).

* Check if input key is supplied
  IF it_class_key IS INITIAL.
    eo_cls_api_result = lo_cls_api_result.
    RETURN.
  ENDIF.

  " copy input keys, remove duplicates
  MOVE-CORRESPONDING it_class_key TO lt_core_class_keys.
  SORT lt_core_class_keys ASCENDING BY key_date classinternalid.
  DELETE ADJACENT DUPLICATES FROM lt_core_class_keys COMPARING key_date classinternalid.

* get class data from persistency
  mo_cls_persistency->read_by_internal_key(
    EXPORTING it_keys                        = lt_core_class_keys
              iv_lock                        = abap_false
    IMPORTING et_classes                     = DATA(lt_classes)
              et_class_characteristics       = DATA(lt_class_characteristics)
              et_class_characteristic_values = DATA(lt_class_characteristic_value)
              et_characteristic_reference    = DATA(lt_characteristic_reference)
              et_message                     = DATA(lt_core_message) ).

  lo_cls_api_result->add_messages_from_core( lt_core_message ).

* convert class data to objects
  LOOP AT lt_classes ASSIGNING FIELD-SYMBOL(<ls_class>).
    " header
    MOVE-CORRESPONDING <ls_class> TO ls_class.
    MOVE-CORRESPONDING <ls_class> TO ls_class_header.

    " characteristics
    LOOP AT lt_class_characteristics ASSIGNING FIELD-SYMBOL(<ls_class_characteristic>)
      WHERE classinternalid = <ls_class>-classinternalid.
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

    " characteristic values
    LOOP AT lt_class_characteristic_value ASSIGNING FIELD-SYMBOL(<ls_class_characteristic_vals>)
      WHERE classinternalid = <ls_class>-classinternalid.
      APPEND <ls_class_characteristic_vals> TO lt_class_charc_vals_for_class.
    ENDLOOP.

    ls_class-class_object = mo_api_factory->create_class_with_charcs( is_class_header                = ls_class_header
                                                                      it_class_characteristics       = lt_class_charcs_for_class
                                                                      it_class_characteristic_values = lt_class_charc_vals_for_class
                                                                      it_characteristic_ref          = lt_charc_ref_for_class ).

    APPEND ls_class TO et_class.
    CLEAR: ls_class, ls_class_header, lt_class_charcs_for_class, lt_class_charc_vals_for_class, lt_charc_ref_for_class.
  ENDLOOP.

  eo_cls_api_result = lo_cls_api_result.

ENDMETHOD.