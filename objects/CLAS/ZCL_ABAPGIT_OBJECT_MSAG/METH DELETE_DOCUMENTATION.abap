  METHOD delete_documentation.
    DATA: lv_key_s TYPE dokhl-object.

    CLEAR lv_key_s.
    CALL FUNCTION 'DOCU_OBJECT_NAME_CONCATENATE'
      EXPORTING
        docu_id  = 'NA'
        element  = iv_message_id
        addition = '   '
      IMPORTING
        object   = lv_key_s
      EXCEPTIONS
        OTHERS   = 0.

    CALL FUNCTION 'DOKU_DELETE_ALL'
      EXPORTING
        doku_id                        = 'NA'
        doku_object                    = lv_key_s
        generic_use                    = 'X'
        suppress_authority             = space
        suppress_enqueue               = space
        suppress_transport             = space
      EXCEPTIONS
        header_without_text            = 01
        index_without_header           = 02
        no_authority_for_devclass_xxxx = 03
        no_docu_found                  = 04
        object_is_already_enqueued     = 05
        object_is_enqueued_by_corr     = 06
        user_break                     = 07.

  ENDMETHOD.