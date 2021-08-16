  METHOD zif_abapgit_object~serialize.

    DATA: ls_dialog_module TYPE ty_dialog_module.

    ls_dialog_module-tdct = _read_tdct( ).

    SELECT * FROM diapar
             INTO TABLE ls_dialog_module-dia_pars
             WHERE dnam = ls_dialog_module-tdct-dnam.

    io_xml->add( iv_name = 'DIAL'
                 ig_data = ls_dialog_module ).

  ENDMETHOD.