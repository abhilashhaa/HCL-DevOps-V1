  METHOD check_rfc_parameters.

* function module RS_FUNCTIONMODULE_INSERT does the same deep down, but the right error
* message is not returned to the user, this is a workaround to give a proper error
* message to the user

    DATA: ls_parameter TYPE rsfbpara,
          lt_fupa      TYPE rsfb_param,
          ls_fupa      LIKE LINE OF lt_fupa.


    IF is_function-remote_call = 'R'.
      cl_fb_parameter_conversion=>convert_parameter_old_to_fupa(
        EXPORTING
          functionname = is_function-funcname
          import       = is_function-import
          export       = is_function-export
          change       = is_function-changing
          tables       = is_function-tables
          except       = is_function-exception
        IMPORTING
          fupararef    = lt_fupa ).

      LOOP AT lt_fupa INTO ls_fupa WHERE paramtype = 'I' OR paramtype = 'E' OR paramtype = 'C' OR paramtype = 'T'.
        cl_fb_parameter_conversion=>convert_intern_to_extern(
          EXPORTING
            parameter_db  = ls_fupa
          IMPORTING
            parameter_vis = ls_parameter ).

        CALL FUNCTION 'RS_FB_CHECK_PARAMETER_REMOTE'
          EXPORTING
            parameter             = ls_parameter
            basxml_enabled        = is_function-remote_basxml
          EXCEPTIONS
            not_remote_compatible = 1
            OTHERS                = 2.
        IF sy-subrc <> 0.
          zcx_abapgit_exception=>raise_t100( ).
        ENDIF.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.