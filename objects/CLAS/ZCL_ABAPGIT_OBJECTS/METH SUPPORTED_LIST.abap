  METHOD supported_list.

    DATA: lt_objects   TYPE STANDARD TABLE OF ko100,
          lv_supported TYPE abap_bool,
          ls_item      TYPE zif_abapgit_definitions=>ty_item.

    FIELD-SYMBOLS <ls_object> LIKE LINE OF lt_objects.


    CALL FUNCTION 'TR_OBJECT_TABLE'
      TABLES
        wt_object_text = lt_objects
      EXCEPTIONS
        OTHERS         = 1 ##FM_SUBRC_OK.

    LOOP AT lt_objects ASSIGNING <ls_object> WHERE pgmid = 'R3TR'.
      ls_item-obj_type = <ls_object>-object.

      lv_supported = is_supported(
        is_item        = ls_item
        iv_native_only = abap_true ).

      IF lv_supported = abap_true.
        INSERT <ls_object>-object INTO TABLE rt_types.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.