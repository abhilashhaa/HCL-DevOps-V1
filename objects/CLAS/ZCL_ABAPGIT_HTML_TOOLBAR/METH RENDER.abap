  METHOD render.

    DATA: lv_class TYPE string.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    lv_class = 'nav-container'.
    IF iv_right = abap_true.
      lv_class = lv_class && ' float-right'.
    ENDIF.

    ri_html->add( |<div class="{ lv_class }">| ).
    ri_html->add( render_items( iv_sort = iv_sort ) ).
    ri_html->add( '</div>' ).

  ENDMETHOD.