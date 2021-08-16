  METHOD find_tag_by_name.

    DATA: lv_branch_name TYPE string.

    lv_branch_name = iv_branch_name && '^{}'.

    READ TABLE mt_branches INTO rs_branch
        WITH KEY name = lv_branch_name.
    IF sy-subrc <> 0.

      READ TABLE mt_branches INTO rs_branch
        WITH KEY name = iv_branch_name.
      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise( 'Branch not found' ).
      ENDIF.

    ENDIF.

  ENDMETHOD.