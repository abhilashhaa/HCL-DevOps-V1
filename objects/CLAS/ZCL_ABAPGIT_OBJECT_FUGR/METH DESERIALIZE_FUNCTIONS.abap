  METHOD deserialize_functions.

    DATA: lv_include   TYPE rs38l-include,
          lv_area      TYPE rs38l-area,
          lv_group     TYPE rs38l-area,
          lv_namespace TYPE rs38l-namespace,
          lt_source    TYPE TABLE OF abaptxt255,
          lv_msg       TYPE string,
          lx_error     TYPE REF TO zcx_abapgit_exception,
          lv_corrnum   TYPE e070use-ordernum.

    FIELD-SYMBOLS: <ls_func> LIKE LINE OF it_functions.


    lv_corrnum = zcl_abapgit_default_transport=>get_instance( )->get( )-ordernum.

    LOOP AT it_functions ASSIGNING <ls_func>.

      lt_source = mo_files->read_abap( iv_extra = <ls_func>-funcname ).

      lv_area = ms_item-obj_name.

      CALL FUNCTION 'FUNCTION_INCLUDE_SPLIT'
        EXPORTING
          complete_area = lv_area
        IMPORTING
          namespace     = lv_namespace
          group         = lv_group
        EXCEPTIONS
          OTHERS        = 12.

      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE 'S' NUMBER sy-msgno WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4 INTO lv_msg.
        ii_log->add_error( iv_msg  = |Function module { <ls_func>-funcname }: { lv_msg }|
                           is_item = ms_item ).
        CONTINUE. "with next function module
      ENDIF.

      CALL FUNCTION 'FUNCTION_EXISTS'
        EXPORTING
          funcname           = <ls_func>-funcname
        IMPORTING
          include            = lv_include
        EXCEPTIONS
          function_not_exist = 1.
      IF sy-subrc = 0.
* delete the function module to make sure the parameters are updated
* havent found a nice way to update the paramters
        CALL FUNCTION 'FUNCTION_DELETE'
          EXPORTING
            funcname                 = <ls_func>-funcname
            suppress_success_message = abap_true
          EXCEPTIONS
            error_message            = 1
            OTHERS                   = 2.
        IF sy-subrc <> 0.
          MESSAGE ID sy-msgid TYPE 'S' NUMBER sy-msgno WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4 INTO lv_msg.
          ii_log->add_error( iv_msg = |Function module { <ls_func>-funcname }: { lv_msg }|
                             is_item = ms_item ).
          CONTINUE. "with next function module
        ENDIF.
      ENDIF.

      TRY.
          check_rfc_parameters( <ls_func> ).
        CATCH zcx_abapgit_exception INTO lx_error.
          ii_log->add_error(
            iv_msg  = |Function module { <ls_func>-funcname }: { lx_error->get_text( ) }|
            is_item = ms_item ).
          CONTINUE. "with next function module
      ENDTRY.

      CALL FUNCTION 'RS_FUNCTIONMODULE_INSERT'
        EXPORTING
          funcname                = <ls_func>-funcname
          function_pool           = lv_group
          interface_global        = <ls_func>-global_flag
          remote_call             = <ls_func>-remote_call
          short_text              = <ls_func>-short_text
          update_task             = <ls_func>-update_task
          exception_class         = <ls_func>-exception_classes
          namespace               = lv_namespace
          remote_basxml_supported = <ls_func>-remote_basxml
          corrnum                 = lv_corrnum
        IMPORTING
          function_include        = lv_include
        TABLES
          import_parameter        = <ls_func>-import
          export_parameter        = <ls_func>-export
          tables_parameter        = <ls_func>-tables
          changing_parameter      = <ls_func>-changing
          exception_list          = <ls_func>-exception
          parameter_docu          = <ls_func>-documentation
        EXCEPTIONS
          double_task             = 1
          error_message           = 2
          function_already_exists = 3
          invalid_function_pool   = 4
          invalid_name            = 5
          too_many_functions      = 6
          no_modify_permission    = 7
          no_show_permission      = 8
          enqueue_system_failure  = 9
          canceled_in_corr        = 10
          OTHERS                  = 11.
      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE 'S' NUMBER sy-msgno WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4 INTO lv_msg.
        ii_log->add_error( iv_msg = |Function module { <ls_func>-funcname }: { lv_msg }|
                           is_item = ms_item ).
        CONTINUE.  "with next function module
      ENDIF.

      INSERT REPORT lv_include FROM lt_source.
      ii_log->add_success( iv_msg = |Function module { <ls_func>-funcname } imported|
                           is_item = ms_item ).
    ENDLOOP.

  ENDMETHOD.