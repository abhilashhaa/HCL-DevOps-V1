  METHOD handle_function.



    DATA: li_parameter TYPE REF TO if_ws_md_vif_param,
          li_soap      TYPE REF TO if_ws_md_soap_ext_func,
          li_fault     TYPE REF TO if_ws_md_vif_fault,
          li_function  TYPE REF TO if_ws_md_vif_func.

    FIELD-SYMBOLS: <ls_function>  LIKE LINE OF is_webi-pvepfunction,
                   <ls_soap>      LIKE LINE OF is_webi-pvepfuncsoapext,
                   <ls_fault>     LIKE LINE OF is_webi-pvepfault,
                   <ls_parameter> LIKE LINE OF is_webi-pvepparameter.


    LOOP AT is_webi-pvepfunction ASSIGNING <ls_function>.

      IF mi_vi->has_function( funcname = <ls_function>-function
                              version  = sews_c_vif_version-active ) = abap_true.
        CONTINUE.
      ENDIF.

      IF mi_vi->has_function( funcname = <ls_function>-function
                              version  = sews_c_vif_version-inactive ) = abap_true.

        li_function = mi_vi->get_function( funcname = <ls_function>-function
                                           version  = sews_c_vif_version-inactive ).

      ELSE.

        li_function = mi_vi->create_function( funcname    = <ls_function>-function
                                              mapped_name = <ls_function>-mappedname ).

      ENDIF.

      li_function->set_is_exposed( <ls_function>-is_exposed ).

      LOOP AT is_webi-pvepparameter ASSIGNING <ls_parameter>
          WHERE function = <ls_function>-function.

        li_parameter = me->handle_single_parameter( iv_name        = <ls_parameter>-vepparam
                                                    ii_function    = li_function
                                                    iv_parameter_type = <ls_parameter>-vepparamtype ).

        li_parameter->set_name_mapped_to( <ls_parameter>-mappedname ).
        li_parameter->set_is_exposed( <ls_parameter>-is_exposed ).
        li_parameter->set_is_optional( <ls_parameter>-is_optional ).
        li_parameter->set_default_value( <ls_parameter>-default_value ).
        li_parameter->set_initial( <ls_parameter>-is_initial ).
        li_parameter->set_type( <ls_parameter>-typename ).
      ENDLOOP.

      LOOP AT is_webi-pvepfuncsoapext ASSIGNING <ls_soap>
          WHERE function = <ls_function>-function.
        IF li_function->has_soap_extension_function( 'I' ) = abap_true.
          li_function->delete_soap_extension_function( ).
        ENDIF.
        li_soap = li_function->create_soap_extension_function( ).
        li_soap->set_soap_request_name( <ls_soap>-requestname ).
        li_soap->set_soap_response_name( <ls_soap>-responsename ).
        li_soap->set_namespace( <ls_soap>-namespace ).
      ENDLOOP.

      LOOP AT is_webi-pvepfault ASSIGNING <ls_fault>
          WHERE function = <ls_function>-function.
        li_fault = li_function->create_fault( <ls_fault>-fault ).
        li_fault->set_name_mapped_to( <ls_fault>-mappedname ).
        li_fault->set_detail( <ls_fault>-detail ).
      ENDLOOP.

    ENDLOOP.

  ENDMETHOD.