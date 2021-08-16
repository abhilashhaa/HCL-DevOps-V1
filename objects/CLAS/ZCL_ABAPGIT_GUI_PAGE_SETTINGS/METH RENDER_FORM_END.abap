  METHOD render_form_end.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.
    ri_html->add( '<input type="submit" value="Save" class="floating-button blue-set emphasis">' ).
    ri_html->add( '</form>' ).
    ri_html->add( '</div>' ).

  ENDMETHOD.