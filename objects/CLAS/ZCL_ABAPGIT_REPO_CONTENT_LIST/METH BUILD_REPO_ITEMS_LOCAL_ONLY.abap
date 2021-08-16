  METHOD build_repo_items_local_only.

    DATA: lt_tadir TYPE zif_abapgit_definitions=>ty_tadir_tt,
          ls_item  TYPE zif_abapgit_definitions=>ty_item.

    FIELD-SYMBOLS: <ls_repo_item> LIKE LINE OF rt_repo_items,
                   <ls_tadir>     LIKE LINE OF lt_tadir.


    lt_tadir = zcl_abapgit_factory=>get_tadir( )->read(
      iv_package = mo_repo->get_package( )
      io_dot     = mo_repo->get_dot_abapgit( ) ).

    LOOP AT lt_tadir ASSIGNING <ls_tadir>.
      APPEND INITIAL LINE TO rt_repo_items ASSIGNING <ls_repo_item>.
      <ls_repo_item>-obj_type = <ls_tadir>-object.
      <ls_repo_item>-obj_name = <ls_tadir>-obj_name.
      <ls_repo_item>-path     = <ls_tadir>-path.
      MOVE-CORRESPONDING <ls_repo_item> TO ls_item.
      <ls_repo_item>-inactive = boolc( zcl_abapgit_objects=>is_active( ls_item ) = abap_false ).
      IF <ls_repo_item>-inactive = abap_true.
        <ls_repo_item>-sortkey = c_sortkey-inactive.
      ELSE.
        <ls_repo_item>-sortkey  = c_sortkey-default.      " Default sort key
      ENDIF.
    ENDLOOP.

  ENDMETHOD.