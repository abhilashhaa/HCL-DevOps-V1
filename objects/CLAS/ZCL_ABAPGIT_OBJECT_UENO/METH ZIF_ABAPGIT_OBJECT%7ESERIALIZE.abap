  METHOD zif_abapgit_object~serialize.

    DATA: lo_generic TYPE REF TO zcl_abapgit_objects_generic.

    CREATE OBJECT lo_generic
      EXPORTING
        is_item = ms_item.

    lo_generic->serialize( io_xml ).

    serialize_docu_uen( io_xml ).
    serialize_docu_url( io_xml ).
    serialize_docu_usp( io_xml ).

  ENDMETHOD.