  METHOD build_extra_from_header.

    DATA: lv_tdspras TYPE laiso.

    CALL FUNCTION 'CONVERSION_EXIT_ISOLA_OUTPUT'
      EXPORTING
        input  = is_header-tdspras
      IMPORTING
        output = lv_tdspras.

    rv_result = c_objectname_tdlines && '_' && lv_tdspras.

  ENDMETHOD.