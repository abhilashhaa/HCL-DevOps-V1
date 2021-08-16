  METHOD extract_author_data.

    " unix time stamps are in same time zone, so ignore the zone
    FIND REGEX zif_abapgit_definitions=>c_author_regex IN iv_author
      SUBMATCHES
      ev_author
      ev_email
      ev_time.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error author regex value='{ iv_author }'| ).
    ENDIF.

  ENDMETHOD.