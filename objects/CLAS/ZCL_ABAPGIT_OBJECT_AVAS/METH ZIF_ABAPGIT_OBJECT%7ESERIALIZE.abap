  METHOD zif_abapgit_object~serialize.

    DATA: lo_avas TYPE REF TO cl_cls_attr_value_assignment,
          ls_avas TYPE ty_avas.

    FIELD-SYMBOLS: <ls_value> LIKE LINE OF ls_avas-values,
                   <ls_link>  LIKE LINE OF ls_avas-links.


    lo_avas = instantiate( ).

    ls_avas-header-guid      = lo_avas->if_cls_attr_value_assignment~get_guid( ).
    ls_avas-header-attribute = lo_avas->if_cls_attr_value_assignment~get_attribute( ).
    ls_avas-header-object    = lo_avas->if_cls_attr_value_assignment~get_object( ).

    lo_avas->if_cls_attr_value_assignment~get_values( IMPORTING ex_values = ls_avas-values ).

    lo_avas->if_cls_attr_value_assignment~get_links( IMPORTING ex_links = ls_avas-links ).

    LOOP AT ls_avas-values ASSIGNING <ls_value>.
      CLEAR: <ls_value>-set_by, <ls_value>-changed_on.
    ENDLOOP.

    LOOP AT ls_avas-links ASSIGNING <ls_link>.
      CLEAR: <ls_link>-set_by, <ls_link>-changed_on.
    ENDLOOP.

    io_xml->add(
      iv_name = 'AVAS'
      ig_data = ls_avas ).

  ENDMETHOD.