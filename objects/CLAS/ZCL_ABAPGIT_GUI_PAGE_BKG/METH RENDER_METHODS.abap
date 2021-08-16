  METHOD render_methods.

    DATA: lt_methods TYPE zcl_abapgit_background=>ty_methods_tt,
          ls_method  LIKE LINE OF lt_methods,
          lv_checked TYPE string.


    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    lt_methods = zcl_abapgit_background=>list_methods( ).

    ri_html->add( '<u>Method</u><br>' ).
    ri_html->add( |<form method="get" action="sapevent:{ zif_abapgit_definitions=>c_action-bg_update }">| ).

    IF is_per-method IS INITIAL.
      lv_checked = ' checked'.
    ENDIF.

    ri_html->add( '<input type="radio" name="method" value=""' && lv_checked && '>Do nothing<br>' ).

    LOOP AT lt_methods INTO ls_method.
      CLEAR lv_checked.
      IF is_per-method = ls_method-class.
        lv_checked = ' checked'.
      ENDIF.

      ri_html->add( '<input type="radio" name="method" value="' &&
        ls_method-class && '"' &&
        lv_checked && '>' &&
        ls_method-description && '<br>' ).
    ENDLOOP.

    ri_html->add( '<br>' ).

  ENDMETHOD.