INTERFACE lif_uom_converter.

  METHODS:
    convert_value_uom
      IMPORTING
        iv_uom_from     TYPE msehi
        iv_uom_to       TYPE msehi
        iv_value        TYPE atflv
        is_charc_header TYPE ngcs_core_charc
      EXPORTING
        et_message      TYPE ngct_core_charc_msg
        ev_value        TYPE atflv.

ENDINTERFACE.