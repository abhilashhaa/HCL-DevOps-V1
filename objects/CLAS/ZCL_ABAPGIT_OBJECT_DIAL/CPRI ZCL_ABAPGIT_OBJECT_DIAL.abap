  PRIVATE SECTION.
    TYPES: BEGIN OF ty_dialog_module,
             tdct     TYPE tdct,
             dia_pars TYPE STANDARD TABLE OF diapar
                           WITH NON-UNIQUE DEFAULT KEY,
           END OF ty_dialog_module.

    METHODS:
      _read_tdct
        RETURNING
          VALUE(rs_tdct) TYPE tdct.
