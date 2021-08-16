  METHOD zif_abapgit_object~jump.

    SUBMIT /iwbep/r_dst_vocan_register
      WITH ip_aname = ms_item-obj_name
      WITH ip_avers = ms_item-obj_name+32(4)
      AND RETURN.

  ENDMETHOD.