  METHOD normalize_branch_name.

    rv_name = iv_branch_name. " Force convert to string
    REPLACE ALL OCCURRENCES OF ` ` IN rv_name WITH '-'. " Disallow space in branch name

  ENDMETHOD.