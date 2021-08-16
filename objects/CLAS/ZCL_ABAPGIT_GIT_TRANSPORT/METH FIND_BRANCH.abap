  METHOD find_branch.

    branch_list(
      EXPORTING
        iv_url          = iv_url
        iv_service      = iv_service
      IMPORTING
        eo_client       = eo_client
        eo_branch_list  = eo_branch_list ).

    IF ev_branch IS SUPPLIED.
      ev_branch = eo_branch_list->find_by_name( iv_branch_name )-sha1.
    ENDIF.

  ENDMETHOD.