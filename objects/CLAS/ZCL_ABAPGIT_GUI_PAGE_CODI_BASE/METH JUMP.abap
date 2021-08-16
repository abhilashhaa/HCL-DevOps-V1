  METHOD jump.

    DATA: lo_test             TYPE REF TO cl_ci_test_root,
          ls_info             TYPE scir_rest,
          lo_result           TYPE REF TO cl_ci_result_root,
          lv_adt_jump_enabled TYPE abap_bool,
          lv_line_number      TYPE i,
          ls_item             TYPE zif_abapgit_definitions=>ty_item,
          ls_sub_item         TYPE zif_abapgit_definitions=>ty_item.

    FIELD-SYMBOLS: <ls_result> TYPE scir_alvlist.


    IF is_sub_item IS NOT INITIAL.
      READ TABLE mt_result WITH KEY objtype  = is_item-obj_type
                                    objname  = is_item-obj_name
                                    sobjtype = is_sub_item-obj_type
                                    sobjname = is_sub_item-obj_name
                                    line     = iv_line_number
                           ASSIGNING <ls_result>.
    ELSE.
      READ TABLE mt_result WITH KEY objtype = is_item-obj_type
                                    objname = is_item-obj_name
                                    line    = iv_line_number
                           ASSIGNING <ls_result>.
    ENDIF.
    ASSERT <ls_result> IS ASSIGNED.
    ls_item-obj_name = <ls_result>-objname.
    ls_item-obj_type = <ls_result>-objtype.

    ls_sub_item-obj_name = <ls_result>-sobjname.
    ls_sub_item-obj_type = <ls_result>-sobjtype.

    " see SCI_LCL_DYNP_530 / HANDLE_DOUBLE_CLICK

    lv_adt_jump_enabled = zcl_abapgit_persist_settings=>get_instance( )->read( )->get_adt_jump_enabled( ).

    TRY.
        IF lv_adt_jump_enabled = abap_true.

          lv_line_number = <ls_result>-line.

          zcl_abapgit_objects_super=>jump_adt( iv_obj_name     = ls_item-obj_name
                                               iv_obj_type     = ls_item-obj_type
                                               iv_sub_obj_name = ls_sub_item-obj_name
                                               iv_sub_obj_type = ls_sub_item-obj_type
                                               iv_line_number  = lv_line_number ).
          RETURN.

        ENDIF.
      CATCH zcx_abapgit_exception.
    ENDTRY.

    TRY.
        CALL METHOD ('CL_CI_TESTS')=>('GET_TEST_REF')
          EXPORTING
            p_test   = <ls_result>-test
          RECEIVING
            p_result = lo_test.
      CATCH cx_root.
        zcx_abapgit_exception=>raise( |Jump to object not supported in your NW release| ).
    ENDTRY.

    lo_result = lo_test->get_result_node( <ls_result>-kind ).

    MOVE-CORRESPONDING <ls_result> TO ls_info.

    lo_result->set_info( ls_info ).
    lo_result->if_ci_test~navigate( ).

  ENDMETHOD.