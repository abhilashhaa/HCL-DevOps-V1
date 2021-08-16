  METHOD render_debug_info.

    DATA: lt_ver_tab     TYPE filetable,
          lv_rc          TYPE i,
          lv_gui_version TYPE string,
          ls_version     LIKE LINE OF lt_ver_tab,
          lv_devclass    TYPE devclass.

    cl_gui_frontend_services=>get_gui_version(
      CHANGING version_table = lt_ver_tab rc = lv_rc
      EXCEPTIONS OTHERS = 1 ).
    READ TABLE lt_ver_tab INTO ls_version INDEX 1. " gui release
    lv_gui_version = ls_version-filename.
    READ TABLE lt_ver_tab INTO ls_version INDEX 2. " gui sp
    lv_gui_version = |{ lv_gui_version }.{ ls_version-filename }|.
    READ TABLE lt_ver_tab INTO ls_version INDEX 3. " gui patch
    lv_gui_version = |{ lv_gui_version }.{ ls_version-filename }|.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( |<table>| ).
    ri_html->add( |<tr><td>abapGit version:</td><td>{ zif_abapgit_version=>gc_abap_version }</td></tr>| ).
    ri_html->add( |<tr><td>XML version:    </td><td>{ zif_abapgit_version=>gc_xml_version }</td></tr>| ).
    ri_html->add( |<tr><td>GUI version:    </td><td>{ lv_gui_version }</td></tr>| ).
    ri_html->add( |<tr><td>APACK version:  </td><td>{
                  zcl_abapgit_apack_migration=>c_apack_interface_version }</td></tr>| ).
    ri_html->add( |<tr><td>LCL_TIME:       </td><td>{ zcl_abapgit_time=>get_unix( ) }</td></tr>| ).
    ri_html->add( |<tr><td>SY time:        </td><td>{ sy-datum } { sy-uzeit } { sy-tzone }</td></tr>| ).
    ri_html->add( |</table>| ).
    ri_html->add( |<br>| ).

    lv_devclass = zcl_abapgit_services_abapgit=>is_installed( ).
    IF NOT lv_devclass IS INITIAL.
      ri_html->add( 'abapGit installed in package&nbsp;' ).
      ri_html->add( lv_devclass ).
    ELSE.
      ri_html->add_a( iv_txt = 'install abapGit repo'
                      iv_act = zif_abapgit_definitions=>c_action-abapgit_install ).
      ri_html->add( ' - To keep abapGit up-to-date (or also to contribute) you need to' ).
      ri_html->add( 'install it as a repository.' ).
    ENDIF.

    ri_html->add( |<br>| ).

  ENDMETHOD.