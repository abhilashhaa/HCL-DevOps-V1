  METHOD zif_abapgit_object~deserialize.

    DATA: lt_sots    TYPE tty_sots,
          lt_objects TYPE sotr_objects,
          lv_object  LIKE LINE OF lt_objects.

    FIELD-SYMBOLS: <ls_sots>  TYPE ty_sots,
                   <ls_entry> LIKE LINE OF <ls_sots>-entries.

    io_xml->read(
      EXPORTING
        iv_name = 'SOTS'
      CHANGING
        cg_data = lt_sots ).

    tadir_insert( iv_package ).

    LOOP AT lt_sots ASSIGNING <ls_sots>.

      CLEAR: lt_objects.

      CALL FUNCTION 'SOTR_OBJECT_GET_OBJECTS'
        EXPORTING
          object_vector    = <ls_sots>-header-objid_vec
        IMPORTING
          objects          = lt_objects
        EXCEPTIONS
          object_not_found = 1
          OTHERS           = 2.

      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise( 'error from SOTR_OBJECT_GET_OBJECTS' ).
      ENDIF.

      READ TABLE lt_objects INDEX 1 INTO lv_object.
      ASSERT sy-subrc = 0.

      LOOP AT <ls_sots>-entries ASSIGNING <ls_entry>.

        TRY.
            <ls_entry>-text = mo_files->read_string( iv_extra = get_raw_text_filename( <ls_entry> )
                                                     iv_ext   = 'txt' ).

          CATCH zcx_abapgit_exception.
            " Most probably file not found -> ignore
            CONTINUE.
        ENDTRY.

      ENDLOOP.

      create_sots(
          is_sots    = <ls_sots>
          iv_package = iv_package
          iv_object  = lv_object ).

    ENDLOOP.

  ENDMETHOD.