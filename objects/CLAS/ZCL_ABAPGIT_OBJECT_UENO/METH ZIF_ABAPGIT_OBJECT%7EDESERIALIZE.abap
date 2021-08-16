  METHOD zif_abapgit_object~deserialize.

    DATA lo_generic TYPE REF TO zcl_abapgit_objects_generic.

    CREATE OBJECT lo_generic
      EXPORTING
        is_item = ms_item.

    " Is the entity type name compliant with naming conventions?
    " Entity Type have their own conventions.
    is_name_permitted( ).

    lo_generic->deserialize(
      iv_package = iv_package
      io_xml     = io_xml ).

    deserialize_docu_uen( io_xml ).
    deserialize_docu_url( io_xml ).
    deserialize_docu_usp( io_xml ).

    " You are reminded that entity types are not relevant for activation.

  ENDMETHOD.