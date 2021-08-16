  METHOD render.

    DATA: lo_repo TYPE REF TO zcl_abapgit_repo_online,
          ls_per  TYPE zcl_abapgit_persist_background=>ty_background.


    lo_repo ?= zcl_abapgit_repo_srv=>get_instance( )->get( mv_key ).
    ls_per = read_persist( lo_repo ).


    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( '<div id="toc" class="settings_container">' ).

    ri_html->add( zcl_abapgit_gui_chunk_lib=>render_repo_top( lo_repo ) ).
    ri_html->add( '<br>' ).

    ri_html->add( render_methods( ls_per ) ).

    ri_html->add( '<u>HTTP Authentication, optional</u><br>' ).
    ri_html->add( '(password will be saved in clear text)<br>' ).
    ri_html->add( '<table>' ).
    ri_html->add( '<tr>' ).
    ri_html->add( '<td>Username:</td>' ).
    ri_html->add( '<td><input type="text" name="username" value="' && ls_per-username && '"></td>' ).
    ri_html->add( '</tr>' ).
    ri_html->add( '<tr>' ).
    ri_html->add( '<td>Password:</td>' ).
    ri_html->add( '<td><input type="text" name="password" value="' && ls_per-password && '"></td>' ).
    ri_html->add( '</tr>' ).
    ri_html->add( '</table>' ).

    ri_html->add( '<br>' ).

    ri_html->add( render_settings( ls_per ) ).

    ri_html->add( '<br>' ).
    ri_html->add( '<input type="submit" value="Save">' ).

    ri_html->add( '</form>' ).
    ri_html->add( '<br>' ).

    ri_html->add( '</div>' ).

  ENDMETHOD.