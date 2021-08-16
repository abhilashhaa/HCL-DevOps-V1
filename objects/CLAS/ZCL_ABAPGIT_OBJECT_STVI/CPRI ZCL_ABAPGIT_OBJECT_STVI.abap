  PRIVATE SECTION.

    TYPES:
      BEGIN OF ty_transaction_variant,
        shdtvciu   TYPE shdtvciu,
        shdttciu   TYPE STANDARD TABLE OF shdttciu   WITH DEFAULT KEY,
        shdfvguicu TYPE STANDARD TABLE OF shdfvguicu WITH DEFAULT KEY,
        shdtvsvciu TYPE STANDARD TABLE OF shdtvsvciu WITH DEFAULT KEY,
      END OF ty_transaction_variant.