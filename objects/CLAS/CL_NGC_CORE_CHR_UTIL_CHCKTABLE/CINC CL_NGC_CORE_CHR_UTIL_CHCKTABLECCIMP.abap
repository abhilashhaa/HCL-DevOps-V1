CLASS lcl_handle_table_data DEFINITION.
  PUBLIC SECTION.
    INTERFACES: lif_handle_table_data.
ENDCLASS.

CLASS lcl_handle_table_data IMPLEMENTATION.

  METHOD lif_handle_table_data~check_table_exists.

    DATA:
      lt_names   TYPE TABLE OF x031l,
      lv_package TYPE string.

    lv_package = 'DUMMY'.
    DATA(lt_packages) = VALUE string_hashed_table( ( lv_package ) ).

    TRY.
        cl_abap_dyn_prg=>check_table_or_view_name_tab(
            val      = iv_table_name
            packages = lt_packages ).

      CATCH cx_abap_not_a_table.
        rv_exists = abap_false.
        RETURN.
      CATCH cx_abap_not_in_package.
        " Currently package is not interesting
    ENDTRY.

    rv_exists = abap_true.

  ENDMETHOD.

  METHOD lif_handle_table_data~get_table_details.

    CLEAR: et_field_list, et_field_info.

    CALL FUNCTION 'DDIF_NAMETAB_GET'
      EXPORTING
        tabname   = iv_table_name
        uclen     = '01'
      TABLES
        x031l_tab = et_field_list
        dfies_tab = et_field_info
      EXCEPTIONS
        not_found = 1
        OTHERS    = 2.

    IF sy-subrc <> 0.
      RAISE not_found.
    ENDIF.

  ENDMETHOD.

ENDCLASS.