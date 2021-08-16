METHOD if_ngc_chr_api_read~read_by_ext_key.

  DATA:
    lo_chr_api_result       TYPE REF TO cl_ngc_chr_api_result,
    lt_core_charc_key_ext   TYPE ngct_core_charc_key_ext,
    ls_core_charc_key_ext   LIKE LINE OF lt_core_charc_key_ext,
    ls_characteristic       TYPE ngcs_characteristic_object,
    lt_characteristic_value TYPE ngct_characteristic_value,
    lt_characteristic_ref   TYPE ngct_characteristic_ref.

  CLEAR: et_characteristic, eo_chr_api_result.

  lo_chr_api_result = NEW cl_ngc_chr_api_result( ).

* Check if input key is supplied
  IF it_characteristic_key IS INITIAL.
    eo_chr_api_result = lo_chr_api_result.
    RETURN.
  ENDIF.

  " copy input keys, remove duplicates
  MOVE-CORRESPONDING it_characteristic_key TO lt_core_charc_key_ext.
  SORT lt_core_charc_key_ext ASCENDING BY key_date characteristic.
  DELETE ADJACENT DUPLICATES FROM lt_core_charc_key_ext COMPARING key_date characteristic.

* get characteristic data from persistency
  mo_chr_persistency->read_by_external_key(
    EXPORTING it_key                      = lt_core_charc_key_ext
              iv_lock                     = abap_false
    IMPORTING et_characteristic           = DATA(lt_characteristic)
              et_characteristic_reference = DATA(lt_core_characteristic_ref)
              et_message                  = DATA(lt_core_characteristic_msg) ).

  lo_chr_api_result->add_messages_from_core( lt_core_characteristic_msg ).

* convert characteristic data to objects
  LOOP AT lt_characteristic ASSIGNING FIELD-SYMBOL(<ls_characteristic>).
    ls_characteristic-charcinternalid       = <ls_characteristic>-charcinternalid.
    ls_characteristic-key_date              = <ls_characteristic>-key_date.
    MOVE-CORRESPONDING lt_core_characteristic_ref   TO lt_characteristic_ref.
    ls_characteristic-characteristic_object = mo_api_factory->create_characteristic( is_characteristic_header = <ls_characteristic>
                                                                                     it_characteristic_ref    = lt_characteristic_ref ).
    APPEND ls_characteristic TO et_characteristic.
    CLEAR: ls_characteristic.
  ENDLOOP.

  eo_chr_api_result = lo_chr_api_result.

ENDMETHOD.