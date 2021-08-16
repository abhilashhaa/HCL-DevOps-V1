  METHOD if_ngc_bil_chr~create_charc_val_desc.

    FIELD-SYMBOLS:
      <ls_charc_create_data>     TYPE lty_s_charc_data,
      <ls_charc_val_create_data> TYPE lty_s_charcval_create.


    CLEAR: et_failed, et_mapped, et_reported.


    LOOP AT it_create ASSIGNING FIELD-SYMBOL(<ls_create>).
      LOOP AT <ls_create>-%target ASSIGNING FIELD-SYMBOL(<ls_charc_val_desc>).
        UNASSIGN <ls_charc_create_data>.

        me->get_ancestor_idx(
          EXPORTING
            iv_cid_ref      = <ls_create>-%cid_ref
*           iv_changenumber = <ls_charc_val_desc>-changenumber
          IMPORTING
            ev_root_idx     = DATA(lv_root_idx)
            ev_parent_idx   = DATA(lv_parent_idx) ).

        IF lv_root_idx IS INITIAL.
          DATA(lv_new) = me->load_charc_data(
            iv_charcinternalid = <ls_create>-charcinternalid ).
*            iv_changenumber    = <ls_charc_val_desc>-changenumber ).

          LOOP AT mt_charc_change_data ASSIGNING <ls_charc_create_data>.
            IF lv_parent_idx IS INITIAL.
              ASSIGN <ls_charc_create_data>-charcval[ charcvaluepositionnumber = <ls_create>-charcvaluepositionnumber ] TO <ls_charc_val_create_data>.
            ELSE.
              ASSIGN <ls_charc_create_data>-charcval[ lv_parent_idx ] TO <ls_charc_val_create_data>.
            ENDIF.

            IF <ls_charc_val_create_data> IS ASSIGNED.
              EXIT.
            ENDIF.
          ENDLOOP.
        ELSE.
          ASSIGN mt_charc_create_data[ lv_root_idx ] TO <ls_charc_create_data>.
          ASSIGN <ls_charc_create_data>-charcval[ lv_parent_idx ] TO <ls_charc_val_create_data>.
        ENDIF.

*--------------------------------------------------------------------*
* Check change number
*--------------------------------------------------------------------*

        IF <ls_charc_val_desc>-changenumber IS NOT INITIAL.
          " Using a change number is not supported
          MESSAGE e047(ngc_rap) INTO DATA(lv_message).
          me->add_charc_val_desc_message(
            EXPORTING
              iv_root_charcinternalid = <ls_create>-charcinternalid
              iv_charcinternalid      = <ls_charc_val_desc>-charcinternalid
              iv_position_number      = <ls_charc_val_desc>-charcvaluepositionnumber
              iv_language             = <ls_charc_val_desc>-language
              iv_cid                  = <ls_charc_val_desc>-%cid
              iv_set_failed           = abap_true
              iv_new                  = lv_new
            CHANGING
              ct_reported             = et_reported
              ct_failed               = et_failed ).

          CONTINUE.
        ENDIF.

        IF <ls_charc_create_data> IS NOT ASSIGNED.
          " Characteristic does not exist
          MESSAGE e026(ngc_rap) INTO lv_message.
          me->add_charc_val_desc_message(
            EXPORTING
              iv_root_charcinternalid = <ls_create>-charcinternalid
              iv_charcinternalid      = <ls_charc_val_desc>-charcinternalid
              iv_position_number      = <ls_charc_val_desc>-charcvaluepositionnumber
              iv_language             = <ls_charc_val_desc>-language
              iv_cid                  = <ls_charc_val_desc>-%cid
              iv_set_failed           = abap_true
              iv_new                  = lv_new
            CHANGING
              ct_reported             = et_reported
              ct_failed               = et_failed ).

          CONTINUE.
        ENDIF.

        IF <ls_charc_val_create_data> IS NOT ASSIGNED.
          " Characteristic value at position &1 does not exist
          MESSAGE e016(ngc_rap) WITH <ls_charc_val_desc>-charcvaluepositionnumber INTO lv_message.
          me->add_charc_val_desc_message(
            EXPORTING
              iv_root_charcinternalid = <ls_create>-charcinternalid
              iv_charcinternalid      = <ls_charc_val_desc>-charcinternalid
              iv_position_number      = <ls_charc_val_desc>-charcvaluepositionnumber
              iv_language             = <ls_charc_val_desc>-language
              iv_cid                  = <ls_charc_val_desc>-%cid
              iv_set_failed           = abap_true
              iv_new                  = lv_new
            CHANGING
              ct_reported             = et_reported
              ct_failed               = et_failed ).

          CONTINUE.
        ENDIF.

        IF line_exists( <ls_charc_create_data>-charcvaldesc[ value_char = <ls_charc_val_create_data>-charcvalue language_int = <ls_charc_val_desc>-language ] ).
          " Characteristic value description in language &1 already exists
          MESSAGE e021(ngc_rap) WITH <ls_charc_val_desc>-language INTO lv_message.
          me->add_charc_val_desc_message(
            EXPORTING
              iv_root_charcinternalid = <ls_create>-charcinternalid
              iv_charcinternalid      = <ls_charc_val_desc>-charcinternalid
              iv_position_number      = <ls_charc_val_desc>-charcvaluepositionnumber
              iv_language             = <ls_charc_val_desc>-language
              iv_cid                  = <ls_charc_val_desc>-%cid
              iv_set_failed           = abap_true
              iv_new                  = lv_new
            CHANGING
              ct_reported             = et_reported
              ct_failed               = et_failed ).

          CONTINUE.
        ENDIF.

        " Do VDM to API mapping
        DATA(ls_charc_val_desc_vdm) = VALUE i_clfncharcvaldescforkeydatetp( ).
        ls_charc_val_desc_vdm = CORRESPONDING #( <ls_charc_val_desc> ).
        DATA(ls_charc_val_desc_api) = me->map_charc_val_desc_vdm_api(
          is_charc_val_desc_vdm = ls_charc_val_desc_vdm
          is_charc_val          = <ls_charc_val_create_data> ).

        " Do key mapping
        APPEND INITIAL LINE TO et_mapped ASSIGNING FIELD-SYMBOL(<ls_mapped>).
        <ls_mapped>-%cid                     = <ls_charc_val_desc>-%cid.
        <ls_mapped>-charcinternalid          = <ls_charc_create_data>-charc-charcinternalid.
        <ls_mapped>-charcvaluepositionnumber = <ls_charc_val_create_data>-charcvaluepositionnumber.
        <ls_mapped>-language                 = ls_charc_val_desc_api-language_int.

        " Execute checks
        DATA(ls_charc_create_data) = <ls_charc_create_data>.
        APPEND INITIAL LINE TO ls_charc_create_data-charcvaldesc ASSIGNING FIELD-SYMBOL(<ls_charc_val_desc_create>).
        <ls_charc_val_desc_create> = ls_charc_val_desc_api.

        DATA(lt_return) = me->modify_charc_data(
          is_charc_data  = ls_charc_create_data
          iv_deep_insert = boolc( lv_root_idx IS NOT INITIAL ) ).

        CALL FUNCTION 'CTMV_CHARACT_INIT'.

        LOOP AT lt_return ASSIGNING FIELD-SYMBOL(<ls_return>)
          WHERE
            type CA gc_error_types.
          me->add_charc_val_desc_message(
            EXPORTING
              iv_root_charcinternalid = <ls_create>-charcinternalid
              iv_charcinternalid      = <ls_charc_val_desc>-charcinternalid
              iv_position_number      = <ls_charc_val_desc>-charcvaluepositionnumber
              iv_language             = <ls_charc_val_desc>-language
              iv_cid                  = <ls_charc_val_desc>-%cid
              iv_set_failed           = abap_true
              iv_new                  = lv_new
              is_bapiret              = <ls_return>
            CHANGING
              ct_reported             = et_reported
              ct_failed               = et_failed ).
        ENDLOOP.

        IF sy-subrc <> 0.
          <ls_charc_create_data> = ls_charc_create_data.
          ASSIGN <ls_charc_create_data>-charcval[ lv_parent_idx ] TO <ls_charc_val_create_data>.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.