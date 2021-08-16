  METHOD get_objchk_name.

    DATA:
      ls_object_check_name LIKE LINE OF mt_object_check_names.

    " Look in the cache first.
    DATA(lr_object_check_name) = REF #( mt_object_check_names[ obtab = iv_obtab ] OPTIONAL ).

    IF lr_object_check_name IS NOT INITIAL.

      " So this name is already cached.
      rv_objchk_name = lr_object_check_name->fkbname.
    ELSE.

      " So this name is not yet cached, let's see if it exists.
      ls_object_check_name-obtab = iv_obtab.

      mo_conv_util->get_function_for_object(
        EXPORTING
          iv_object_type   = ls_object_check_name-obtab
        IMPORTING
          ev_function_name = ls_object_check_name-fkbname
          ev_sy_subrc      = DATA(lv_sy_subrc) ).

      IF lv_sy_subrc IS NOT INITIAL.

        " So this name does not exist.
        ls_object_check_name-fkbname = gc_no_name.
      ENDIF.

      " Store the result to the cache
      INSERT ls_object_check_name INTO TABLE mt_object_check_names.

      rv_objchk_name = ls_object_check_name-fkbname.
    ENDIF.

  ENDMETHOD.