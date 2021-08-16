  METHOD warning_package_find.

    DATA: lv_package         TYPE devclass,
          lt_overwrite_uniqe TYPE HASHED TABLE OF zif_abapgit_definitions=>ty_overwrite
                                  WITH UNIQUE KEY obj_type obj_name devclass,
          ls_overwrite       LIKE LINE OF rt_overwrite,
          ls_tadir           TYPE zif_abapgit_definitions=>ty_tadir.

    DATA: lo_folder_logic TYPE REF TO zcl_abapgit_folder_logic.

    FIELD-SYMBOLS: <ls_result> LIKE LINE OF it_results.

    lo_folder_logic = zcl_abapgit_folder_logic=>get_instance( ).
    LOOP AT it_results ASSIGNING <ls_result>.

      lv_package = lo_folder_logic->path_to_package(
        iv_top  = io_repo->get_package( )
        io_dot  = io_repo->get_dot_abapgit( )
        iv_path = <ls_result>-path ).

      ls_tadir = zcl_abapgit_factory=>get_tadir( )->read_single(
        iv_object   = <ls_result>-obj_type
        iv_obj_name = <ls_result>-obj_name ).

      IF NOT ls_tadir IS INITIAL AND ls_tadir-devclass <> lv_package.
* overwriting object from different package than expected
        CLEAR ls_overwrite.
        ls_overwrite-obj_type = <ls_result>-obj_type.
        ls_overwrite-obj_name = <ls_result>-obj_name.
        ls_overwrite-devclass = ls_tadir-devclass.
        INSERT ls_overwrite INTO TABLE lt_overwrite_uniqe.
      ENDIF.

    ENDLOOP.

    rt_overwrite = lt_overwrite_uniqe.

  ENDMETHOD.