  METHOD make.
    IF gi_object_oriented_object IS BOUND.
      ri_object_oriented_object = gi_object_oriented_object.
      RETURN.
    ENDIF.
    IF iv_object_type = 'CLAS'.
      CREATE OBJECT ri_object_oriented_object TYPE zcl_abapgit_oo_class.
    ELSEIF iv_object_type = 'INTF'.
      CREATE OBJECT ri_object_oriented_object TYPE zcl_abapgit_oo_interface.
    ENDIF.
  ENDMETHOD.