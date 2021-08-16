*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_check DEFINITION FINAL.
  PUBLIC SECTION.
    INTERFACES: lif_check.
ENDCLASS.

CLASS lcl_check IMPLEMENTATION.

  METHOD lif_check~cucp_check_del_obj_class_conf.

    CALL FUNCTION 'CUCP_CHECK_DEL_OBJ_CLASS_CONF'
      EXPORTING
        cucp_var_class_type       = cucp_var_class_type
        cucp_root_object_key      = cucp_root_object_key
        cucp_root_object_table    = cucp_root_object_table
        cucp_datuv                = cucp_datuv
        cucp_aennr                = cucp_aennr
      EXCEPTIONS
        deletion_allowed          = 1
        deletion_allowed_with_ecm = 2
        OTHERS                    = 3.
    IF sy-subrc = 1.
      RAISE deletion_allowed.
    ELSEIF sy-subrc = 2.
      RAISE deletion_allowed_with_ecm.
    ENDIF.

  ENDMETHOD.

ENDCLASS.