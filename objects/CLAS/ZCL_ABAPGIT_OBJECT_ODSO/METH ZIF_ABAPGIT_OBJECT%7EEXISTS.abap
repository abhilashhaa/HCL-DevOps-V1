  METHOD zif_abapgit_object~exists.

    DATA: lv_iobjnm TYPE c LENGTH 30.

    SELECT SINGLE odsobject
    FROM ('RSDODSO')
    INTO lv_iobjnm
    WHERE odsobject = ms_item-obj_name.

    rv_bool = boolc( sy-subrc = 0 ).

  ENDMETHOD.