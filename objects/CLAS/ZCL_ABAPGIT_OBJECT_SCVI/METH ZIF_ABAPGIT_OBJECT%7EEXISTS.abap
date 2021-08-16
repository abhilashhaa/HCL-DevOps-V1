  METHOD zif_abapgit_object~exists.

    DATA: lo_screen_variant TYPE REF TO zcl_abapgit_objects_generic.

    CREATE OBJECT lo_screen_variant
      EXPORTING
        is_item = ms_item.

    rv_bool = lo_screen_variant->exists( ).

  ENDMETHOD.