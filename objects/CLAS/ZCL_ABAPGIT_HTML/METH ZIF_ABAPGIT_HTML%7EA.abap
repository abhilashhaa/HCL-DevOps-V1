  METHOD zif_abapgit_html~a.

    DATA: lv_class TYPE string,
          lv_href  TYPE string,
          lv_click TYPE string,
          lv_id    TYPE string,
          lv_style TYPE string,
          lv_title TYPE string.

    lv_class = iv_class.

    IF iv_opt CA zif_abapgit_html=>c_html_opt-strong.
      lv_class = lv_class && ' emphasis'.
    ENDIF.
    IF iv_opt CA zif_abapgit_html=>c_html_opt-cancel.
      lv_class = lv_class && ' attention'.
    ENDIF.
    IF iv_opt CA zif_abapgit_html=>c_html_opt-crossout.
      lv_class = lv_class && ' crossout grey'.
    ENDIF.
    IF lv_class IS NOT INITIAL.
      SHIFT lv_class LEFT DELETING LEADING space.
      lv_class = | class="{ lv_class }"|.
    ENDIF.

    lv_href  = ' href="#"'. " Default, dummy
    IF ( iv_act IS NOT INITIAL OR iv_typ = zif_abapgit_html=>c_action_type-dummy )
        AND iv_opt NA zif_abapgit_html=>c_html_opt-crossout.
      CASE iv_typ.
        WHEN zif_abapgit_html=>c_action_type-url.
          lv_href  = | href="{ iv_act }"|.
        WHEN zif_abapgit_html=>c_action_type-sapevent.
          lv_href  = | href="sapevent:{ iv_act }"|.
        WHEN zif_abapgit_html=>c_action_type-onclick.
          lv_href  = ' href="#"'.
          lv_click = | onclick="{ iv_act }"|.
        WHEN zif_abapgit_html=>c_action_type-dummy.
          lv_href  = ' href="#"'.
      ENDCASE.
    ENDIF.

    IF iv_id IS NOT INITIAL.
      lv_id = | id="{ iv_id }"|.
    ENDIF.

    IF iv_style IS NOT INITIAL.
      lv_style = | style="{ iv_style }"|.
    ENDIF.

    IF iv_title IS NOT INITIAL.
      lv_title = | title="{ iv_title }"|.
    ENDIF.

    rv_str = |<a{ lv_id }{ lv_class }{ lv_href }{ lv_click }{ lv_style }{ lv_title }>|
          && |{ iv_txt }</a>|.

  ENDMETHOD.