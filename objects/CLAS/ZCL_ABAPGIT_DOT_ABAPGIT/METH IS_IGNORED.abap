  METHOD is_ignored.

    DATA: lv_name     TYPE string,
          lv_starting TYPE string,
          lv_dot      TYPE string,
          lv_count    TYPE i,
          lv_ignore   TYPE string.


    lv_name = iv_path && iv_filename.

    CONCATENATE ms_data-starting_folder '*' INTO lv_starting.
    CONCATENATE '/' zif_abapgit_definitions=>c_dot_abapgit INTO lv_dot.

    LOOP AT ms_data-ignore INTO lv_ignore.
      FIND ALL OCCURRENCES OF '/' IN lv_name MATCH COUNT lv_count.

      IF lv_name CP lv_ignore
          OR ( ms_data-starting_folder <> '/'
          AND lv_count > 1
          AND NOT lv_name CP lv_starting
          AND NOT lv_name = lv_dot ).
        rv_ignored = abap_true.
        RETURN.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.