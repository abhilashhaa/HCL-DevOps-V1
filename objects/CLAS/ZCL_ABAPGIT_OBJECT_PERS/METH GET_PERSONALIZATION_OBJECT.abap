  METHOD get_personalization_object.

    CREATE OBJECT ro_personalization_object
      EXPORTING
        p_create                = iv_create
        p_pers_key              = mv_pers_key
        p_view_only             = iv_view_only
      EXCEPTIONS
        pers_key_already_exists = 1
        pers_key_does_not_exist = 2
        transport_view_only     = 3
        transport_canceled      = 4
        OTHERS                  = 5.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

  ENDMETHOD.