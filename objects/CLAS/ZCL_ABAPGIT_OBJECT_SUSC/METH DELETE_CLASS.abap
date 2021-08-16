  METHOD delete_class.

    DELETE FROM tobc  WHERE oclss = iv_auth_object_class.
    DELETE FROM tobct WHERE oclss = iv_auth_object_class.

  ENDMETHOD.