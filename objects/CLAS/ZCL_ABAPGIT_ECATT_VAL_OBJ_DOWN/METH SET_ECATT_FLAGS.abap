  METHOD set_ecatt_flags.

    DATA:
      lv_invert_validation TYPE zif_abapgit_ecatt=>etvo_invert_validation,
      lv_error_prio        TYPE zif_abapgit_ecatt=>etvo_error_prio,
      li_element           TYPE REF TO if_ixml_element,
      li_insert_objects    TYPE REF TO if_ixml_element,
      lo_ecatt_vo          TYPE REF TO object.

    FIELD-SYMBOLS: <lg_ecatt_vo> TYPE any.

    mi_objects_node = template_over_all->create_simple_element(
                                           name   = 'VO_FLAGS'
                                           parent = root_node ).

    ASSIGN ('ECATT_OBJECT') TO <lg_ecatt_vo>.
    ASSERT sy-subrc = 0.

    lo_ecatt_vo = <lg_ecatt_vo>.

    CALL METHOD lo_ecatt_vo->('GET_INVERT_VALIDATION_FLAG')
      RECEIVING
        re_invert_validation = lv_invert_validation.

    CALL FUNCTION 'SDIXML_DATA_TO_DOM'
      EXPORTING
        name         = 'INVERT_VALIDATION'
        dataobject   = lv_invert_validation
      IMPORTING
        data_as_dom  = li_element
      CHANGING
        document     = template_over_all
      EXCEPTIONS
        illegal_name = 1
        OTHERS       = 2.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    li_insert_objects ?= template_over_all->find_from_name( 'VO_FLAGS' ).

    li_insert_objects->append_child( new_child = li_element ).

    CALL METHOD lo_ecatt_vo->('GET_ERROR_PRIORITY')
      RECEIVING
        re_error_prio = lv_error_prio.

    CALL FUNCTION 'SDIXML_DATA_TO_DOM'
      EXPORTING
        name         = 'ERROR_PRIORITY'
        dataobject   = lv_error_prio
      IMPORTING
        data_as_dom  = li_element
      CHANGING
        document     = template_over_all
      EXCEPTIONS
        illegal_name = 1
        OTHERS       = 2.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    li_insert_objects = template_over_all->find_from_name( 'VO_FLAGS' ).

    li_insert_objects->append_child( new_child = li_element ).

  ENDMETHOD.