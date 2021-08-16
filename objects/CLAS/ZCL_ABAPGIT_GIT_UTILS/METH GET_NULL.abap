  METHOD get_null.

    DATA: lv_x(4) TYPE x VALUE '00000000',
          lv_z(2) TYPE c.

    FIELD-SYMBOLS <lv_y> TYPE c.


    ASSIGN lv_x TO <lv_y> CASTING.
    lv_z = <lv_y>.
    rv_c = lv_z(1).

  ENDMETHOD.