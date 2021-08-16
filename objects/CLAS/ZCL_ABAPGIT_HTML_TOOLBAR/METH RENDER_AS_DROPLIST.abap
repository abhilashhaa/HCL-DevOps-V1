  METHOD render_as_droplist.

    DATA: lv_class TYPE string.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    lv_class = 'nav-container'.
    IF iv_right = abap_true.
      lv_class = lv_class && ' float-right'.
    ENDIF.
    IF iv_corner = abap_true.
      lv_class = lv_class && ' corner'.
    ENDIF.

    ri_html->add( |<div class="{ lv_class }">| ).
    ri_html->add( '<ul><li>' ).
    ri_html->add_a( iv_txt = iv_label
                    iv_typ = zif_abapgit_html=>c_action_type-sapevent
                    iv_act = iv_action ).
    ri_html->add( '<div class="minizone"></div>' ).
    ri_html->add( render_items( iv_sort = iv_sort ) ).
    ri_html->add( '</li></ul>' ).
    ri_html->add( '</div>' ).

  ENDMETHOD.