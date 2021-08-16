METHOD if_ngc_bil_clf_util~deserialize_data.

  DATA:
    lr_data     TYPE REF TO data.

  FIELD-SYMBOLS:
    <ls_data>   TYPE any.

  CLEAR: es_data, er_data.

  TRY.
    CREATE DATA lr_data TYPE (iv_table).
    ASSIGN lr_data->* TO <ls_data>.

    CALL TRANSFORMATION id
      SOURCE XML iv_data_binary
      RESULT ref = <ls_data>.

  CATCH cx_xslt_exception INTO DATA(lx_xslt).
    " Temporarily we still support serialized "ref to data".
    CALL TRANSFORMATION id
      SOURCE XML iv_data_binary
      RESULT ref = lr_data.

    ASSIGN lr_data->* TO <ls_data>.
  ENDTRY.

  es_data = <ls_data>.
  er_data = lr_data.

ENDMETHOD.