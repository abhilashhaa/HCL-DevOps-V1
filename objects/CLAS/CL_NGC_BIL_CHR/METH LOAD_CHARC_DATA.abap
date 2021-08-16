  METHOD load_charc_data.

    DATA:
      lt_charc_desc     TYPE tt_bapicharactdescr,
      lt_charc_ref      TYPE tt_bapicharactreferences,
      lt_charc_rstr     TYPE tt_bapicharactrestrictions,
      lt_charc_val_char TYPE tt_bapicharactvalueschar,
      lt_charc_val_curr TYPE tt_bapicharactvaluescurr,
      lt_charc_val_num  TYPE tt_bapicharactvaluesnum,
      lt_charc_val      TYPE lty_t_charcval_create,
      lt_charc_val_desc TYPE tt_bapicharactvaluesdescr.


    IF NOT line_exists( mt_charc_change_data[ charc-charcinternalid = iv_charcinternalid changenumber = iv_changenumber ] ).
      rv_new = abap_true.

      DATA(lv_keydate) = COND #( WHEN iv_changenumber IS INITIAL THEN sy-datum ELSE mo_ngc_db_access->read_change_number_valid_from( iv_changenumber ) ).

      me->read_characteristic_data_by_id(
        EXPORTING
          iv_charcinternalid         = iv_charcinternalid
          iv_keydate                 = lv_keydate
        IMPORTING
          es_characteristic          = DATA(ls_charc_vdm)
          et_characteristicdesc      = DATA(lt_charc_desc_vdm)
          et_characteristicref       = DATA(lt_charc_ref_vdm)
          et_characteristicrstrcn    = DATA(lt_charc_rstr_vdm)
          et_characteristicvalue     = DATA(lt_charc_val_vdm)
          et_characteristicvaluedesc = DATA(lt_charc_val_desc_vdm) ).

      IF ls_charc_vdm IS INITIAL.
        me->read_charc_data_by_id_incl_del(
          EXPORTING
            iv_charcinternalid         = iv_charcinternalid
            iv_keydate                 = lv_keydate
          IMPORTING
            es_characteristic          = ls_charc_vdm
            et_characteristicdesc      = lt_charc_desc_vdm
            et_characteristicref       = lt_charc_ref_vdm
            et_characteristicrstrcn    = lt_charc_rstr_vdm
            et_characteristicvalue     = lt_charc_val_vdm
            et_characteristicvaluedesc = lt_charc_val_desc_vdm ).
      ENDIF.

      CHECK ls_charc_vdm IS NOT INITIAL.

      DATA(ls_charc) = me->map_charc_vdm_api(
        is_charc_vdm = ls_charc_vdm ).

      LOOP AT lt_charc_desc_vdm ASSIGNING FIELD-SYMBOL(<ls_charc_desc_vdm>).
        DATA(ls_charc_desc_api) = me->map_charc_desc_vdm_api( <ls_charc_desc_vdm> ).
        APPEND ls_charc_desc_api TO lt_charc_desc.
      ENDLOOP.

      LOOP AT lt_charc_ref_vdm ASSIGNING FIELD-SYMBOL(<ls_charc_ref_vdm>).
        DATA(ls_charc_ref_api) = me->map_charc_ref_vdm_api( <ls_charc_ref_vdm> ).
        APPEND ls_charc_ref_api TO lt_charc_ref.
      ENDLOOP.

      LOOP AT lt_charc_rstr_vdm ASSIGNING FIELD-SYMBOL(<ls_charc_rstr_vdm>).
        DATA(ls_charc_rstr_api) = me->map_charc_rstr_vdm_api( <ls_charc_rstr_vdm> ).
        APPEND ls_charc_rstr_api TO lt_charc_rstr.
      ENDLOOP.

      LOOP AT lt_charc_val_vdm ASSIGNING FIELD-SYMBOL(<ls_charc_val_vdm>).
        DATA(ls_charc_val_api) = me->map_charc_val_vdm_api(
          is_charc_val_vdm = <ls_charc_val_vdm> ).
        ls_charc_val_api-charcvalue = <ls_charc_val_vdm>-charcvalue. " Required for charc value desc
        APPEND ls_charc_val_api TO lt_charc_val.
      ENDLOOP.

      LOOP AT lt_charc_val_desc_vdm ASSIGNING FIELD-SYMBOL(<ls_charc_val_desc_vdm>).
        DATA(ls_charc_val) = lt_charc_val[ charcvaluepositionnumber = <ls_charc_val_desc_vdm>-charcvaluepositionnumber ].

        DATA(ls_charc_val_desc_api) = me->map_charc_val_desc_vdm_api(
          is_charc_val_desc_vdm = <ls_charc_val_desc_vdm>
          is_charc_val          = ls_charc_val ).
        APPEND ls_charc_val_desc_api TO lt_charc_val_desc.
      ENDLOOP.

      DATA(ls_charc_data) = me->map_api_ext_to_int(
        iv_charcinternalid = iv_charcinternalid
        it_charc           = VALUE #( ( ls_charc ) )
        it_charc_val       = lt_charc_val ).

      ls_charc_data-charcvaldesc = lt_charc_val_desc.
      ls_charc_data-charcdesc    = lt_charc_desc.
      ls_charc_data-charcref     = lt_charc_ref.
      ls_charc_data-charcrstr    = lt_charc_rstr.
      ls_charc_data-changenumber = iv_changenumber.

      APPEND ls_charc_data TO mt_charc_change_data.
    ENDIF.

  ENDMETHOD.