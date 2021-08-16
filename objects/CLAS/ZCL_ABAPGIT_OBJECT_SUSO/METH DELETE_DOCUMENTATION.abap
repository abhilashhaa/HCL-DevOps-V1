  METHOD delete_documentation.

    DATA:
      lv_docu_obj TYPE dokhl-object,
      lv_dummy    TYPE sy-langu.

    lv_docu_obj  = mv_objectname.

    SELECT SINGLE langu
           FROM dokil INTO lv_dummy
           WHERE id   = 'UO'                            "#EC CI_GENBUFF
           AND object = lv_docu_obj.

    IF sy-subrc = 0.

      CALL FUNCTION 'DOKU_DELETE_ALL'
        EXPORTING
          doku_id                        = 'UO'
          doku_object                    = lv_docu_obj
          suppress_transport             = space
        EXCEPTIONS
          header_without_text            = 1
          index_without_header           = 2
          no_authority_for_devclass_xxxx = 3
          no_docu_found                  = 4
          object_is_already_enqueued     = 5
          object_is_enqueued_by_corr     = 6
          techn_enqueue_problem          = 7
          user_break                     = 8
          OTHERS                         = 9.

      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise_t100( ).
      ENDIF.

    ENDIF.

  ENDMETHOD.