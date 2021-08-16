  METHOD add_part.

    DATA lr_collection TYPE REF TO ty_named_collection.
    lr_collection = get_collection(
      iv_collection = iv_collection
      iv_create_if_missing = abap_true ).
    APPEND ii_part TO lr_collection->pile.

  ENDMETHOD.