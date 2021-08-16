  METHOD zif_abapgit_oo_object_fnc~exists.
    CALL FUNCTION 'SEO_CLASS_EXISTENCE_CHECK'
      EXPORTING
        clskey        = is_object_name
      EXCEPTIONS
        not_specified = 1
        not_existing  = 2
        is_interface  = 3
        no_text       = 4
        inconsistent  = 5
        OTHERS        = 6.
    rv_exists = boolc( sy-subrc <> 2 ).
  ENDMETHOD.