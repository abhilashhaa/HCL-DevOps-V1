  METHOD if_ngc_bil_chr~create_charc_desc.

    FIELD-SYMBOLS:
      <ls_charc_create_data> TYPE lty_s_charc_data.


    CLEAR: et_failed, et_mapped, et_reported.


    LOOP AT it_create ASSIGNING FIELD-SYMBOL(<ls_create>).
      LOOP AT <ls_create>-%target ASSIGNING FIELD-SYMBOL(<ls_charc_desc>).
        UNASSIGN <ls_charc_create_data>.

        me->get_ancestor_idx(
          EXPORTING
            iv_cid_ref      = <ls_create>-%cid_ref
*           iv_changenumber = <ls_charc_desc>-changenumber
          IMPORTING
            ev_root_idx     = DATA(lv_root_idx) ).

        IF lv_root_idx IS INITIAL.
          DATA(lv_new) = me->load_charc_data(
            iv_charcinternalid = <ls_create>-charcinternalid ).
*            iv_changenumber    = <ls_charc_desc>-changenumber ).
*          ASSIGN mt_charc_change_data[ charc-charcinternalid = <ls_create>-charcinternalid changenumber = <ls_charc_desc>-changenumber ] TO <ls_charc_create_data>.
          ASSIGN mt_charc_change_data[ charc-charcinternalid = <ls_create>-charcinternalid ] TO <ls_charc_create_data>.
        ELSE.
          ASSIGN mt_charc_create_data[ lv_root_idx ] TO <ls_charc_create_data>.
        ENDIF.

*--------------------------------------------------------------------*
* Check change number
*--------------------------------------------------------------------*

        IF <ls_charc_desc>-changenumber IS NOT INITIAL.
          " Using a change number is not supported
          MESSAGE e047(ngc_rap) INTO DATA(lv_message).
          me->add_charc_desc_message(
            EXPORTING
              iv_root_charcinternalid = <ls_create>-charcinternalid
              iv_charcinternalid      = <ls_charc_desc>-charcinternalid
              iv_language             = <ls_charc_desc>-language
              iv_cid                  = <ls_charc_desc>-%cid
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
          me->add_charc_desc_message(
            EXPORTING
              iv_root_charcinternalid = <ls_create>-charcinternalid
              iv_charcinternalid      = <ls_charc_desc>-charcinternalid
              iv_language             = <ls_charc_desc>-language
              iv_cid                  = <ls_charc_desc>-%cid
              iv_set_failed           = abap_true
              iv_new                  = lv_new
            CHANGING
              ct_reported             = et_reported
              ct_failed               = et_failed ).

          CONTINUE.
        ENDIF.

        " Do VDM to API mapping
        DATA(ls_charc_desc_vdm) = VALUE i_clfncharcdescforkeydatetp( ).
        ls_charc_desc_vdm = CORRESPONDING #( <ls_charc_desc> ).
        DATA(ls_charc_desc_api) = me->map_charc_desc_vdm_api( ls_charc_desc_vdm ).

        IF ls_charc_desc_api-description IS INITIAL.
          " No description defined in language &1
          MESSAGE e011(ngc_rap) WITH ls_charc_desc_api-language_int INTO lv_message.
          me->add_charc_desc_message(
            EXPORTING
              iv_root_charcinternalid = <ls_create>-charcinternalid
              iv_charcinternalid      = <ls_charc_desc>-charcinternalid
              iv_language             = <ls_charc_desc>-language
              iv_cid                  = <ls_charc_desc>-%cid
              iv_set_failed           = abap_true
              iv_new                  = lv_new
            CHANGING
              ct_reported             = et_reported
              ct_failed               = et_failed ).

          CONTINUE.
        ENDIF.

        IF line_exists( <ls_charc_create_data>-charcdesc[ language_int = ls_charc_desc_api-language_int ] ).
          " Description already created in language &1
          MESSAGE e007(ngc_rap) WITH <ls_charc_desc>-language INTO lv_message.
          me->add_charc_desc_message(
            EXPORTING
              iv_root_charcinternalid = <ls_create>-charcinternalid
              iv_charcinternalid      = <ls_charc_desc>-charcinternalid
              iv_language             = <ls_charc_desc>-language
              iv_cid                  = <ls_charc_desc>-%cid
              iv_set_failed           = abap_true
              iv_new                  = lv_new
            CHANGING
              ct_reported             = et_reported
              ct_failed               = et_failed ).

          CONTINUE.
        ENDIF.

        " Do key mapping
        APPEND INITIAL LINE TO et_mapped ASSIGNING FIELD-SYMBOL(<ls_mapped>).
        <ls_mapped>-%cid            = <ls_charc_desc>-%cid.
        <ls_mapped>-charcinternalid = <ls_charc_create_data>-charc-charcinternalid.
        <ls_mapped>-language        = ls_charc_desc_api-language_int.

        " Execute checks
        DATA(ls_charc_create_data) = <ls_charc_create_data>.
        APPEND INITIAL LINE TO ls_charc_create_data-charcdesc ASSIGNING FIELD-SYMBOL(<ls_charc_desc_create>).
        <ls_charc_desc_create> = CORRESPONDING #( ls_charc_desc_api ).

        DATA(lt_return) = me->modify_charc_data(
          is_charc_data  = ls_charc_create_data
          iv_deep_insert = boolc( lv_root_idx IS NOT INITIAL ) ).

        CALL FUNCTION 'CTMV_CHARACT_INIT'.

        LOOP AT lt_return ASSIGNING FIELD-SYMBOL(<ls_return>)
          WHERE
            type CA gc_error_types.
          me->add_charc_desc_message(
            EXPORTING
              iv_root_charcinternalid = <ls_create>-charcinternalid
              iv_charcinternalid      = <ls_charc_desc>-charcinternalid
              iv_language             = <ls_charc_desc>-language
              iv_cid                  = <ls_charc_desc>-%cid
              iv_set_failed           = abap_true
              iv_new                  = lv_new
              is_bapiret              = <ls_return>
            CHANGING
              ct_reported             = et_reported
              ct_failed               = et_failed ).
        ENDLOOP.

        IF sy-subrc <> 0.
          <ls_charc_create_data> = ls_charc_create_data.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.