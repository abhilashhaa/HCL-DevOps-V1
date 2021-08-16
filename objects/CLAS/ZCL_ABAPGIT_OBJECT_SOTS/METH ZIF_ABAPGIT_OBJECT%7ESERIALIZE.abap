  METHOD zif_abapgit_object~serialize.

    DATA: lt_sots TYPE tty_sots.

    FIELD-SYMBOLS: <ls_sots>  TYPE ty_sots,
                   <ls_entry> TYPE sotr_textl.

    lt_sots = read_sots( ).

    LOOP AT lt_sots ASSIGNING <ls_sots>.

      LOOP AT <ls_sots>-entries ASSIGNING <ls_entry>.

        mo_files->add_string( iv_extra  = get_raw_text_filename( <ls_entry> )
                              iv_ext    = 'txt'
                              iv_string = <ls_entry>-text ).

        CLEAR: <ls_entry>-text.

      ENDLOOP.

    ENDLOOP.

    io_xml->add( iv_name = 'SOTS'
                 ig_data = lt_sots ).

  ENDMETHOD.