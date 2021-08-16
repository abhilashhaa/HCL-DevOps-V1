  METHOD zif_abapgit_object~exists.

    DATA: ls_name  TYPE iacikeyt.


    ls_name = ms_item-obj_name.

    CALL METHOD ('CL_W3_API_XML3')=>s_check_exist
      EXPORTING
        p_xml_name = ls_name
      IMPORTING
        p_exists   = rv_bool.

  ENDMETHOD.