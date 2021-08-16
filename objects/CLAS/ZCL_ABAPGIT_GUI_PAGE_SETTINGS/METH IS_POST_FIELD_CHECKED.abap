  METHOD is_post_field_checked.
    FIELD-SYMBOLS: <ls_post_field> TYPE ihttpnvp.
    READ TABLE mt_post_fields ASSIGNING <ls_post_field> WITH KEY name = iv_name.
    IF sy-subrc = 0
        AND ( <ls_post_field>-value = abap_true "HTML value when using standard netweaver GUI
        OR <ls_post_field>-value = 'on' ).     "HTML value when using Netweaver Java GUI
      rv_return = abap_true.
    ENDIF.
  ENDMETHOD.