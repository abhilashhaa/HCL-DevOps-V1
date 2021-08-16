  METHOD if_ngc_bil_chr~create_charc_rstr.

    FIELD-SYMBOLS:
      <ls_charc_create_data> TYPE lty_s_charc_data.


    CLEAR: et_failed, et_mapped, et_reported.


    LOOP AT it_create ASSIGNING FIELD-SYMBOL(<ls_create>).
      UNASSIGN <ls_charc_create_data>.

      me->get_ancestor_idx(
        EXPORTING
          iv_cid_ref = <ls_create>-%cid_ref
        IMPORTING
          ev_root_idx = DATA(lv_root_idx) ).

      IF lv_root_idx IS INITIAL.
        DATA(lv_new) = me->load_charc_data( <ls_create>-charcinternalid ).
        ASSIGN mt_charc_change_data[ charc-cid = <ls_create>-%cid_ref ] TO <ls_charc_create_data>.
      ELSE.
        ASSIGN mt_charc_create_data[ charc-cid = <ls_create>-%cid_ref ] TO <ls_charc_create_data>.
      ENDIF.

      LOOP AT <ls_create>-%target ASSIGNING FIELD-SYMBOL(<ls_charc_rstr>).
        IF <ls_charc_create_data> IS NOT ASSIGNED.
          " Characteristic does not exist
          MESSAGE e026(ngc_rap) INTO DATA(lv_message).
          me->add_charc_rstr_message(
            EXPORTING
              iv_root_charcinternalid = <ls_create>-charcinternalid
              iv_charcinternalid      = <ls_charc_rstr>-charcinternalid
              iv_classtype            = <ls_charc_rstr>-classtype
              iv_cid                  = <ls_charc_rstr>-%cid
              iv_set_failed           = abap_true
              iv_new                  = lv_new
            CHANGING
              ct_reported             = et_reported
              ct_failed               = et_failed ).

          CONTINUE.
        ENDIF.

        IF line_exists( <ls_charc_create_data>-charcrstr[ class_type = <ls_charc_rstr>-classtype ] ).
          " Characteristic restriction to class type &1 already exists
          MESSAGE e037(ngc_rap) WITH <ls_charc_rstr>-classtype INTO lv_message.
          me->add_charc_rstr_message(
            EXPORTING
              iv_root_charcinternalid = <ls_create>-charcinternalid
              iv_charcinternalid      = <ls_charc_rstr>-charcinternalid
              iv_classtype            = <ls_charc_rstr>-classtype
              iv_cid                  = <ls_charc_rstr>-%cid
              iv_set_failed           = abap_true
              iv_new                  = lv_new
            CHANGING
              ct_reported             = et_reported
              ct_failed               = et_failed ).

          CONTINUE.
        ENDIF.

        " Do VDM to API mapping
        DATA(ls_charc_rstr_vdm) = VALUE i_clfncharcrstrcnforkeydatetp( ).
        ls_charc_rstr_vdm = CORRESPONDING #( <ls_charc_rstr> ).
        DATA(ls_charc_rstr_api) = me->map_charc_rstr_vdm_api( ls_charc_rstr_vdm ).

        " Do key mapping
        APPEND INITIAL LINE TO et_mapped ASSIGNING FIELD-SYMBOL(<ls_mapped>).
        <ls_mapped>-%cid            = <ls_charc_rstr>-%cid.
        <ls_mapped>-charcinternalid = <ls_charc_create_data>-charc-charcinternalid.
        <ls_mapped>-classtype       = ls_charc_rstr_api-class_type.

        " Execute checks
        DATA(ls_charc_create_data) = <ls_charc_create_data>.
        APPEND INITIAL LINE TO ls_charc_create_data-charcrstr ASSIGNING FIELD-SYMBOL(<ls_charc_rstr_create>).
        <ls_charc_rstr_create> = CORRESPONDING #( ls_charc_rstr_api ).

        DATA(lt_return) = me->modify_charc_data(
          is_charc_data  = ls_charc_create_data
          iv_deep_insert = boolc( lv_root_idx IS NOT INITIAL ) ).

        CALL FUNCTION 'CTMV_CHARACT_INIT'.

        LOOP AT lt_return ASSIGNING FIELD-SYMBOL(<ls_return>)
          WHERE
            type CA gc_error_types.
          me->add_charc_rstr_message(
            EXPORTING
              iv_root_charcinternalid = <ls_create>-charcinternalid
              iv_charcinternalid      = <ls_charc_rstr>-charcinternalid
              iv_classtype            = <ls_charc_rstr>-classtype
              iv_cid                  = <ls_charc_rstr>-%cid
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