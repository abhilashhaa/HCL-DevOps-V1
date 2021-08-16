  METHOD stage_transport_objects.
    DATA lo_transport_objects TYPE REF TO zcl_abapgit_transport_objects.
    CREATE OBJECT lo_transport_objects
      EXPORTING
        it_transport_objects = it_transport_objects.

    lo_transport_objects->to_stage(
      io_stage           = io_stage
      is_stage_objects   = is_stage_objects
      it_object_statuses = it_object_statuses ).
  ENDMETHOD.