  METHOD render_error.

    DATA lv_error TYPE string.
    DATA lv_class TYPE string VALUE 'panel error center'.

    IF iv_extra_style IS NOT INITIAL.
      lv_class = lv_class && ` ` && iv_extra_style.
    ENDIF.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    IF ix_error IS BOUND.
      lv_error = ix_error->get_text( ).
    ELSE.
      lv_error = iv_error.
    ENDIF.

    ri_html->add( |<div class="{ lv_class }">| ).
    ri_html->add( |{ ri_html->icon( 'exclamation-circle/red' ) } { lv_error }| ).
    ri_html->add( '</div>' ).

  ENDMETHOD.