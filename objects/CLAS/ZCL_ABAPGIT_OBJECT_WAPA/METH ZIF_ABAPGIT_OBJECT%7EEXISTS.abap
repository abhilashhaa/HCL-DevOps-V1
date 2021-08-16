  METHOD zif_abapgit_object~exists.

    DATA: lv_name TYPE o2applname.


    lv_name = ms_item-obj_name.

    cl_o2_api_application=>load(
      EXPORTING
        p_application_name  = lv_name
      EXCEPTIONS
        object_not_existing = 1
        permission_failure  = 2
        error_occured       = 3 ).
    rv_bool = boolc( sy-subrc = 0 ).

  ENDMETHOD.