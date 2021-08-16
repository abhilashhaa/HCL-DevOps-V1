  METHOD add_filter_sub_menu.

    DATA:
      lo_sub_filter TYPE REF TO zcl_abapgit_html_toolbar,
      lt_types      TYPE string_table,
      lt_users      TYPE string_table.

    FIELD-SYMBOLS: <ls_diff> LIKE LINE OF mt_diff_files,
                   <lv_i>    TYPE string.
    " Get unique
    LOOP AT mt_diff_files ASSIGNING <ls_diff>.
      APPEND <ls_diff>-type TO lt_types.
      APPEND <ls_diff>-changed_by TO lt_users.
    ENDLOOP.

    SORT lt_types.
    DELETE ADJACENT DUPLICATES FROM lt_types.

    SORT lt_users.
    DELETE ADJACENT DUPLICATES FROM lt_users.

    IF lines( lt_types ) > 1 OR lines( lt_users ) > 1.
      CREATE OBJECT lo_sub_filter EXPORTING iv_id = 'diff-filter'.

      " File types
      IF lines( lt_types ) > 1.
        lo_sub_filter->add( iv_txt = 'TYPE'
                            iv_typ = zif_abapgit_html=>c_action_type-separator ).
        LOOP AT lt_types ASSIGNING <lv_i>.
          lo_sub_filter->add( iv_txt = <lv_i>
                       iv_typ = zif_abapgit_html=>c_action_type-onclick
                       iv_aux = 'type'
                       iv_chk = abap_true ).
        ENDLOOP.
      ENDIF.

      " Changed by
      IF lines( lt_users ) > 1.
        lo_sub_filter->add( iv_txt = 'CHANGED BY'
                            iv_typ = zif_abapgit_html=>c_action_type-separator ).
        LOOP AT lt_users ASSIGNING <lv_i>.
          lo_sub_filter->add( iv_txt = <lv_i>
                       iv_typ = zif_abapgit_html=>c_action_type-onclick
                       iv_aux = 'changed-by'
                       iv_chk = abap_true ).
        ENDLOOP.
      ENDIF.

      io_menu->add( iv_txt = 'Filter'
                    io_sub = lo_sub_filter ).
    ENDIF.

  ENDMETHOD.