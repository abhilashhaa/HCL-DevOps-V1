CLASS lcl_uom_converter DEFINITION.

  PUBLIC SECTION.
    INTERFACES: lif_uom_converter.

ENDCLASS.

CLASS lcl_uom_converter IMPLEMENTATION.

  METHOD lif_uom_converter~convert_value_uom.

    CLEAR: ev_value, et_message.


    CALL FUNCTION 'UNIT_CONVERSION_SIMPLE'
      EXPORTING
        input              = iv_value
        unit_in            = iv_uom_from
        unit_out           = iv_uom_to
      IMPORTING
        output             = ev_value
      EXCEPTIONS
        unit_in_not_found  = 1
        unit_out_not_found = 2
        OTHERS             = 4.

    IF sy-subrc <> 0.
      CASE sy-subrc.
        WHEN 1.
          APPEND VALUE #(
            key_date        = sy-datum
            charcinternalid = is_charc_header-charcinternalid
            msgty           = if_ngc_c=>gc_message_severity-error
            msgid           = 'NGC_CORE_CHR'
            msgno           = '007'
            msgv1           = iv_uom_from ) TO et_message.
        WHEN 2.
          APPEND VALUE #(
            key_date        = sy-datum
            charcinternalid = is_charc_header-charcinternalid
            msgty           = if_ngc_c=>gc_message_severity-error
            msgid           = 'NGC_CORE_CHR'
            msgno           = '007'
            msgv1           = iv_uom_to ) TO et_message.
        WHEN OTHERS.
          APPEND VALUE #(
            key_date        = sy-datum
            charcinternalid = is_charc_header-charcinternalid
            msgty           = if_ngc_c=>gc_message_severity-error
            msgid           = 'NGC_CORE_CHR'
            msgno           = '011'
            msgv1           = iv_uom_from ) TO et_message.
      ENDCASE.
    ENDIF.

  ENDMETHOD.

ENDCLASS.