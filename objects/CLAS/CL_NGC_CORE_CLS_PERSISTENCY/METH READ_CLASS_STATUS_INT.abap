METHOD read_class_status_int.

  CHECK mt_class_status IS INITIAL.

  TEST-SEAM select_class_status.
    SELECT
      classtype,
      classstatus,
      classificationisallowed,
      \_classstatustext[ language = @sy-langu ]-classstatusname         ##ASSOC_TO_N_OK[_CLASSSTATUSTEXT]
      FROM i_clfnclassstatus INTO CORRESPONDING FIELDS OF TABLE @mt_class_status.
  END-TEST-SEAM.

ENDMETHOD.