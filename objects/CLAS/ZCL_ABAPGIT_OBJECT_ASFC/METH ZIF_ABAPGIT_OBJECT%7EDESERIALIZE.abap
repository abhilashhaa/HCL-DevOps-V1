  METHOD zif_abapgit_object~deserialize.

    DATA: lo_generic TYPE REF TO zcl_abapgit_objects_generic.

    CREATE OBJECT lo_generic
      EXPORTING
        is_item = ms_item.

    lo_generic->deserialize(
      iv_package = iv_package
      io_xml     = io_xml ).

  ENDMETHOD.