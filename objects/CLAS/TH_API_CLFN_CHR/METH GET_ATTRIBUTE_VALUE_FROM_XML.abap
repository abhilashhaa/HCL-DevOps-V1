  METHOD get_attribute_value_from_xml.
    TRY.
        DATA(lv_xml) = cl_abap_codepage=>convert_to( iv_xml ).
        DATA(lo_reader) = CAST if_sxml_reader( cl_sxml_string_reader=>create( lv_xml ) ).

        DO.
          lo_reader->next_node( ).
          IF to_upper( lo_reader->name ) = to_upper( iv_attribute_name ).
            EXIT.
          ENDIF.
        ENDDO.

        IF lo_reader->node_type = if_sxml_node=>co_nt_element_open.
          lo_reader->next_node( ).
        ENDIF.
        IF lo_reader->node_type = if_sxml_node=>co_nt_value.
          rv_value = lo_reader->value.
        ELSEIF lo_reader->node_type = if_sxml_node=>co_nt_element_close.
          CLEAR rv_value.
        ENDIF.

      CATCH cx_sxml_parse_error INTO DATA(lx_sxml_parse_error).
        IF lx_sxml_parse_error->error_text <> 'end of stream'.
          RAISE EXCEPTION TYPE cx_sxml_parse_error.
        ENDIF.
    ENDTRY.
  ENDMETHOD.