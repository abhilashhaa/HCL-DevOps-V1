  METHOD build_string.

    DATA:
      ls_charc_value  TYPE ngcs_core_charc_value_data,
      ls_charc_header TYPE ngcs_core_charc_header.


    MOVE-CORRESPONDING is_charc_header TO ls_charc_header.
    MOVE-CORRESPONDING is_charc_value TO ls_charc_value.

    mo_cls_util_intersect->build_string(
      EXPORTING
        is_charc_head      = ls_charc_header
        iv_charcinternalid = is_charc_header-charcinternalid
      IMPORTING
        et_core_message    = DATA(lt_core_message)
      CHANGING
        cs_charc_value     = ls_charc_value ).

    LOOP AT lt_core_message ASSIGNING FIELD-SYMBOL(<ls_core_message>).
      APPEND INITIAL LINE TO et_message ASSIGNING FIELD-SYMBOL(<ls_message>).
      MOVE-CORRESPONDING <ls_core_message> TO <ls_message>.
      <ls_message>-key_date        = sy-datum.
      <ls_message>-charcinternalid = is_charc_header-charcinternalid.
    ENDLOOP.

    ev_charc_value = ls_charc_value-charcvalue.

  ENDMETHOD.