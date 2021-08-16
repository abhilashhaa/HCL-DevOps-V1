  METHOD get_parts.

    DATA lr_collection TYPE REF TO ty_named_collection.
    lr_collection = get_collection( iv_collection ).
    IF lr_collection IS BOUND.
      rt_parts = lr_collection->pile.
    ENDIF.

  ENDMETHOD.