  METHOD decode_merge.

    DATA lt_fields TYPE tihttpnvp.
    FIELD-SYMBOLS: <ls_field> LIKE LINE OF lt_fields.


    lt_fields = zcl_abapgit_html_action_utils=>parse_post_form_data( it_postdata ).

    READ TABLE lt_fields ASSIGNING <ls_field> WITH KEY name = 'source'.
    ASSERT sy-subrc = 0.
    rs_merge-source = <ls_field>-value.

    READ TABLE lt_fields ASSIGNING <ls_field> WITH KEY name = 'target'.
    ASSERT sy-subrc = 0.
    rs_merge-target = <ls_field>-value.

  ENDMETHOD.