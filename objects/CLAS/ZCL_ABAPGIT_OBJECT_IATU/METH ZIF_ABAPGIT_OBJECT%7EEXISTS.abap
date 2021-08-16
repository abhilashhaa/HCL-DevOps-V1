  METHOD zif_abapgit_object~exists.

    DATA: ls_name TYPE iacikeyt.


    ls_name = ms_item-obj_name.

    cl_w3_api_template=>s_check_exist( EXPORTING p_template_name = ls_name
                                       IMPORTING p_exists        = rv_bool ).

  ENDMETHOD.