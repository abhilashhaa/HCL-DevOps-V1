  METHOD escape_branch.

    rv_string = iv_string.

    TRANSLATE rv_string USING '-_._#_'.

    rv_string = |branch_{ rv_string }|.

  ENDMETHOD.