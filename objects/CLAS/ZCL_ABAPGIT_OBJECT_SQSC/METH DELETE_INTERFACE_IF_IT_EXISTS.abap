  METHOD delete_interface_if_it_exists.

    DATA: ls_item      TYPE zif_abapgit_definitions=>ty_item,
          lo_interface TYPE REF TO zcl_abapgit_object_intf.

    " The interface is managed by the proxy. If abapGit
    " has created it before we have to delete it. Otherwise
    " if_dbproc_proxy_ui~create will throw errors.

    ls_item-obj_name = iv_interface.
    ls_item-obj_type = 'INTF'.

    IF zcl_abapgit_objects=>exists( ls_item ) = abap_true.

      CREATE OBJECT lo_interface
        EXPORTING
          is_item     = ls_item
          iv_language = mv_language.

      lo_interface->zif_abapgit_object~delete( iv_package ).

    ENDIF.

  ENDMETHOD.