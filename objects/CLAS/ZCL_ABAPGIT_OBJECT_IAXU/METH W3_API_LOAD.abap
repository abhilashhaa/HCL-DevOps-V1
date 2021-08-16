  METHOD w3_api_load.

    DATA: lr_xml_api TYPE REF TO data.

    FIELD-SYMBOLS: <lg_xml_api> TYPE any.

    CREATE DATA lr_xml_api TYPE REF TO ('CL_W3_API_XML3').
    ASSIGN lr_xml_api->* TO <lg_xml_api>.
    ASSERT sy-subrc = 0.

    CALL METHOD ('CL_W3_API_XML3')=>load
      EXPORTING
        p_xml_name          = is_name
      IMPORTING
        p_attributes        = es_attr
        p_xml               = <lg_xml_api>
      EXCEPTIONS
        object_not_existing = 1
        permission_failure  = 2
        data_corrupt        = 3
        error_occured       = 4
        OTHERS              = 5.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error from w3_api_xml3~load subrc={ sy-subrc }| ).
    ENDIF.

    eo_xml_api ?= <lg_xml_api>.

  ENDMETHOD.