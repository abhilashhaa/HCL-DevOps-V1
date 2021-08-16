  METHOD classtext_id.

    SELECT * FROM tclx
      WHERE klart = @iv_classtype
      INTO TABLE @rt_classtext_id.

  ENDMETHOD.