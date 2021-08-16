  METHOD build_new_remote.

    DATA: ls_item     LIKE LINE OF it_items,
          ls_file_sig LIKE LINE OF it_state.

    " Common and default part
    rs_result-path     = is_remote-path.
    rs_result-filename = is_remote-filename.
    rs_result-match    = abap_false.
    rs_result-rstate   = zif_abapgit_definitions=>c_state-added.

    identify_object( EXPORTING iv_filename = is_remote-filename
                               iv_path     = is_remote-path
                               iv_devclass = iv_devclass
                               io_dot      = io_dot
                     IMPORTING es_item     = ls_item ).

    " Check if in item index + get package
    READ TABLE it_items INTO ls_item
      WITH KEY obj_type = ls_item-obj_type obj_name = ls_item-obj_name
      BINARY SEARCH.

    IF sy-subrc = 0.

      " Completely new (xml, abap) and new file in an existing object
      rs_result-obj_type = ls_item-obj_type.
      rs_result-obj_name = ls_item-obj_name.
      rs_result-package  = ls_item-devclass.

      READ TABLE it_state INTO ls_file_sig
        WITH KEY path = is_remote-path filename = is_remote-filename
        BINARY SEARCH.

      " Existing file but from another package
      " was not added during local file proc as was not in tadir for repo package
      IF sy-subrc = 0.
        IF ls_file_sig-sha1 = is_remote-sha1.
          rs_result-match = abap_true.
          CLEAR rs_result-rstate.
        ELSE.
          rs_result-rstate = zif_abapgit_definitions=>c_state-modified.
        ENDIF.

        " Item is in state and in cache but with no package - it was deleted
        " OR devclass is the same as repo package (see #532)
        IF ls_item-devclass IS INITIAL OR ls_item-devclass = iv_devclass.
          rs_result-match  = abap_false.
          rs_result-lstate = zif_abapgit_definitions=>c_state-deleted.
        ENDIF.
      ENDIF.

    ELSE. " Completely unknown file, probably non-abapgit
      ASSERT 1 = 1. " No action, just follow defaults
    ENDIF.

  ENDMETHOD.