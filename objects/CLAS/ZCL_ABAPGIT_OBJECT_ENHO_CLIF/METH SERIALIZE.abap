  METHOD serialize.

    DATA: lt_tab_attributes TYPE enhclasstabattrib,
          lt_tab_types      TYPE enhtype_tab,
          lt_tab_methods    TYPE enhnewmeth_tab,
          lt_tab_eventdata  TYPE enhevent_tab.

    FIELD-SYMBOLS: <ls_attr>        LIKE LINE OF lt_tab_attributes,
                   <ls_type>        LIKE LINE OF lt_tab_types,
                   <ls_meth>        LIKE LINE OF lt_tab_methods,
                   <ls_param>       LIKE LINE OF <ls_meth>-meth_param,
                   <ls_event>       LIKE LINE OF lt_tab_eventdata,
                   <ls_event_param> LIKE LINE OF <ls_event>-event_param.


    io_clif->get_enhattributes( IMPORTING tab_attributes = lt_tab_attributes ).

    io_clif->get_enhatypes( IMPORTING tab_types = lt_tab_types ).

    io_clif->get_enh_new_methodes( IMPORTING tab_methodes = lt_tab_methods ).

    io_clif->get_enhevents( IMPORTING tab_eventdata = lt_tab_eventdata ).

    LOOP AT lt_tab_attributes ASSIGNING <ls_attr>.
      CLEAR: <ls_attr>-author,
             <ls_attr>-createdon,
             <ls_attr>-changedby,
             <ls_attr>-changedon,
             <ls_attr>-descript_id.
    ENDLOOP.

    LOOP AT lt_tab_types ASSIGNING <ls_type>.
      CLEAR: <ls_type>-author,
             <ls_type>-createdon,
             <ls_type>-changedby,
             <ls_type>-changedon,
             <ls_type>-descript_id.
    ENDLOOP.

    LOOP AT lt_tab_methods ASSIGNING <ls_meth>.
      CLEAR: <ls_meth>-meth_header-author,
             <ls_meth>-meth_header-createdon,
             <ls_meth>-meth_header-changedby,
             <ls_meth>-meth_header-changedon,
             <ls_meth>-meth_header-descript_id.
      LOOP AT <ls_meth>-meth_param ASSIGNING <ls_param>.
        CLEAR: <ls_param>-author,
               <ls_param>-createdon,
               <ls_param>-changedby,
               <ls_param>-changedon,
               <ls_param>-descript_id.
      ENDLOOP.
    ENDLOOP.

    LOOP AT lt_tab_eventdata ASSIGNING <ls_event>.
      CLEAR: <ls_event>-event_header-author,
             <ls_event>-event_header-createdon,
             <ls_event>-event_header-changedby,
             <ls_event>-event_header-changedon,
             <ls_event>-event_header-descript_id.
      LOOP AT <ls_event>-event_param ASSIGNING <ls_event_param>.
        CLEAR: <ls_event_param>-author,
               <ls_event_param>-createdon,
               <ls_event_param>-changedby,
               <ls_event_param>-changedon,
               <ls_event_param>-descript_id.
      ENDLOOP.
    ENDLOOP.

    io_xml->add( iv_name = 'TAB_ATTRIBUTES'
                 ig_data = lt_tab_attributes ).
    io_xml->add( iv_name = 'TAB_TYPES'
                 ig_data = lt_tab_types ).
    io_xml->add( iv_name = 'TAB_METHODS'
                 ig_data = lt_tab_methods ).
    io_xml->add( iv_name = 'TAB_EVENTDATA'
                 ig_data = lt_tab_eventdata ).

  ENDMETHOD.