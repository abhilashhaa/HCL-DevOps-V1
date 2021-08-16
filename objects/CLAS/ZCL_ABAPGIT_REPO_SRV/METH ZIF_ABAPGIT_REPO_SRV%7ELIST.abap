  METHOD zif_abapgit_repo_srv~list.

    IF mv_init = abap_false.
      refresh( ).
    ENDIF.

    rt_list = mt_list.

  ENDMETHOD.