  METHOD render_content.

    IF mi_child IS BOUND.
      ri_html = mi_child->render( ).
    ENDIF.

  ENDMETHOD.