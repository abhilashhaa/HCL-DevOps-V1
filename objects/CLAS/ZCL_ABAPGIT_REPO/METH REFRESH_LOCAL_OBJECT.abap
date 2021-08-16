  METHOD refresh_local_object.

    DATA:
      ls_tadir           TYPE zif_abapgit_definitions=>ty_tadir,
      lt_tadir           TYPE zif_abapgit_definitions=>ty_tadir_tt,
      lt_new_local_files TYPE zif_abapgit_definitions=>ty_files_item_tt,
      lo_serialize       TYPE REF TO zcl_abapgit_serialize.

    lt_tadir = zcl_abapgit_factory=>get_tadir( )->read(
                   iv_package = ms_data-package
                   io_dot     = get_dot_abapgit( ) ).

    DELETE mt_local WHERE item-obj_type = iv_obj_type
                    AND   item-obj_name = iv_obj_name.

    READ TABLE lt_tadir INTO ls_tadir
                        WITH KEY object   = iv_obj_type
                                 obj_name = iv_obj_name.
    IF sy-subrc <> 0 OR ls_tadir-delflag = abap_true.
      " object doesn't exist anymore, nothing todo here
      RETURN.
    ENDIF.

    CLEAR lt_tadir.
    INSERT ls_tadir INTO TABLE lt_tadir.

    CREATE OBJECT lo_serialize.
    lt_new_local_files = lo_serialize->serialize( lt_tadir ).

    INSERT LINES OF lt_new_local_files INTO TABLE mt_local.

  ENDMETHOD.