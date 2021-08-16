  METHOD add_jump_sub_menu.

    DATA: lo_sub_jump    TYPE REF TO zcl_abapgit_html_toolbar,
          lv_jump_target TYPE string.
    FIELD-SYMBOLS: <ls_diff> LIKE LINE OF mt_diff_files.

    CREATE OBJECT lo_sub_jump EXPORTING iv_id = 'jump'.

    LOOP AT mt_diff_files ASSIGNING <ls_diff>.

      lv_jump_target = <ls_diff>-path && <ls_diff>-filename.

      lo_sub_jump->add(
          iv_id  = |li_jump_{ sy-tabix }|
          iv_txt = lv_jump_target
          iv_typ = zif_abapgit_html=>c_action_type-onclick ).

    ENDLOOP.

    io_menu->add( iv_txt = 'Jump'
                  io_sub = lo_sub_jump ).

  ENDMETHOD.