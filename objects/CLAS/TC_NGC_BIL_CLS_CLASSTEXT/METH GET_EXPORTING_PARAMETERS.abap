  METHOD get_exporting_parameters.

    APPEND VALUE #( classinternalid = '0000000001' ) TO et_failed.
    APPEND VALUE #( classinternalid = '0000000001' ) TO et_reported.
    APPEND VALUE #( classinternalid = '0000000001' ) TO et_mapped.

  ENDMETHOD.