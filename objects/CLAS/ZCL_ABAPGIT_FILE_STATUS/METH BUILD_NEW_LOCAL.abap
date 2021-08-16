  METHOD build_new_local.

    " Item
    rs_result-obj_type = is_local-item-obj_type.
    rs_result-obj_name = is_local-item-obj_name.
    rs_result-package  = is_local-item-devclass.

    " File
    rs_result-path     = is_local-file-path.
    rs_result-filename = is_local-file-filename.

    " Match
    rs_result-match    = abap_false.
    rs_result-lstate   = zif_abapgit_definitions=>c_state-added.

  ENDMETHOD.