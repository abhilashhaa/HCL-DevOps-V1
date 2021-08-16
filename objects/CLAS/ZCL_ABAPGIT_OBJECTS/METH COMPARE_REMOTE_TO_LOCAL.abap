  METHOD compare_remote_to_local.
* this method is used for comparing local with remote objects
* before pull, this is useful eg. when overwriting a TABL object.
* only the main XML file is used for comparison

    DATA: ls_remote_file      TYPE zif_abapgit_definitions=>ty_file,
          li_remote_version   TYPE REF TO zif_abapgit_xml_input,
          lv_count            TYPE i,
          ls_result           TYPE zif_abapgit_comparator=>ty_result,
          lv_answer           TYPE string,
          li_comparator       TYPE REF TO zif_abapgit_comparator,
          lv_gui_is_available TYPE abap_bool,
          ls_item             TYPE zif_abapgit_definitions=>ty_item.

    FIND ALL OCCURRENCES OF '.' IN is_result-filename MATCH COUNT lv_count.

    IF is_result-filename CS '.XML' AND lv_count = 2.
      IF ii_object->exists( ) = abap_false.
        RETURN.
      ENDIF.

      READ TABLE it_remote WITH KEY filename = is_result-filename INTO ls_remote_file.
      IF sy-subrc <> 0. "if file does not exist in remote, we don't need to validate
        RETURN.
      ENDIF.

      li_comparator = ii_object->get_comparator( ).
      IF NOT li_comparator IS BOUND.
        RETURN.
      ENDIF.

      CREATE OBJECT li_remote_version
        TYPE zcl_abapgit_xml_input
        EXPORTING
          iv_xml      = zcl_abapgit_convert=>xstring_to_string_utf8( ls_remote_file-data )
          iv_filename = ls_remote_file-filename.

      ls_result = li_comparator->compare( ii_remote = li_remote_version
                                          ii_log = ii_log ).
      IF ls_result-text IS INITIAL.
        RETURN.
      ENDIF.

      "log comparison result
      ls_item-obj_type = is_result-obj_type.
      ls_item-obj_name = is_result-obj_name.
      ii_log->add_warning( iv_msg = ls_result-text
                           is_item = ls_item ).

      "continue or abort?
      lv_gui_is_available = zcl_abapgit_ui_factory=>get_gui_functions( )->gui_is_available( ).
      IF lv_gui_is_available = abap_true.
        CALL FUNCTION 'POPUP_TO_CONFIRM'
          EXPORTING
            titlebar              = 'Warning'
            text_question         = ls_result-text
            text_button_1         = 'Abort'
            icon_button_1         = 'ICON_CANCEL'
            text_button_2         = 'Pull anyway'
            icon_button_2         = 'ICON_OKAY'
            default_button        = '2'
            display_cancel_button = abap_false
          IMPORTING
            answer                = lv_answer
          EXCEPTIONS
            text_not_found        = 1
            OTHERS                = 2.
        IF sy-subrc <> 0 OR lv_answer = 1.
          zcx_abapgit_exception=>raise( |Deserialization for object { is_result-obj_name } | &
                                        |(type { is_result-obj_type }) aborted by user| ).
        ENDIF.
      ELSE.
        zcx_abapgit_exception=>raise( |Deserialization for object { is_result-obj_name } | &
                                      |(type { is_result-obj_type }) aborted, user descision required| ).
      ENDIF.
    ENDIF.

  ENDMETHOD.