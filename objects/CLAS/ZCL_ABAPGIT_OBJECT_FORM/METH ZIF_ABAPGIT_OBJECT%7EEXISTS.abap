  METHOD zif_abapgit_object~exists.

    CALL FUNCTION 'READ_FORM'
      EXPORTING
        form             = mv_form_name
        read_only_header = abap_true
      IMPORTING
        found            = rv_bool.

  ENDMETHOD.