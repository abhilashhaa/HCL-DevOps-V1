  METHOD zif_abapgit_object~delete.

    CALL FUNCTION 'DELETE_FORM'
      EXPORTING
        form     = mv_form_name
        language = '*'.

    order_check_and_insert( ).

  ENDMETHOD.