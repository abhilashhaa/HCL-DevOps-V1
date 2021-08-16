  METHOD delete_idoc_segment.

    DATA lv_segment_type        TYPE edilsegtyp.
    DATA lv_result              LIKE sy-subrc.

    IF is_idoc_segment( ) = abap_false.
      rv_deleted = abap_false.
      RETURN. "previous XML version or no IDoc segment
    ENDIF.

    rv_deleted = abap_true.
    lv_segment_type = ms_item-obj_name.

    CALL FUNCTION 'SEGMENT_DELETE'
      EXPORTING
        segmenttyp = lv_segment_type
      IMPORTING
        result     = lv_result
      EXCEPTIONS
        OTHERS     = 1.
    IF sy-subrc <> 0 OR lv_result <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.
  ENDMETHOD.