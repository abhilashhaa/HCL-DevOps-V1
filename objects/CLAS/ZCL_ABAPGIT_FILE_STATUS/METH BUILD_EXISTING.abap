  METHOD build_existing.

    DATA: ls_file_sig LIKE LINE OF it_state.

    " Item
    rs_result-obj_type = is_local-item-obj_type.
    rs_result-obj_name = is_local-item-obj_name.
    rs_result-package  = is_local-item-devclass.

    " File
    rs_result-path     = is_local-file-path.
    rs_result-filename = is_local-file-filename.

    IF is_local-file-sha1 = is_remote-sha1.
      rs_result-match = abap_true.
      RETURN.
    ENDIF.

    " Match against current state
    READ TABLE it_state INTO ls_file_sig
      WITH KEY path = is_local-file-path
      filename = is_local-file-filename
      BINARY SEARCH.

    IF sy-subrc = 0.
      IF ls_file_sig-sha1 <> is_local-file-sha1.
        rs_result-lstate = zif_abapgit_definitions=>c_state-modified.
      ENDIF.
      IF ls_file_sig-sha1 <> is_remote-sha1.
        rs_result-rstate = zif_abapgit_definitions=>c_state-modified.
      ENDIF.
      rs_result-match = boolc( rs_result-lstate IS INITIAL
        AND rs_result-rstate IS INITIAL ).
    ELSE.
      " This is a strange situation. As both local and remote exist
      " the state should also be present. Maybe this is a first run of the code.
      " In this case just compare hashes directly and mark both changed
      " the user will presumably decide what to do after checking the actual diff
      rs_result-match = boolc( is_local-file-sha1 = is_remote-sha1 ).
      IF rs_result-match = abap_false.
        rs_result-lstate = zif_abapgit_definitions=>c_state-modified.
        rs_result-rstate = zif_abapgit_definitions=>c_state-modified.
      ENDIF.
    ENDIF.

  ENDMETHOD.