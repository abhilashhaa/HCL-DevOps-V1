  METHOD zif_abapgit_object~delete.

    DATA lo_generic TYPE REF TO zcl_abapgit_objects_generic.

    CREATE OBJECT lo_generic
      EXPORTING
        is_item = ms_item.

    " The deletion of the documentation occurs before the deletion of
    " the associated tables - otherwise we don't know what
    " documentation needs deletion
    delete_docu_uen( ).
    delete_docu_url( ).
    delete_docu_usp( ).

    " the deletion of the tables of the entity
    lo_generic->delete( ).

  ENDMETHOD.