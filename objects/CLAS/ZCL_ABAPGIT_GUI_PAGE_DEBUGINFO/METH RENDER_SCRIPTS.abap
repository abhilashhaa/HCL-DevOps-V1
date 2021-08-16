  METHOD render_scripts.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->set_title( cl_abap_typedescr=>describe_by_object_ref( me )->get_relative_name( ) ).
    ri_html->add( 'debugOutput("<table><tr><td>Browser:</td><td>" + navigator.userAgent + ' &&
      '"</td></tr><tr><td>Frontend time:</td><td>" + new Date() + "</td></tr></table>", "debug_info");' ).

  ENDMETHOD.