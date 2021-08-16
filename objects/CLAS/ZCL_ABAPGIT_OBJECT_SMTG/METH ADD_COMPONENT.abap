  METHOD add_component.

    DATA:
      ls_component LIKE LINE OF ct_components,
      lo_typedescr TYPE REF TO cl_abap_typedescr.

    cl_abap_structdescr=>describe_by_name(
      EXPORTING
        p_name         = iv_structure_name
      RECEIVING
        p_descr_ref    = lo_typedescr
      EXCEPTIONS
        type_not_found = 1
        OTHERS         = 2 ).

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |SMTG not supported| ).
    ENDIF.

    ls_component-name =  iv_fielname.
    ls_component-type ?= lo_typedescr.
    INSERT ls_component INTO TABLE ct_components.

  ENDMETHOD.