  METHOD get_field.

    DATA: lv_value TYPE string.

    FIELD-SYMBOLS: <ls_field> LIKE LINE OF it_field,
                   <lg_dest>  TYPE any.


    READ TABLE it_field ASSIGNING <ls_field> WITH KEY name = iv_name.
    IF sy-subrc IS NOT INITIAL.
      RETURN.
    ENDIF.

    lv_value = <ls_field>-value.

    IF iv_decode = abap_true.
      lv_value = cl_http_utility=>unescape_url( escaped = lv_value ).
    ENDIF.

    CASE cl_abap_typedescr=>describe_by_data( cg_field )->kind.
      WHEN cl_abap_typedescr=>kind_elem.
        cg_field = lv_value.
      WHEN cl_abap_typedescr=>kind_struct.
        ASSIGN COMPONENT iv_name OF STRUCTURE cg_field TO <lg_dest>.
        ASSERT <lg_dest> IS ASSIGNED.
        <lg_dest> = lv_value.
      WHEN OTHERS.
        ASSERT 0 = 1.
    ENDCASE.

  ENDMETHOD.