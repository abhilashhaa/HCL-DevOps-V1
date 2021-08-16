  METHOD delete.

    DATA: ls_item     TYPE zif_abapgit_definitions=>ty_item,
          li_progress TYPE REF TO zif_abapgit_progress,
          lt_tadir    LIKE it_tadir,
          lt_items    TYPE zif_abapgit_definitions=>ty_items_tt,
          lx_error    TYPE REF TO zcx_abapgit_exception,
          lv_text     TYPE string.

    FIELD-SYMBOLS: <ls_tadir> LIKE LINE OF it_tadir.

    lt_tadir = it_tadir.

    IF is_checks-transport-required = abap_true.
      zcl_abapgit_default_transport=>get_instance( )->set( is_checks-transport-transport ).
    ENDIF.

    TRY.
        zcl_abapgit_dependencies=>resolve( CHANGING ct_tadir = lt_tadir ).

        li_progress = zcl_abapgit_progress=>get_instance( lines( lt_tadir ) ).

        lt_items = map_tadir_to_items( lt_tadir ).

        check_objects_locked( iv_language = zif_abapgit_definitions=>c_english
                              it_items    = lt_items ).

        LOOP AT lt_tadir ASSIGNING <ls_tadir>.
          li_progress->show( iv_current = sy-tabix
                             iv_text    = |Delete { <ls_tadir>-obj_name }| ).

          CLEAR ls_item.
          ls_item-obj_type = <ls_tadir>-object.
          ls_item-obj_name = <ls_tadir>-obj_name.
          delete_obj(
            iv_package = <ls_tadir>-devclass
            is_item    = ls_item ).

* make sure to save object deletions
          COMMIT WORK.
        ENDLOOP.

      CATCH zcx_abapgit_exception INTO lx_error.
        zcl_abapgit_default_transport=>get_instance( )->reset( ).
        RAISE EXCEPTION lx_error.
    ENDTRY.

    zcl_abapgit_default_transport=>get_instance( )->reset( ).

  ENDMETHOD.