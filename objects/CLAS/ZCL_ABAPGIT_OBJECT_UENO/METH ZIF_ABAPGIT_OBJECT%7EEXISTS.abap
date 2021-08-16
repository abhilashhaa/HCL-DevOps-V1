  METHOD zif_abapgit_object~exists.

    DATA: lo_generic TYPE REF TO zcl_abapgit_objects_generic.

    CREATE OBJECT lo_generic
      EXPORTING
        is_item = ms_item.

    rv_bool = lo_generic->exists( ).

  ENDMETHOD.