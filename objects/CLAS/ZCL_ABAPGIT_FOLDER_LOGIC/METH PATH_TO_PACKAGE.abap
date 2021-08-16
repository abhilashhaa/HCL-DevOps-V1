  METHOD path_to_package.

    DATA: lv_length               TYPE i,
          lv_parent               TYPE devclass,
          lv_new                  TYPE string,
          lv_path                 TYPE string,
          lv_absolute_name        TYPE string,
          lv_top                  TYPE devclass,
          lt_unique_package_names TYPE HASHED TABLE OF devclass WITH UNIQUE KEY table_line.

    lv_top = iv_top.

    lv_length  = strlen( io_dot->get_starting_folder( ) ).
    IF lv_length > strlen( iv_path ).
* treat as not existing locally
      RETURN.
    ENDIF.
    lv_path    = iv_path+lv_length.
    lv_parent  = lv_top.
    rv_package = lv_top.

    INSERT iv_top INTO TABLE lt_unique_package_names.

    WHILE lv_path CA '/'.
      SPLIT lv_path AT '/' INTO lv_new lv_path.

      CASE io_dot->get_folder_logic( ).
        WHEN zif_abapgit_dot_abapgit=>c_folder_logic-full.
          lv_absolute_name = lv_new.
          TRANSLATE lv_absolute_name USING '#/'.
          IF iv_top(1) = '$'.
            CONCATENATE '$' lv_absolute_name INTO lv_absolute_name.
          ENDIF.
        WHEN zif_abapgit_dot_abapgit=>c_folder_logic-prefix.
          CONCATENATE rv_package '_' lv_new INTO lv_absolute_name.
        WHEN OTHERS.
          ASSERT 0 = 1.
      ENDCASE.

      TRANSLATE lv_absolute_name TO UPPER CASE.

      IF strlen( lv_absolute_name ) > 30.
        zcx_abapgit_exception=>raise( |Package { lv_absolute_name } exceeds ABAP 30-characters-name limit| ).
      ENDIF.

      rv_package = lv_absolute_name.
      READ TABLE lt_unique_package_names TRANSPORTING NO FIELDS
        WITH TABLE KEY table_line = rv_package.
      IF sy-subrc = 0.
        zcx_abapgit_exception=>raise( |Package { rv_package } has a subpackage with the same name| ).
      ELSE.
        INSERT rv_package INTO TABLE lt_unique_package_names.
      ENDIF.

      IF zcl_abapgit_factory=>get_sap_package( rv_package )->exists( ) = abap_false AND
          iv_create_if_not_exists = abap_true.

        zcl_abapgit_factory=>get_sap_package( lv_parent )->create_child( rv_package ).
      ENDIF.

      lv_parent = rv_package.
    ENDWHILE.

  ENDMETHOD.