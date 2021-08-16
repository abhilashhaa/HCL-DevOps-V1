  METHOD pull.

    DATA: lo_repo TYPE REF TO zcl_abapgit_repo.

    lo_repo = zcl_abapgit_repo_srv=>get_instance( )->get( iv_key ).

    lo_repo->refresh( ).

    zcl_abapgit_services_repo=>gui_deserialize( lo_repo ).

    COMMIT WORK.

  ENDMETHOD.