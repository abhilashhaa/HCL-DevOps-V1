  METHOD zif_abapgit_object~deserialize.

    DATA: ls_vseointerf TYPE vseointerf.

    io_xml->read( EXPORTING iv_name = 'VSEOINTERF'
                  CHANGING cg_data = ls_vseointerf ).

    IF ls_vseointerf-clsproxy = abap_true.
      " Proxy interfaces are managed via SPRX
      deserialize_proxy( ).
      RETURN.
    ENDIF.

    deserialize_abap( ii_xml     = io_xml
                      iv_package = iv_package ).

    deserialize_docu( io_xml ).
  ENDMETHOD.