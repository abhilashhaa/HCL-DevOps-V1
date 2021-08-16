  METHOD get_ecatt_sp.

    " downport

    DATA: li_ixml               TYPE REF TO if_ixml,
          li_section            TYPE REF TO if_ixml_element,
          li_dom                TYPE REF TO if_ixml_document,
          li_root               TYPE REF TO if_ixml_node,
          lv_start_profile      TYPE etxml_line_str,
          lv_exception_occurred TYPE etonoff,
          lo_ecatt_sp           TYPE REF TO object.

    FIELD-SYMBOLS: <lg_ecatt_object> TYPE any.

    TRY.
        li_section = template_over_all->find_from_name_ns( 'START_PROFILE' ).

        IF NOT li_section IS INITIAL.
          li_ixml = cl_ixml=>create( ).
          li_dom  = li_ixml->create_document( ).
          li_root ?= li_section->clone( ).
          li_dom->append_child( new_child = li_root ).
          CALL FUNCTION 'SDIXML_DOM_TO_XML'
            EXPORTING
              document      = li_dom
            IMPORTING
              xml_as_string = lv_start_profile.

          ASSIGN ('ECATT_OBJECT') TO <lg_ecatt_object>.
          ASSERT sy-subrc = 0.

          lo_ecatt_sp = <lg_ecatt_object>.

          CALL METHOD lo_ecatt_sp->('SET_SP_ATTRIBUTES')
            EXPORTING
              i_sp_xml = lv_start_profile.

        ENDIF.
      CATCH cx_ecatt_apl.
        lv_exception_occurred = 'X'.
    ENDTRY.

    IF lv_exception_occurred = 'X'.
      raise_upload_exception( previous = exception_to_raise ).
    ENDIF.
  ENDMETHOD.