  METHOD register_validation_class_type.

    READ TABLE mt_validation_class_types TRANSPORTING NO FIELDS WITH TABLE KEY table_line = iv_classtype.
    IF sy-subrc <> 0.
      INSERT iv_classtype INTO TABLE mt_validation_class_types.
    ENDIF.

  ENDMETHOD.