  METHOD load_class_data.

    DATA:
      lt_class_desc    TYPE tt_bapi1003_catch_new,
      lt_class_keyword TYPE lty_t_class_keyword,
      lt_class_text    TYPE tt_bapi1003_longtext,
      lt_class_charc   TYPE lty_t_class_charc.


    IF NOT line_exists( mt_class_change[ classinternalid = iv_classinternalid ] ).

      me->read_class_data_by_id(
        EXPORTING
          iv_classinternalid = iv_classinternalid
        IMPORTING
          es_class           = DATA(ls_class_vdm)
          et_classdesc       = DATA(lt_class_desc_vdm)
          et_classkeyword    = DATA(lt_class_keyword_vdm)
          et_classtext       = DATA(lt_class_text_vdm)
          et_classcharc      = DATA(lt_class_charc_vdm) ).

      CHECK ls_class_vdm IS NOT INITIAL.

      DATA(ls_class_basic) = me->map_classbasic_vdm_api(
        EXPORTING
          is_class_vdm      = ls_class_vdm ).

      LOOP AT lt_class_desc_vdm ASSIGNING FIELD-SYMBOL(<ls_class_desc_vdm>).
        DATA(ls_class_desc) = me->map_classdesc_vdm_api(
          EXPORTING
            is_classdesc_vdm = <ls_class_desc_vdm> ).
        APPEND ls_class_desc TO lt_class_desc.
      ENDLOOP.

      LOOP AT lt_class_keyword_vdm ASSIGNING FIELD-SYMBOL(<ls_class_keyword_vdm>).
        DATA(ls_class_keyword) = me->map_classkeyword_vdm_api(
          EXPORTING
            is_classkeyword_vdm = <ls_class_keyword_vdm> ).

        APPEND INITIAL LINE TO lt_class_keyword ASSIGNING FIELD-SYMBOL(<ls_class_keyword>).
        <ls_class_keyword> = ls_class_keyword.
        <ls_class_keyword>-classkeywordpositionnumber = <ls_class_keyword_vdm>-classkeywordpositionnumber.
      ENDLOOP.

      LOOP AT lt_class_text_vdm ASSIGNING FIELD-SYMBOL(<ls_class_text_vdm>).
        DATA(ls_class_text) = me->map_classtext_vdm_api( is_classtext_vdm = <ls_class_text_vdm> ).
        APPEND ls_class_text TO lt_class_text.
      ENDLOOP.

      LOOP AT lt_class_charc_vdm ASSIGNING FIELD-SYMBOL(<ls_class_charc_vdm>).
        DATA(ls_class_charc) = me->map_classcharc_vdm_api( is_classcharc_vdm = <ls_class_charc_vdm> ).

        APPEND INITIAL LINE TO lt_class_charc ASSIGNING FIELD-SYMBOL(<ls_class_charc>).
        <ls_class_charc> = ls_class_charc.
        <ls_class_charc>-charcinternalid = <ls_class_charc_vdm>-charcinternalid.
      ENDLOOP.

      APPEND INITIAL LINE TO mt_class_change ASSIGNING FIELD-SYMBOL(<ls_class_change>).
      <ls_class_change>-classinternalid    = ls_class_vdm-classinternalid.
      <ls_class_change>-class              = ls_class_vdm-class.
      <ls_class_change>-classtype          = ls_class_vdm-classtype.
      <ls_class_change>-s_classbasic       = ls_class_basic.
      <ls_class_change>-s_classbasic_new   = ls_class_basic.
      <ls_class_change>-t_classdesc        = lt_class_desc.
      <ls_class_change>-t_classdesc_new    = lt_class_desc.
      <ls_class_change>-t_classkeyword     = lt_class_keyword.
      <ls_class_change>-t_classkeyword_new = lt_class_keyword.
      <ls_class_change>-t_classtext        = lt_class_text.
      <ls_class_change>-t_classtext_new    = lt_class_text.
      <ls_class_change>-t_classcharc       = lt_class_charc.
      <ls_class_change>-t_classcharc_new   = lt_class_charc.
    ENDIF.

  ENDMETHOD.