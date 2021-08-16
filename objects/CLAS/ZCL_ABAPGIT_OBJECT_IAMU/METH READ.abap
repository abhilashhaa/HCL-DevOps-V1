  METHOD read.

    load_mime_api( ).

    mi_mime_api->get_attributes(
      IMPORTING
        p_attributes   = rs_internet_appl_comp_binary-attributes
      EXCEPTIONS
        object_invalid = 1
        mime_deleted   = 2
        error_occured  = 3
        OTHERS         = 4 ).

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error from if_w3_api_mime~get_attributes| ).
    ENDIF.

    CLEAR: rs_internet_appl_comp_binary-attributes-chname,
           rs_internet_appl_comp_binary-attributes-tdate,
           rs_internet_appl_comp_binary-attributes-ttime,
           rs_internet_appl_comp_binary-attributes-devclass.

    mi_mime_api->get_source(
      IMPORTING
        p_source       = rs_internet_appl_comp_binary-source
        p_datalength   = rs_internet_appl_comp_binary-length
      EXCEPTIONS
        object_invalid = 1
        mime_deleted   = 2
        error_occured  = 3
        OTHERS         = 4 ).

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error from if_w3_api_mime~get_source| ).
    ENDIF.

  ENDMETHOD.