  METHOD w3_api_create_new.

    DATA: lr_xml_api TYPE REF TO data.

    FIELD-SYMBOLS: <lg_xml_api> TYPE any.

    CREATE DATA lr_xml_api TYPE REF TO ('CL_W3_API_XML3').
    ASSIGN lr_xml_api->* TO <lg_xml_api>.
    ASSERT sy-subrc = 0.

    CALL METHOD ('CL_W3_API_XML3')=>create_new
      EXPORTING
        p_source_style_2006     = mv_source_style_2006
        p_xml_data              = is_attr
        p_generator_class       = mv_generator_class
        p_program_name          = is_attr-programm
      IMPORTING
        p_xml                   = <lg_xml_api>
      EXCEPTIONS
        undefined_name          = 1
        error_occured           = 2
        object_already_existing = 3
        not_authorized          = 4
        action_cancelled        = 5
        OTHERS                  = 6.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error from w3_api_xml3~create_new subrc={ sy-subrc }| ).
    ENDIF.

    ro_xml_api ?= <lg_xml_api>.

  ENDMETHOD.