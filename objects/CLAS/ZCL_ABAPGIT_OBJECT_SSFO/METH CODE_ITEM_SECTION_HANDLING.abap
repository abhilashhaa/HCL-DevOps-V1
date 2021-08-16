  METHOD code_item_section_handling.
    CONSTANTS: lc_node_item TYPE string VALUE 'item'.
    CONSTANTS: lc_node_text TYPE string VALUE '#text'.

    IF iv_name IN get_range_node_codes( ).
      cv_within_code_section = abap_true.
    ENDIF.

    IF cv_within_code_section = abap_true.
      IF iv_name = lc_node_item.
        TRY.
            ei_code_item_element ?= ii_node.
            RETURN.
          CATCH cx_sy_move_cast_error ##no_handler.
        ENDTRY.

      ELSEIF iv_name NOT IN get_range_node_codes( ) AND
             iv_name <> lc_node_text.
        cv_within_code_section = abap_false.
      ENDIF.
    ENDIF.

    RAISE EXCEPTION TYPE zcx_abapgit_exception.

  ENDMETHOD.