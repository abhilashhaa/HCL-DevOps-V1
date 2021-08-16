  METHOD zif_abapgit_object~exists.

    DATA: lv_name TYPE fpinterface-name.

    SELECT SINGLE name FROM fpinterface
      INTO lv_name
      WHERE name = ms_item-obj_name
      AND state = 'A'.
    rv_bool = boolc( sy-subrc = 0 ).

  ENDMETHOD.