  METHOD zif_abapgit_object~exists.

    DATA: lv_iobjnm TYPE c LENGTH 30.

    SELECT SINGLE iobjnm
      FROM ('RSDIOBJ')
      INTO lv_iobjnm
      WHERE iobjnm = ms_item-obj_name.

    rv_bool = boolc( sy-subrc = 0 ).

  ENDMETHOD.