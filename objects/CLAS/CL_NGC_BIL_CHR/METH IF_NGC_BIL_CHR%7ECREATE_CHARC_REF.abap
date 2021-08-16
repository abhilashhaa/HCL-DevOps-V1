  METHOD if_ngc_bil_chr~create_charc_ref.

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

      LOOP AT <ls_create>-%target ASSIGNING FIELD-SYMBOL(<ls_charc_ref>).
        IF <ls_charc_create_data> IS NOT ASSIGNED.
          " Characteristic does not exist
          MESSAGE e026(ngc_rap) INTO DATA(lv_message).
          me->add_charc_ref_message(
            EXPORTING
              iv_root_charcinternalid = <ls_create>-charcinternalid
              iv_charcinternalid      = <ls_charc_ref>-charcinternalid
              iv_charc_ref_table      = <ls_charc_ref>-charcreferencetable
              iv_charc_ref_field      = <ls_charc_ref>-charcreferencetablefield
              iv_cid                  = <ls_charc_ref>-%cid
              iv_set_failed           = abap_true
              iv_new                  = lv_new
            CHANGING
              ct_reported             = et_reported
              ct_failed               = et_failed ).

          CONTINUE.
        ENDIF.

        IF line_exists( <ls_charc_create_data>-charcref[
            reference_table = <ls_charc_ref>-charcreferencetable
            reference_field = <ls_charc_ref>-charcreferencetablefield ] ).
          " Characteristic reference to field &1 of table &2 already exists
          MESSAGE e036(ngc_rap) WITH <ls_charc_ref>-charcreferencetablefield <ls_charc_ref>-charcreferencetable INTO lv_message.
          me->add_charc_ref_message(
            EXPORTING
              iv_root_charcinternalid = <ls_create>-charcinternalid
              iv_charcinternalid      = <ls_charc_ref>-charcinternalid
              iv_charc_ref_table      = <ls_charc_ref>-charcreferencetable
              iv_charc_ref_field      = <ls_charc_ref>-charcreferencetablefield
              iv_cid                  = <ls_charc_ref>-%cid
              iv_set_failed           = abap_true
              iv_new                  = lv_new
            CHANGING
              ct_reported             = et_reported
              ct_failed               = et_failed ).

          CONTINUE.
        ENDIF.

        " Do VDM to API mapping
        DATA(ls_charc_ref_vdm) = VALUE i_clfncharcrefforkeydatetp( ).
        ls_charc_ref_vdm = CORRESPONDING #( <ls_charc_ref> ).
        DATA(ls_charc_ref_api) = me->map_charc_ref_vdm_api( ls_charc_ref_vdm ).

        " Do key mapping
        APPEND INITIAL LINE TO et_mapped ASSIGNING FIELD-SYMBOL(<ls_mapped>).
        <ls_mapped>-%cid                     = <ls_charc_ref>-%cid.
        <ls_mapped>-charcinternalid          = <ls_charc_create_data>-charc-charcinternalid.
        <ls_mapped>-charcreferencetable      = ls_charc_ref_api-reference_table.
        <ls_mapped>-charcreferencetablefield = ls_charc_ref_api-reference_field.

        " Execute checks
        DATA(ls_charc_create_data) = <ls_charc_create_data>.
        APPEND INITIAL LINE TO ls_charc_create_data-charcref ASSIGNING FIELD-SYMBOL(<ls_charc_ref_create>).
        <ls_charc_ref_create> = CORRESPONDING #( ls_charc_ref_api ).

        DATA(lt_return) = me->modify_charc_data(
          is_charc_data  = ls_charc_create_data
          iv_deep_insert = boolc( lv_root_idx IS NOT INITIAL ) ).

        CALL FUNCTION 'CTMV_CHARACT_INIT'.

        LOOP AT lt_return ASSIGNING FIELD-SYMBOL(<ls_return>)
          WHERE
            type CA gc_error_types.
          me->add_charc_ref_message(
            EXPORTING
              iv_root_charcinternalid = <ls_create>-charcinternalid
              iv_charcinternalid      = <ls_charc_ref>-charcinternalid
              iv_charc_ref_table      = <ls_charc_ref>-charcreferencetable
              iv_charc_ref_field      = <ls_charc_ref>-charcreferencetablefield
              iv_cid                  = <ls_charc_ref>-%cid
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