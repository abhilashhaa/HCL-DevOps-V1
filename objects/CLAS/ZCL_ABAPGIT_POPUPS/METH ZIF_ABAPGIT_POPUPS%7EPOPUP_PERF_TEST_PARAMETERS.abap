  METHOD zif_abapgit_popups~popup_perf_test_parameters.
    DATA: lt_fields TYPE zcl_abapgit_free_sel_dialog=>ty_free_sel_field_tab.
    FIELD-SYMBOLS: <ls_field> TYPE zcl_abapgit_free_sel_dialog=>ty_free_sel_field.

    APPEND INITIAL LINE TO lt_fields ASSIGNING <ls_field>.
    <ls_field>-name = 'PACKAGE'.
    <ls_field>-only_parameter = abap_true.
    <ls_field>-ddic_tabname = 'TADIR'.
    <ls_field>-ddic_fieldname = 'DEVCLASS'.
    <ls_field>-param_obligatory = abap_true.
    <ls_field>-value = cv_package.

    APPEND INITIAL LINE TO lt_fields ASSIGNING <ls_field>.
    <ls_field>-name = 'PGMID'.
    <ls_field>-only_parameter = abap_true.
    <ls_field>-ddic_tabname = 'TADIR'.
    <ls_field>-ddic_fieldname = 'PGMID'.
    <ls_field>-value = 'R3TR'.

    APPEND INITIAL LINE TO lt_fields ASSIGNING <ls_field>.
    <ls_field>-name = 'OBJECT'.
    <ls_field>-ddic_tabname = 'TADIR'.
    <ls_field>-ddic_fieldname = 'OBJECT'.

    APPEND INITIAL LINE TO lt_fields ASSIGNING <ls_field>.
    <ls_field>-name = 'OBJ_NAME'.
    <ls_field>-ddic_tabname = 'TADIR'.
    <ls_field>-ddic_fieldname = 'OBJ_NAME'.

    APPEND INITIAL LINE TO lt_fields ASSIGNING <ls_field>.
    <ls_field>-name = 'INCLUDE_SUB_PACKAGES'.
    <ls_field>-only_parameter = abap_true.
    <ls_field>-ddic_tabname = 'TDEVC'.
    <ls_field>-ddic_fieldname = 'IS_ENHANCEABLE'.
    <ls_field>-text = 'Include subpackages'.
    <ls_field>-value = cv_include_sub_packages.

    APPEND INITIAL LINE TO lt_fields ASSIGNING <ls_field>.
    <ls_field>-name = 'MASTER_LANG_ONLY'.
    <ls_field>-only_parameter = abap_true.
    <ls_field>-ddic_tabname = 'TVDIR'.
    <ls_field>-ddic_fieldname = 'FLAG'.
    <ls_field>-text = 'Master lang only'.
    <ls_field>-value = cv_serialize_master_lang_only.

    popup_get_from_free_selections(
      EXPORTING
        iv_title       = 'Serialization Performance Test Parameters'
        iv_frame_text  = 'Parameters'
      CHANGING
        ct_fields      = lt_fields ).

    LOOP AT lt_fields ASSIGNING <ls_field>.
      CASE <ls_field>-name.
        WHEN 'PACKAGE'.
          cv_package = <ls_field>-value.
        WHEN 'OBJECT'.
          et_object_type_filter = <ls_field>-value_range.
        WHEN 'OBJ_NAME'.
          et_object_name_filter = <ls_field>-value_range.
        WHEN 'INCLUDE_SUB_PACKAGES'.
          cv_include_sub_packages = boolc( <ls_field>-value IS NOT INITIAL ).
        WHEN 'MASTER_LANG_ONLY'.
          cv_serialize_master_lang_only = boolc( <ls_field>-value IS NOT INITIAL ).
      ENDCASE.
    ENDLOOP.
  ENDMETHOD.