  METHOD precheck_class_type.
    "Check if class type for testing is not used
    DATA ls_tcla TYPE tcla.
    SELECT SINGLE * FROM tcla WHERE klart = @iv_klart_test INTO @ls_tcla.
    IF ls_tcla IS NOT INITIAL.
      DATA msg TYPE string.
      msg = 'Class type ' + iv_klart_test + ' for testing already in use. Abort testing'. "#EC NOTEXT
      cl_abap_unit_assert=>abort( msg ).
    ENDIF.
  ENDMETHOD.