  METHOD get_instance.
    IF gi_ref IS INITIAL.
      CREATE OBJECT gi_ref TYPE zcl_abapgit_repo_srv.
    ENDIF.
    ri_srv = gi_ref.
  ENDMETHOD.