  METHOD zif_abapgit_object~deserialize.

    DATA: lt_errors     TYPE TABLE OF inoer,
          ls_attributes TYPE tnro,
          ls_text       TYPE tnrot.


    io_xml->read( EXPORTING iv_name = 'ATTRIBUTES'
                  CHANGING cg_data = ls_attributes ).
    io_xml->read( EXPORTING iv_name = 'TEXT'
                  CHANGING cg_data = ls_text ).

    CALL FUNCTION 'NUMBER_RANGE_OBJECT_UPDATE'
      EXPORTING
        indicator                 = 'I'
        object_attributes         = ls_attributes
        object_text               = ls_text
      TABLES
        errors                    = lt_errors
      EXCEPTIONS
        object_already_exists     = 1
        object_attributes_missing = 2
        object_not_found          = 3
        object_text_missing       = 4
        wrong_indicator           = 5
        OTHERS                    = 6.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from NUMBER_RANGE_OBJECT_UPDATE' ).
    ENDIF.

    tadir_insert( iv_package ).
    corr_insert( iv_package ).

    CALL FUNCTION 'NUMBER_RANGE_OBJECT_CLOSE'
      EXPORTING
        object                 = ls_attributes-object
      EXCEPTIONS
        object_not_initialized = 1.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from NUMBER_RANGE_OBJECT_CLOSE' ).
    ENDIF.

  ENDMETHOD.