  METHOD zif_abapgit_comparator~compare.

    rs_result-text = validate(
      ii_remote_version = ii_remote
      ii_local_version  = mi_local
      ii_log            = ii_log ).

  ENDMETHOD.