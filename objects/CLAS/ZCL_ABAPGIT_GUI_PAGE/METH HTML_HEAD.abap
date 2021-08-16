  METHOD html_head.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( '<head>' ).

    ri_html->add( '<meta http-equiv="content-type" content="text/html; charset=utf-8">' ).
    ri_html->add( '<meta http-equiv="X-UA-Compatible" content="IE=11,10,9,8" />' ).

    ri_html->add( '<title>abapGit</title>' ).
    ri_html->add( '<link rel="stylesheet" type="text/css" href="css/common.css">' ).
    ri_html->add( '<link rel="stylesheet" type="text/css" href="css/ag-icons.css">' ).

    " Themes
    ri_html->add( '<link rel="stylesheet" type="text/css" href="css/theme-default.css">' ). " Theme basis
    CASE mo_settings->get_ui_theme( ).
      WHEN zcl_abapgit_settings=>c_ui_theme-dark.
        ri_html->add( '<link rel="stylesheet" type="text/css" href="css/theme-dark.css">' ).
      WHEN zcl_abapgit_settings=>c_ui_theme-belize.
        ri_html->add( '<link rel="stylesheet" type="text/css" href="css/theme-belize-blue.css">' ).
    ENDCASE.

    ri_html->add( '<script type="text/javascript" src="js/common.js"></script>' ).

    CASE mo_settings->get_icon_scaling( ). " Enforce icon scaling
      WHEN mo_settings->c_icon_scaling-large.
        ri_html->add( '<style>.icon { font-size: 200% }</style>' ).
      WHEN mo_settings->c_icon_scaling-small.
        ri_html->add( '<style>.icon.large { font-size: inherit }</style>' ).
    ENDCASE.

    ri_html->add( '</head>' ).

  ENDMETHOD.