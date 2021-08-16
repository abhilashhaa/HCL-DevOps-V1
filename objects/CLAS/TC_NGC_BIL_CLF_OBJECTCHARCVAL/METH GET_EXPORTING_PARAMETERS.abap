  METHOD get_exporting_parameters.

    APPEND VALUE #( charcinternalid = '0000000001' ) TO et_failed.
    APPEND VALUE #( charcinternalid = '0000000001' ) TO et_reported.
    APPEND VALUE #( charcinternalid = '0000000001' ) TO et_mapped.
    APPEND VALUE #( charcinternalid = '0000000001' ) TO et_output.

  ENDMETHOD.