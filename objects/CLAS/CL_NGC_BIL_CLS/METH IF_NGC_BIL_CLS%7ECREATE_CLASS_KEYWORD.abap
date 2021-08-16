  METHOD if_ngc_bil_cls~create_class_keyword.

    DATA:
      lv_position_tmp TYPE klapos.

    FIELD-SYMBOLS:
      <ls_class_change> TYPE lty_s_class_change.


    CLEAR: et_failed, et_reported, et_mapped.


    LOOP AT it_create ASSIGNING FIELD-SYMBOL(<ls_create>).
      UNASSIGN <ls_class_change>.

      DATA(lv_ancestor_idx) = me->get_ancestor_idx( <ls_create>-%cid_ref ).

      IF lv_ancestor_idx IS INITIAL.
        me->load_class_data( <ls_create>-classinternalid ).
        ASSIGN mt_class_change[ classinternalid = <ls_create>-classinternalid ] TO <ls_class_change>.
      ELSE.
        ASSIGN mt_class_create[ lv_ancestor_idx ] TO <ls_class_change>.
      ENDIF.

      IF <ls_class_change> IS ASSIGNED.
        lv_position_tmp = lines( <ls_class_change>-t_classkeyword_new ) + lines( <ls_class_change>-t_classdesc_new ).
      ENDIF.

      LOOP AT <ls_create>-%target ASSIGNING FIELD-SYMBOL(<ls_class_keyword>).
        lv_position_tmp = lv_position_tmp + 1.

        IF <ls_class_change> IS NOT ASSIGNED.
          " Class does not exist
          MESSAGE e002(ngc_rap) INTO DATA(lv_dummy) ##NEEDED.
          me->add_classkeyword_message(
            EXPORTING
              iv_classinternalid            = <ls_create>-classinternalid
              iv_language                   = <ls_class_keyword>-language
              iv_classkeywordpositionnumber = <ls_class_keyword>-classkeywordpositionnumber
              iv_cid                        = <ls_class_keyword>-%cid
            CHANGING
              ct_reported                   = et_reported
              ct_failed                     = et_failed ).

          CONTINUE.
        ENDIF.

        " Do VDM to API mapping
        DATA(ls_class_keyword_api) = me->map_classkeyword_vdm_api(
          EXPORTING
            is_classkeyword_vdm = CORRESPONDING i_clfnclasskeywordforkeydatetp( <ls_class_keyword> ) ).

        IF line_exists( <ls_class_change>-t_classkeyword_new[
             catchword = ls_class_keyword_api-catchword
             langu     = ls_class_keyword_api-langu ] ).
          " Keyword &1 already created in language &2. Define a different one.
          MESSAGE e005(ngc_rap) WITH ls_class_keyword_api-catchword ls_class_keyword_api-langu INTO lv_dummy ##NEEDED.
          me->add_classkeyword_message(
            EXPORTING
              iv_classinternalid            = <ls_create>-classinternalid
              iv_language                   = <ls_class_keyword>-language
              iv_classkeywordpositionnumber = <ls_class_keyword>-classkeywordpositionnumber
              iv_cid                        = <ls_class_keyword>-%cid
            CHANGING
              ct_reported                   = et_reported
              ct_failed                     = et_failed ).

            DELETE mt_class_change WHERE classinternalid = <ls_class_change>-classinternalid.

          CONTINUE.
        ENDIF.

        IF NOT line_exists( <ls_class_change>-t_classdesc_new[ langu = ls_class_keyword_api-langu ] ).
          " No description defined in language &1
          MESSAGE e011(ngc_rap) WITH ls_class_keyword_api-langu INTO lv_dummy ##NEEDED.
          me->add_classkeyword_message(
            EXPORTING
              iv_classinternalid            = <ls_class_change>-classinternalid
              iv_language                   = <ls_class_keyword>-language
              iv_classkeywordpositionnumber = <ls_class_keyword>-classkeywordpositionnumber
              iv_cid                        = <ls_class_keyword>-%cid
            CHANGING
              ct_reported                   = et_reported
              ct_failed                     = et_failed ).

            DELETE mt_class_change WHERE classinternalid = <ls_class_change>-classinternalid.

          CONTINUE.
        ENDIF.

        " Do key mapping
        APPEND INITIAL LINE TO et_mapped ASSIGNING FIELD-SYMBOL(<ls_mapped>).
        <ls_mapped>-%cid                       = <ls_class_keyword>-%cid.
        <ls_mapped>-classinternalid            = <ls_create>-classinternalid.
        <ls_mapped>-language                   = ls_class_keyword_api-langu.
        <ls_mapped>-classkeywordpositionnumber = lv_position_tmp.

        " Execute checks
        DATA(ls_class_change) = <ls_class_change>.

        APPEND INITIAL LINE TO ls_class_change-t_classkeyword_new ASSIGNING FIELD-SYMBOL(<ls_class_keyword_new>).
        <ls_class_keyword_new>                            = CORRESPONDING #( ls_class_keyword_api ).
        <ls_class_keyword_new>-classkeywordpositionnumber = lv_position_tmp.
        <ls_class_keyword_new>-created                    = abap_true.

        DATA(lt_return) = me->modify_class_data(
          is_class_data   = ls_class_change
          iv_deep_insert  = boolc( lv_ancestor_idx IS NOT INITIAL )
          iv_clear_buffer = abap_true ).

        LOOP AT lt_return ASSIGNING FIELD-SYMBOL(<ls_return>)
          WHERE
            type CA gc_error_types.
          me->add_classkeyword_message(
            EXPORTING
              iv_classinternalid            = <ls_create>-classinternalid
              iv_language                   = ls_class_keyword_api-langu
              iv_cid                        = <ls_class_keyword>-%cid
              iv_classkeywordpositionnumber = lv_position_tmp
              is_bapiret                    = <ls_return>
            CHANGING
              ct_reported                   = et_reported
              ct_failed                     = et_failed ).
        ENDLOOP.

        IF sy-subrc <> 0.
          <ls_class_change> = ls_class_change.

          APPEND gc_operation_type-create_keyword TO <ls_class_change>-t_operation_log.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.