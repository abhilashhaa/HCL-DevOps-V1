  METHOD update_attributes.

    DATA: ls_sign       TYPE scompisign,
          lv_changeable TYPE abap_bool.


    lv_changeable = ii_interface->get_changeable( ).
    IF lv_changeable = abap_false.
* at creation the object is already in change mode
      ii_interface->set_changeable( abap_true ).
    ENDIF.

    ls_sign-descript       = abap_true.
    ls_sign-pinftype       = abap_true.
    ls_sign-restricted     = abap_true.
    ls_sign-default_if     = abap_true.
    ls_sign-def_sever      = abap_true.
    ls_sign-acl_flag       = abap_true.
    ls_sign-pifstablty     = abap_true.
    ls_sign-release_status = abap_true.

    ii_interface->set_all_attributes(
      is_package_interface_data = is_pinf-attributes
      is_data_sign              = ls_sign ).

    set_default_package( iv_package ).
* looks like setting "i_suppress_dialog = abap_true" will make
* it fail for local($) packages
    ii_interface->save( ).

    ii_interface->set_changeable( abap_false ).

  ENDMETHOD.