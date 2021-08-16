  METHOD read.

    DATA: lv_object TYPE dokhl-object,
          lv_id     TYPE dokhl-id.


    lv_id = ms_item-obj_name(2).
    lv_object = ms_item-obj_name+2.

    CALL FUNCTION 'DOCU_READ'
      EXPORTING
        id       = lv_id
        langu    = mv_language
        object   = lv_object
        typ      = c_typ
        version  = c_version
      IMPORTING
        doktitle = rs_data-doctitle
        head     = rs_data-head
      TABLES
        line     = rs_data-lines.

  ENDMETHOD.