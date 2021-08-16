  METHOD normalize_program_name.

    rv_normalized_program_name = substring_before(
                                     val   = iv_program_name
                                     regex = `(=+CP)?$` ).

  ENDMETHOD.