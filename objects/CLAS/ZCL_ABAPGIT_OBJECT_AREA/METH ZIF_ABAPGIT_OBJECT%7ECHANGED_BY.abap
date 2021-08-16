  METHOD zif_abapgit_object~changed_by.

    DATA: lv_user TYPE string.

    SELECT SINGLE tstpnm FROM ('RSDAREA') INTO lv_user.

    rv_user = lv_user.

  ENDMETHOD.