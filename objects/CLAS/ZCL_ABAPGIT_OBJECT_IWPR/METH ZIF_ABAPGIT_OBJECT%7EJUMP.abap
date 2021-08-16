  METHOD zif_abapgit_object~jump.

    SUBMIT /iwbep/r_sbui_service_builder
      WITH i_prname = ms_item-obj_name
      AND RETURN.

  ENDMETHOD.