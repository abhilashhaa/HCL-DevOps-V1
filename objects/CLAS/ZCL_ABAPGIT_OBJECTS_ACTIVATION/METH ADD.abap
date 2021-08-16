  METHOD add.

* function group SEWORKINGAREA
* function module RS_INSERT_INTO_WORKING_AREA
* class CL_WB_ACTIVATION_WORK_AREA

    DATA: lt_objects  TYPE dwinactiv_tab,
          lv_obj_name TYPE dwinactiv-obj_name.

    FIELD-SYMBOLS: <ls_object> LIKE LINE OF lt_objects.


    lv_obj_name = iv_name.

    CASE iv_type.
      WHEN 'CLAS'.
        APPEND iv_name TO gt_classes.
      WHEN 'WDYN'.
* todo, move this to the object type include instead
        CALL FUNCTION 'RS_INACTIVE_OBJECTS_IN_OBJECT'
          EXPORTING
            obj_name         = lv_obj_name
            object           = iv_type
          TABLES
            inactive_objects = lt_objects
          EXCEPTIONS
            object_not_found = 1
            OTHERS           = 2.
        IF sy-subrc <> 0.
          zcx_abapgit_exception=>raise( 'Error from RS_INACTIVE_OBJECTS_IN_OBJECT' ).
        ENDIF.

        LOOP AT lt_objects ASSIGNING <ls_object>.
          <ls_object>-delet_flag = iv_delete.
        ENDLOOP.

        APPEND LINES OF lt_objects TO gt_objects.
      WHEN OTHERS.
        APPEND INITIAL LINE TO gt_objects ASSIGNING <ls_object>.
        <ls_object>-object     = iv_type.
        <ls_object>-obj_name   = lv_obj_name.
        <ls_object>-delet_flag = iv_delete.
    ENDCASE.

  ENDMETHOD.