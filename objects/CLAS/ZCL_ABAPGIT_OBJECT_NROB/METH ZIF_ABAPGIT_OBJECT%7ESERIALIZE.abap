  METHOD zif_abapgit_object~serialize.

    DATA: lv_object     TYPE tnro-object,
          ls_attributes TYPE tnro,
          ls_text       TYPE tnrot.


    lv_object = ms_item-obj_name.

    CALL FUNCTION 'NUMBER_RANGE_OBJECT_READ'
      EXPORTING
        language          = mv_language
        object            = lv_object
      IMPORTING
        object_attributes = ls_attributes
        object_text       = ls_text
      EXCEPTIONS
        object_not_found  = 1
        OTHERS            = 2.
    IF sy-subrc = 1.
      RETURN.
    ELSEIF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from NUMBER_RANGE_OBJECT_READ' ).
    ENDIF.

    io_xml->add( iv_name = 'ATTRIBUTES'
                 ig_data = ls_attributes ).
    io_xml->add( iv_name = 'TEXT'
                 ig_data = ls_text ).

  ENDMETHOD.