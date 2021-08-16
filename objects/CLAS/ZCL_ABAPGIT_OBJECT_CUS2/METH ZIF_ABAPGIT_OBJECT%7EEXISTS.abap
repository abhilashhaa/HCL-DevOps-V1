  METHOD zif_abapgit_object~exists.

    CALL FUNCTION 'S_CUS_ATTRIBUTES_EXIST'
      EXPORTING
        img_attribute         = mv_img_attribute
      EXCEPTIONS
        attributes_exists_not = 1
        OTHERS                = 2.

    rv_bool = boolc( sy-subrc = 0 ).

  ENDMETHOD.