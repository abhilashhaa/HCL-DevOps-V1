  METHOD refresh.

    zcl_abapgit_repo_srv=>get_instance( )->get( iv_key )->refresh( ).

  ENDMETHOD.