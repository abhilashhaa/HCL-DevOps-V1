  METHOD render_items.

    DATA: lv_class     TYPE string,
          lv_icon      TYPE string,
          lv_id        TYPE string,
          lv_check     TYPE string,
          lv_aux       TYPE string,
          lv_has_icons TYPE abap_bool.

    FIELD-SYMBOLS <ls_item> LIKE LINE OF mt_items.


    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    IF iv_sort = abap_true.
      SORT mt_items BY txt ASCENDING AS TEXT.
    ENDIF.

    " Check has icons or check boxes
    LOOP AT mt_items ASSIGNING <ls_item> WHERE ico IS NOT INITIAL OR chk <> abap_undefined.
      lv_has_icons = abap_true.
      lv_class     = ' class="with-icons"'.
      EXIT.
    ENDLOOP.

    IF mv_id IS NOT INITIAL.
      lv_id = | id="{ mv_id }"|.
    ENDIF.

    ri_html->add( |<ul{ lv_id }{ lv_class }>| ).

    " Render items
    LOOP AT mt_items ASSIGNING <ls_item>.
      CLEAR: lv_class, lv_icon.

      IF <ls_item>-typ = zif_abapgit_html=>c_action_type-separator.
        ri_html->add( |<li class="separator">{ <ls_item>-txt }</li>| ).
        CONTINUE.
      ENDIF.

      IF lv_has_icons = abap_true.
        IF <ls_item>-chk = abap_true.
          lv_icon  = ri_html->icon( 'check/blue' ).
          lv_check = ' data-check="X"'.
        ELSEIF <ls_item>-chk = abap_false.
          lv_icon = ri_html->icon( 'check/grey' ).
          lv_check = ' data-check=""'.
        ELSE. " abap_undefined -> not a check box
          lv_icon = ri_html->icon( <ls_item>-ico ).
        ENDIF.
      ENDIF.

      IF <ls_item>-cur = abap_true.
        lv_class = ' class="current-menu-item"'.
      ENDIF.

      IF <ls_item>-aux IS NOT INITIAL.
        lv_aux = | data-aux="{ <ls_item>-aux }"|.
      ENDIF.

      ri_html->add( |<li{ lv_class }{ lv_check }{ lv_aux }>| ).
      IF <ls_item>-sub IS INITIAL.
        ri_html->add_a( iv_txt   = lv_icon && <ls_item>-txt
                        iv_typ   = <ls_item>-typ
                        iv_act   = <ls_item>-act
                        iv_id    = <ls_item>-id
                        iv_opt   = <ls_item>-opt
                        iv_title = <ls_item>-title ).
      ELSE.
        ri_html->add_a( iv_txt   = lv_icon && <ls_item>-txt
                        iv_typ   = zif_abapgit_html=>c_action_type-dummy
                        iv_act   = ''
                        iv_id    = <ls_item>-id
                        iv_opt   = <ls_item>-opt
                        iv_title = <ls_item>-title ).
        ri_html->add( <ls_item>-sub->render_items( iv_sort ) ).
      ENDIF.
      ri_html->add( '</li>' ).

    ENDLOOP.

    ri_html->add( '</ul>' ).

  ENDMETHOD.