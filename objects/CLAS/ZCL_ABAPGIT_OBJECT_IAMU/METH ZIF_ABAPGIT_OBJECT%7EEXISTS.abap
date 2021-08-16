  METHOD zif_abapgit_object~exists.

    DATA: ls_mime_name TYPE iacikeym.

    ls_mime_name = ms_item-obj_name.

    cl_w3_api_mime=>s_check_exist(
      EXPORTING
        p_mime_name = ls_mime_name
      IMPORTING
        p_exists    = rv_bool ).

  ENDMETHOD.