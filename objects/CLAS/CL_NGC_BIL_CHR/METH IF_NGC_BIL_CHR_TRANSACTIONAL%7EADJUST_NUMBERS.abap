  METHOD if_ngc_bil_chr_transactional~adjust_numbers.

    DATA:
      lv_positionnumber TYPE atzhl.


    CLEAR: et_charc_desc_mapped, et_charc_mapped, et_charc_ref_mapped, et_charc_rstr_mapped, et_charc_val_mapped, et_charc_val_desc_mapped.

*--------------------------------------------------------------------*
* Handle create data
*--------------------------------------------------------------------*

*    IF mt_charc_create_data IS NOT INITIAL.
*      DATA(lt_cabn) = mo_ngc_db_access->read_charc_from_buffer( ).
*    ENDIF.

    LOOP AT mt_charc_create_data ASSIGNING FIELD-SYMBOL(<ls_charc_create_data>).
      me->map_api_int_to_ext(
        EXPORTING
          is_charc_data     = <ls_charc_create_data>
        IMPORTING
          et_charc          = DATA(lt_charc)
          et_charc_val_char = DATA(lt_charc_val_char)
          et_charc_val_curr = DATA(lt_charc_val_curr)
          et_charc_val_num  = DATA(lt_charc_val_num) ).

      DATA(lt_return) = mo_ngc_db_access->create_characteristic(
        is_characteristic_bapi = lt_charc[ 1 ]
        iv_changenumber        = <ls_charc_create_data>-changenumber
        it_charcdesc_bapi      = <ls_charc_create_data>-charcdesc
        it_charcrstrcn_bapi    = <ls_charc_create_data>-charcrstr
        it_charcref_bapi       = <ls_charc_create_data>-charcref
        it_charcvalchar_bapi   = lt_charc_val_char
        it_charcvalcurr_bapi   = lt_charc_val_curr
        it_charcvalnum_bapi    = lt_charc_val_num
        it_charcvaldesc_bapi   = <ls_charc_create_data>-charcvaldesc ).

      LOOP AT lt_return TRANSPORTING NO FIELDS
        WHERE
          type CA gc_error_types.
        CONTINUE.
      ENDLOOP.

      IF mt_charc_create_data IS NOT INITIAL.
        DATA(lt_cabn) = mo_ngc_db_access->read_charc_from_buffer( ).
      ENDIF.

      " Get charcinternalid
      DATA(ls_cabn) = lt_cabn[ atnam = <ls_charc_create_data>-charc-charact_name ].

      " Map charc
      APPEND INITIAL LINE TO et_charc_mapped ASSIGNING FIELD-SYMBOL(<ls_charc_mapped>).
      <ls_charc_mapped>-%tmp-charcinternalid = <ls_charc_create_data>-charc-charcinternalid.
      <ls_charc_mapped>-charcinternalid      = ls_cabn-atinn.

      " Map charc descriptions
      LOOP AT <ls_charc_create_data>-charcdesc ASSIGNING FIELD-SYMBOL(<ls_charc_desc_create>).
        APPEND INITIAL LINE TO et_charc_desc_mapped ASSIGNING FIELD-SYMBOL(<ls_charc_desc_mapped>).
        <ls_charc_desc_mapped>-%tmp-charcinternalid = <ls_charc_create_data>-charc-charcinternalid.
        <ls_charc_desc_mapped>-%tmp-language        = <ls_charc_desc_create>-language_int.
        <ls_charc_desc_mapped>-charcinternalid      = ls_cabn-atinn.
        <ls_charc_desc_mapped>-language             = <ls_charc_desc_create>-language_int.
      ENDLOOP.

      " Map charc restrictions
      LOOP AT <ls_charc_create_data>-charcrstr ASSIGNING FIELD-SYMBOL(<ls_charc_create_rstr>).
        APPEND INITIAL LINE TO et_charc_rstr_mapped ASSIGNING FIELD-SYMBOL(<ls_charc_rstr_mapped>).
        <ls_charc_rstr_mapped>-%tmp-charcinternalid = <ls_charc_create_data>-charc-charcinternalid.
        <ls_charc_rstr_mapped>-%tmp-classtype       = <ls_charc_create_rstr>-class_type.
        <ls_charc_rstr_mapped>-charcinternalid      = ls_cabn-atinn.
        <ls_charc_rstr_mapped>-classtype            = <ls_charc_create_rstr>-class_type.
      ENDLOOP.

      " Map charc references
      LOOP AT <ls_charc_create_data>-charcref ASSIGNING FIELD-SYMBOL(<ls_charc_create_ref>).
        APPEND INITIAL LINE TO et_charc_ref_mapped ASSIGNING FIELD-SYMBOL(<ls_charc_ref_mapped>).
        <ls_charc_ref_mapped>-%tmp-charcinternalid          = <ls_charc_create_data>-charc-charcinternalid.
        <ls_charc_ref_mapped>-%tmp-charcreferencetable      = <ls_charc_create_ref>-reference_table.
        <ls_charc_ref_mapped>-%tmp-charcreferencetablefield = <ls_charc_create_ref>-reference_field.
        <ls_charc_ref_mapped>-charcinternalid               = ls_cabn-atinn.
        <ls_charc_ref_mapped>-charcreferencetable           = <ls_charc_create_ref>-reference_table.
        <ls_charc_ref_mapped>-charcreferencetablefield      = <ls_charc_create_ref>-reference_field.
      ENDLOOP.

      " Map charc values
      CLEAR: lv_positionnumber.

      LOOP AT <ls_charc_create_data>-charcval ASSIGNING FIELD-SYMBOL(<ls_charc_val_create>).
        lv_positionnumber = lv_positionnumber + 1.

        APPEND INITIAL LINE TO et_charc_val_mapped ASSIGNING FIELD-SYMBOL(<ls_charc_val_mapped>).
        <ls_charc_val_mapped>-%tmp-charcinternalid          = <ls_charc_create_data>-charc-charcinternalid.
        <ls_charc_val_mapped>-%tmp-charcvaluepositionnumber = <ls_charc_val_create>-charcvaluepositionnumber.
        <ls_charc_val_mapped>-charcinternalid               = ls_cabn-atinn.
        <ls_charc_val_mapped>-charcvaluepositionnumber      = lv_positionnumber.
      ENDLOOP.

      LOOP AT <ls_charc_create_data>-charcvaldesc ASSIGNING FIELD-SYMBOL(<ls_charc_val_desc_create>).
        DATA(ls_charc_val)        = <ls_charc_create_data>-charcval[ value_char = <ls_charc_val_desc_create>-value_char ].
        DATA(ls_charc_val_mapped) = et_charc_val_mapped[
          %tmp-charcinternalid          = <ls_charc_create_data>-charc-charcinternalid
          %tmp-charcvaluepositionnumber = ls_charc_val-charcvaluepositionnumber ].

        lv_positionnumber = ls_charc_val_mapped-charcvaluepositionnumber.

        APPEND INITIAL LINE TO et_charc_val_desc_mapped ASSIGNING FIELD-SYMBOL(<ls_charc_val_desc_mapped>).
        <ls_charc_val_desc_mapped>-%tmp-charcinternalid          = <ls_charc_create_data>-charc-charcinternalid.
        <ls_charc_val_desc_mapped>-%tmp-charcvaluepositionnumber = ls_charc_val-charcvaluepositionnumber.
        <ls_charc_val_desc_mapped>-%tmp-language                 = <ls_charc_val_desc_create>-language_int.
        <ls_charc_val_desc_mapped>-charcinternalid               = ls_cabn-atinn.
        <ls_charc_val_desc_mapped>-charcvaluepositionnumber      = lv_positionnumber.
        <ls_charc_val_desc_mapped>-language                      = <ls_charc_val_desc_create>-language_int.
      ENDLOOP.
    ENDLOOP.

*--------------------------------------------------------------------*
* Handle change data
*--------------------------------------------------------------------*

    LOOP AT mt_charc_change_data ASSIGNING FIELD-SYMBOL(<ls_charc_change_data>).
      CLEAR: lt_charc_val_char, lt_charc_val_curr, lt_charc_val_num, lv_positionnumber.

      me->map_api_int_to_ext(
        EXPORTING
          is_charc_data     = <ls_charc_change_data>
        IMPORTING
          et_charc          = lt_charc
          et_charc_val_char = lt_charc_val_char
          et_charc_val_curr = lt_charc_val_curr
          et_charc_val_num  = lt_charc_val_num ).

      DATA(lt_result) = mo_ngc_db_access->change_characteristic(
        iv_characteristic    = <ls_charc_change_data>-charc-charact_name
        iv_changenumber      = <ls_charc_change_data>-changenumber
        it_charc_bapi        = lt_charc
        it_charcdesc_bapi    = <ls_charc_change_data>-charcdesc
        it_charcrstrcn_bapi  = <ls_charc_change_data>-charcrstr
        it_charcref_bapi     = <ls_charc_change_data>-charcref
        it_charcvalchar_bapi = lt_charc_val_char
        it_charcvalcurr_bapi = lt_charc_val_curr
        it_charcvalnum_bapi  = lt_charc_val_num
        it_charcvaldesc_bapi = <ls_charc_change_data>-charcvaldesc ).

      LOOP AT <ls_charc_change_data>-charcval ASSIGNING FIELD-SYMBOL(<ls_charc_val>).
        lv_positionnumber = lv_positionnumber + 1.

        IF <ls_charc_val>-created = abap_true.
          APPEND INITIAL LINE TO et_charc_val_mapped ASSIGNING <ls_charc_val_mapped>.
          <ls_charc_val_mapped>-%tmp-charcinternalid          = <ls_charc_change_data>-charc-charcinternalid.
          <ls_charc_val_mapped>-%tmp-charcvaluepositionnumber = <ls_charc_val>-charcvaluepositionnumber.
          <ls_charc_val_mapped>-charcinternalid               = <ls_charc_change_data>-charc-charcinternalid.
          <ls_charc_val_mapped>-charcvaluepositionnumber      = lv_positionnumber.
        ENDIF.
      ENDLOOP.

      LOOP AT <ls_charc_change_data>-charcvaldesc ASSIGNING <ls_charc_val_desc_create>.
        ls_charc_val        = <ls_charc_change_data>-charcval[ value_char = <ls_charc_val_desc_create>-value_char ].
        ls_charc_val_mapped = VALUE #( et_charc_val_mapped[
          %tmp-charcinternalid          = <ls_charc_change_data>-charc-charcinternalid
          %tmp-charcvaluepositionnumber = ls_charc_val-charcvaluepositionnumber ] OPTIONAL ).

        IF ls_charc_val_mapped IS INITIAL.
          APPEND INITIAL LINE TO et_charc_val_desc_mapped ASSIGNING <ls_charc_val_desc_mapped>.
          <ls_charc_val_desc_mapped>-%tmp-charcinternalid          = <ls_charc_change_data>-charc-charcinternalid.
          <ls_charc_val_desc_mapped>-%tmp-charcvaluepositionnumber = ls_charc_val-charcvaluepositionnumber.
          <ls_charc_val_desc_mapped>-%tmp-language                 = <ls_charc_val_desc_create>-language_int.
          <ls_charc_val_desc_mapped>-charcinternalid               = <ls_charc_change_data>-charc-charcinternalid.
          <ls_charc_val_desc_mapped>-charcvaluepositionnumber      = ls_charc_val-charcvaluepositionnumber.
          <ls_charc_val_desc_mapped>-language                      = <ls_charc_val_desc_create>-language_int.
        ELSE.
          APPEND INITIAL LINE TO et_charc_val_desc_mapped ASSIGNING <ls_charc_val_desc_mapped>.
          <ls_charc_val_desc_mapped>-%tmp-charcinternalid          = <ls_charc_change_data>-charc-charcinternalid.
          <ls_charc_val_desc_mapped>-%tmp-charcvaluepositionnumber = ls_charc_val-charcvaluepositionnumber.
          <ls_charc_val_desc_mapped>-%tmp-language                 = <ls_charc_val_desc_create>-language_int.
          <ls_charc_val_desc_mapped>-charcinternalid               = <ls_charc_change_data>-charc-charcinternalid.
          <ls_charc_val_desc_mapped>-charcvaluepositionnumber      = ls_charc_val_mapped-charcvaluepositionnumber.
          <ls_charc_val_desc_mapped>-language                      = <ls_charc_val_desc_create>-language_int.
        ENDIF.

      ENDLOOP.
    ENDLOOP.

*--------------------------------------------------------------------*
* Delete characteristics
*--------------------------------------------------------------------*

    LOOP AT mt_charc_delete_data ASSIGNING FIELD-SYMBOL(<ls_charc_delete_data>).
      DATA(ls_charc_vdm) = me->read_characteristic_by_id( <ls_charc_delete_data>-charcinternalid ).
      mo_ngc_db_access->delete_characteristic(
        iv_characteristic = ls_charc_vdm-characteristic
        iv_changenumber   = <ls_charc_delete_data>-changenumber ).
    ENDLOOP.

  ENDMETHOD.