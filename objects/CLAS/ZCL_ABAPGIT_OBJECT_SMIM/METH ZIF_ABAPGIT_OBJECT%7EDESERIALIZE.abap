  METHOD zif_abapgit_object~deserialize.

    DATA: lv_url      TYPE string,
          lv_folder   TYPE abap_bool,
          lv_content  TYPE xstring,
          lv_filename TYPE skwf_filnm,
          lv_io       TYPE sdok_docid,
          lv_class    TYPE smimloio-lo_class,
          ls_skwf_io  TYPE skwf_io,
          li_api      TYPE REF TO if_mr_api.


    li_api = cl_mime_repository_api=>if_mr_api~get_api( ).
    lv_io = ms_item-obj_name.

    io_xml->read( EXPORTING iv_name = 'URL'
                  CHANGING cg_data = lv_url ).
    io_xml->read( EXPORTING iv_name = 'FOLDER'
                  CHANGING cg_data = lv_folder ).
    io_xml->read( EXPORTING iv_name = 'CLASS'
                  CHANGING cg_data = lv_class ).

    ls_skwf_io-objid = lv_io.

    IF lv_folder = abap_true.
      li_api->create_folder(
        EXPORTING
          i_url              = lv_url
          i_language         = mv_language
          i_dev_package      = iv_package
          i_folder_loio      = ls_skwf_io
        EXCEPTIONS
          parameter_missing  = 1
          error_occured      = 2
          cancelled          = 3
          permission_failure = 4
          folder_exists      = 5
          OTHERS             = 6 ).
      IF sy-subrc <> 5 AND sy-subrc <> 0.
        zcx_abapgit_exception=>raise( 'error frrom SMIM create_folder' ).
      ENDIF.
    ELSE.
      lv_filename = get_filename( lv_url ).
      ls_skwf_io-class = lv_class.
      IF ls_skwf_io-class IS INITIAL.
        cl_wb_mime_repository=>determine_io_class(
          EXPORTING
            filename = lv_filename
          IMPORTING
            io_class = ls_skwf_io-class ).
        CONCATENATE ls_skwf_io-class '_L' INTO ls_skwf_io-class.
      ENDIF.

      lv_content = find_content( lv_url ).

      li_api->put(
        EXPORTING
          i_url                   = lv_url
          i_content               = lv_content
          i_dev_package           = iv_package
          i_new_loio              = ls_skwf_io
        EXCEPTIONS
          parameter_missing       = 1
          error_occured           = 2
          cancelled               = 3
          permission_failure      = 4
          data_inconsistency      = 5
          new_loio_already_exists = 6
          is_folder               = 7
          OTHERS                  = 8 ).
      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise( 'error from SMIM put' ).
      ENDIF.
    ENDIF.

  ENDMETHOD.