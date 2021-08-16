*"* use this source file for any type of declarations (class
*"* definitions, interfaces or type declarations) you need for
*"* components in the private section

INTERFACE lif_check.

  METHODS cucp_check_del_obj_class_conf
    IMPORTING
      cucp_var_class_type    TYPE klassenart
      cucp_root_object_key   TYPE rcuobn
      cucp_root_object_table TYPE rtabelle
      cucp_datuv             TYPE datuv
      cucp_aennr             TYPE aennr OPTIONAL
    EXCEPTIONS
      deletion_allowed
      deletion_allowed_with_ecm.

ENDINTERFACE.