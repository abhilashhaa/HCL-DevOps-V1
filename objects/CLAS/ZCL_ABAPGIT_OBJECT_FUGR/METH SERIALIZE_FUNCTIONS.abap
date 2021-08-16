  METHOD serialize_functions.

    DATA:
      lt_source     TYPE TABLE OF rssource,
      lt_functab    TYPE ty_rs38l_incl_tt,
      lt_new_source TYPE rsfb_source,
      ls_function   LIKE LINE OF rt_functions.

    FIELD-SYMBOLS: <ls_func>          LIKE LINE OF lt_functab,
                   <ls_documentation> TYPE LINE OF ty_function-documentation.

    lt_functab = functions( ).

    LOOP AT lt_functab ASSIGNING <ls_func>.
* fm RPY_FUNCTIONMODULE_READ does not support source code
* lines longer than 72 characters
      CLEAR ls_function.
      MOVE-CORRESPONDING <ls_func> TO ls_function.

      CLEAR lt_new_source.
      CLEAR lt_source.

      CALL FUNCTION 'RPY_FUNCTIONMODULE_READ_NEW'
        EXPORTING
          functionname            = <ls_func>-funcname
        IMPORTING
          global_flag             = ls_function-global_flag
          remote_call             = ls_function-remote_call
          update_task             = ls_function-update_task
          short_text              = ls_function-short_text
          remote_basxml_supported = ls_function-remote_basxml
        TABLES
          import_parameter        = ls_function-import
          changing_parameter      = ls_function-changing
          export_parameter        = ls_function-export
          tables_parameter        = ls_function-tables
          exception_list          = ls_function-exception
          documentation           = ls_function-documentation
          source                  = lt_source
        CHANGING
          new_source              = lt_new_source
        EXCEPTIONS
          error_message           = 1
          function_not_found      = 2
          invalid_name            = 3
          OTHERS                  = 4.
      IF sy-subrc = 2.
        CONTINUE.
      ELSEIF sy-subrc <> 0.
        zcx_abapgit_exception=>raise( 'Error from RPY_FUNCTIONMODULE_READ_NEW' ).
      ENDIF.

      LOOP AT ls_function-documentation ASSIGNING <ls_documentation>.
        CLEAR <ls_documentation>-index.
      ENDLOOP.

      SELECT SINGLE exten3 INTO ls_function-exception_classes FROM enlfdir
        WHERE funcname = <ls_func>-funcname.              "#EC CI_SUBRC

      APPEND ls_function TO rt_functions.

      IF NOT lt_new_source IS INITIAL.
        mo_files->add_abap( iv_extra = <ls_func>-funcname
                            it_abap  = lt_new_source ).
      ELSE.
        mo_files->add_abap( iv_extra = <ls_func>-funcname
                            it_abap  = lt_source ).
      ENDIF.

    ENDLOOP.

  ENDMETHOD.