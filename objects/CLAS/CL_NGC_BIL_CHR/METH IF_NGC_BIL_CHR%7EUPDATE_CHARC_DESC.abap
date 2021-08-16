  METHOD if_ngc_bil_chr~update_charc_desc.

    FIELD-SYMBOLS:
      <ls_change_data>    TYPE lty_s_charc_data,
      <ls_charc_desc_api> TYPE bapicharactdescr.


    CLEAR: et_failed, et_reported.


    LOOP AT it_update ASSIGNING FIELD-SYMBOL(<ls_update>).
      UNASSIGN: <ls_change_data>, <ls_charc_desc_api>.

      DATA(lv_new) = me->load_charc_data(
        iv_charcinternalid = <ls_update>-charcinternalid ).
*        iv_changenumber    = <ls_update>-changenumber ).
*      ASSIGN mt_charc_change_data[ charc-charcinternalid = <ls_update>-charcinternalid changenumber = <ls_update>-changenumber ] TO <ls_change_data>.
      ASSIGN mt_charc_change_data[ charc-charcinternalid = <ls_update>-charcinternalid ] TO <ls_change_data>.

*--------------------------------------------------------------------*
* Check change number
*--------------------------------------------------------------------*

      IF <ls_update>-changenumber IS NOT INITIAL.
        " Using a change number is not supported
        MESSAGE e047(ngc_rap) INTO DATA(lv_message).
        me->add_charc_desc_message(
          EXPORTING
            iv_root_charcinternalid = <ls_update>-charcinternalid
            iv_charcinternalid      = <ls_update>-charcinternalid
            iv_language             = <ls_update>-language
            iv_cid                  = <ls_update>-%cid_ref
            iv_set_failed           = abap_true
            iv_new                  = lv_new
          CHANGING
            ct_reported             = et_reported
            ct_failed               = et_failed ).

        CONTINUE.
      ENDIF.

      IF <ls_change_data> IS NOT ASSIGNED.
        " Characteristic does not exist
        MESSAGE e026(ngc_rap) INTO lv_message.
        me->add_charc_desc_message(
          EXPORTING
            iv_root_charcinternalid = <ls_update>-charcinternalid
            iv_charcinternalid      = <ls_update>-charcinternalid
            iv_language             = <ls_update>-language
            iv_cid                  = <ls_update>-%cid_ref
            iv_set_failed           = abap_true
            iv_new                  = lv_new
          CHANGING
            ct_reported             = et_reported
            ct_failed               = et_failed ).

        CONTINUE.
      ENDIF.

      " Execute checks
      DATA(ls_change_data) = <ls_change_data>.
      ASSIGN ls_change_data-charcdesc[ language_int = <ls_update>-language ] TO <ls_charc_desc_api>.

      IF <ls_charc_desc_api> IS NOT ASSIGNED.
        DELETE mt_charc_change_data
          WHERE
            charc-charcinternalid = <ls_update>-charcinternalid.

        CONTINUE.
      ENDIF.

      TRY.
          mo_vdm_api_mapper->map_and_merge_data_vdm_to_api(
            EXPORTING
              iv_vdm_entity  = if_ngc_bil_chr_c=>gcs_vdm_entity_tp-charc_desc
              is_source_vdm  = <ls_update>
              is_control_vdm = <ls_update>-%control
              is_merge_api   = <ls_charc_desc_api>
            CHANGING
              cs_target_api  = <ls_charc_desc_api> ).

          IF <ls_charc_desc_api>-description IS INITIAL.
            " No description defined in language &1
            MESSAGE e011(ngc_rap) WITH <ls_update>-language INTO lv_message.
            me->add_charc_desc_message(
              EXPORTING
                iv_root_charcinternalid = <ls_update>-charcinternalid
                iv_charcinternalid      = <ls_update>-charcinternalid
                iv_language             = <ls_update>-language
                iv_cid                  = <ls_update>-%cid_ref
                iv_set_failed           = abap_true
                iv_new                  = lv_new
              CHANGING
                ct_reported             = et_reported
                ct_failed               = et_failed ).

            CONTINUE.
          ENDIF.

        CATCH cx_vdm_plmb_api_mapper.
          " TODO: Message
      ENDTRY.

      DATA(lt_return) = me->modify_charc_data( ls_change_data ).

      CALL FUNCTION 'CTMV_CHARACT_INIT'.

      LOOP AT lt_return ASSIGNING FIELD-SYMBOL(<ls_return>)
        WHERE
          type CA gc_error_types.
        me->add_charc_desc_message(
          EXPORTING
            iv_root_charcinternalid = <ls_update>-charcinternalid
            iv_charcinternalid      = <ls_update>-charcinternalid
            iv_language             = <ls_update>-language
            iv_cid                  = <ls_update>-%cid_ref
            iv_set_failed           = abap_true
            iv_new                  = lv_new
            is_bapiret              = <ls_return>
          CHANGING
            ct_reported             = et_reported
            ct_failed               = et_failed ).
      ENDLOOP.

      IF sy-subrc <> 0.
        <ls_change_data> = ls_change_data.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.