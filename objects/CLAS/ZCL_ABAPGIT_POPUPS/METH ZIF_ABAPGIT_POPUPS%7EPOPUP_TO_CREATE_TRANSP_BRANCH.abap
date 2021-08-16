  METHOD zif_abapgit_popups~popup_to_create_transp_branch.
    DATA: lt_fields             TYPE TABLE OF sval,
          lv_transports_as_text TYPE string,
          lv_desc_as_text       TYPE string,
          ls_transport_header   LIKE LINE OF it_transport_headers.
    DATA: lv_branch_name        TYPE spo_value.
    DATA: lv_commit_text        TYPE spo_value.

    CLEAR: rs_transport_branch-branch_name, rs_transport_branch-commit_text.

    " If we only have one transport selected set branch name to Transport
    " name and commit description to transport description.
    IF lines( it_transport_headers ) = 1.
      READ TABLE it_transport_headers INDEX 1 INTO ls_transport_header.
      lv_transports_as_text = ls_transport_header-trkorr.
      SELECT SINGLE as4text FROM e07t INTO lv_desc_as_text  WHERE
        trkorr = ls_transport_header-trkorr AND
        langu = sy-langu.
    ELSE.   " Else set branch name and commit message to 'Transport(s)_TRXXXXXX_TRXXXXX'
      lv_transports_as_text = 'Transport(s)'.
      LOOP AT it_transport_headers INTO ls_transport_header.
        CONCATENATE lv_transports_as_text '_' ls_transport_header-trkorr INTO lv_transports_as_text.
      ENDLOOP.
      lv_desc_as_text = lv_transports_as_text.

    ENDIF.
    add_field( EXPORTING iv_tabname   = 'TEXTL'
                         iv_fieldname = 'LINE'
                         iv_fieldtext = 'Branch name'
                         iv_value     = lv_transports_as_text
               CHANGING ct_fields     = lt_fields ).

    add_field( EXPORTING iv_tabname   = 'ABAPTXT255'
                         iv_fieldname = 'LINE'
                         iv_fieldtext = 'Commit text'
                         iv_value     = lv_desc_as_text
               CHANGING ct_fields     = lt_fields ).

    _popup_3_get_values( EXPORTING iv_popup_title    = 'Transport to new Branch'
                         IMPORTING ev_value_1        = lv_branch_name
                                   ev_value_2        = lv_commit_text
                         CHANGING  ct_fields         = lt_fields ).

    rs_transport_branch-branch_name = lv_branch_name.
    rs_transport_branch-commit_text = lv_commit_text.

  ENDMETHOD.