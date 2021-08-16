  METHOD goto_source_code.

    CONSTANTS:
      BEGIN OF lc_obj_type,
        class   TYPE trobjtype VALUE `CLAS`,
        program TYPE trobjtype VALUE `PROG`,
      END OF lc_obj_type.

    DATA:
      ls_item      TYPE zif_abapgit_definitions=>ty_item,
      lv_classname LIKE ls_item-obj_name.

    " you should remember that we distinct two cases
    " 1) we navigate to a global class
    " 2) we navigate to a program
    " the latter one is the default case

    lv_classname = extract_classname( is_callstack-mainprogram ).

    IF lv_classname IS NOT INITIAL.
      ls_item-obj_name = lv_classname.
      ls_item-obj_type = lc_obj_type-class.
    ELSE.
      ls_item-obj_name = is_callstack-mainprogram.
      ls_item-obj_type = lc_obj_type-program.
    ENDIF.

    zcl_abapgit_objects=>jump(
        is_item         = ls_item
        iv_line_number  = is_callstack-line
        iv_sub_obj_name = is_callstack-include
        iv_sub_obj_type = lc_obj_type-program ).

  ENDMETHOD.