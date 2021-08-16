  METHOD zif_abapgit_xml_output~add.

    DATA: li_node TYPE REF TO if_ixml_node,
          li_doc  TYPE REF TO if_ixml_document,
          lt_stab TYPE abap_trans_srcbind_tab.

    FIELD-SYMBOLS: <ls_stab> LIKE LINE OF lt_stab.


    ASSERT NOT iv_name IS INITIAL.

    IF ig_data IS INITIAL.
      RETURN.
    ENDIF.

    APPEND INITIAL LINE TO lt_stab ASSIGNING <ls_stab>.
    <ls_stab>-name = iv_name.
    GET REFERENCE OF ig_data INTO <ls_stab>-value.

    li_doc = cl_ixml=>create( )->create_document( ).

    CALL TRANSFORMATION id
      OPTIONS initial_components = 'suppress'
      SOURCE (lt_stab)
      RESULT XML li_doc.

    li_node = mi_xml_doc->get_root( )->get_first_child( ).
    IF li_node IS BOUND.
      mi_xml_doc->get_root( )->get_first_child( )->get_first_child( )->append_child(
        li_doc->get_root( )->get_first_child( )->get_first_child( )->get_first_child( ) ).
    ELSE.
      mi_xml_doc->get_root( )->append_child( li_doc->get_root( )->get_first_child( ) ).
    ENDIF.

  ENDMETHOD.