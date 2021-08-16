  METHOD popup_package_overwrite.

    DATA: lt_columns  TYPE zif_abapgit_definitions=>ty_alv_column_tt,
          lt_selected LIKE ct_overwrite,
          li_popups   TYPE REF TO zif_abapgit_popups.

    FIELD-SYMBOLS: <ls_overwrite> LIKE LINE OF ct_overwrite,
                   <ls_column>    TYPE zif_abapgit_definitions=>ty_alv_column.

    IF lines( ct_overwrite ) = 0.
      RETURN.
    ENDIF.

    APPEND INITIAL LINE TO lt_columns ASSIGNING <ls_column>.
    <ls_column>-name = 'OBJ_TYPE'.
    APPEND INITIAL LINE TO lt_columns ASSIGNING <ls_column>.
    <ls_column>-name = 'OBJ_NAME'.
    APPEND INITIAL LINE TO lt_columns ASSIGNING <ls_column>.
    <ls_column>-name = 'DEVCLASS'.

    li_popups = zcl_abapgit_ui_factory=>get_popups( ).
    li_popups->popup_to_select_from_list(
      EXPORTING
        it_list               = ct_overwrite
        iv_header_text        = |The following objects have been created in other packages.|
                             && | Select the objects which should be overwritten.|
        iv_select_column_text = |Overwrite?|
        it_columns_to_display = lt_columns
      IMPORTING
        et_list               = lt_selected ).

    LOOP AT ct_overwrite ASSIGNING <ls_overwrite>.

      READ TABLE lt_selected WITH TABLE KEY object_type_and_name
                             COMPONENTS obj_type = <ls_overwrite>-obj_type
                                        obj_name = <ls_overwrite>-obj_name
                             TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        <ls_overwrite>-decision = 'Y'.
      ELSE.
        <ls_overwrite>-decision = 'N'.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.