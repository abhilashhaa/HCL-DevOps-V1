  METHOD get_collection_size.

    DATA lr_collection TYPE REF TO ty_named_collection.
    lr_collection = get_collection( iv_collection ).
    IF lr_collection IS BOUND.
      rv_size = lines( lr_collection->pile ).
    ENDIF.

  ENDMETHOD.