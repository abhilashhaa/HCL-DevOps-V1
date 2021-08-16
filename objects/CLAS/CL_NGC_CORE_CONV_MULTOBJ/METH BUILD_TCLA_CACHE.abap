METHOD build_tcla_cache.
  IF mv_class_type EQ ''.
    SELECT * FROM tcla INTO TABLE mt_tcla WHERE klart <> '230' AND klart <> '102'.
  ELSE.
    SELECT * FROM tcla INTO TABLE mt_tcla WHERE klart = mv_class_type.
  ENDIF.
ENDMETHOD.