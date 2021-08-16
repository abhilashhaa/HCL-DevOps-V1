  METHOD get_collection.

    READ TABLE mt_part_collections REFERENCE INTO rr_collection WITH KEY name = iv_collection.
    IF sy-subrc <> 0 AND iv_create_if_missing = abap_true.
      APPEND INITIAL LINE TO mt_part_collections REFERENCE INTO rr_collection.
      rr_collection->name = iv_collection.
    ENDIF.

  ENDMETHOD.