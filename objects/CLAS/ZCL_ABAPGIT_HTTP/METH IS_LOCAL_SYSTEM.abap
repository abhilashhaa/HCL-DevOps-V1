  METHOD is_local_system.

    DATA: lv_host TYPE string,
          lt_list TYPE zif_abapgit_exit=>ty_icm_sinfo2_tt,
          li_exit TYPE REF TO zif_abapgit_exit.

    FIELD-SYMBOLS: <ls_list> LIKE LINE OF lt_list.


    CALL FUNCTION 'ICM_GET_INFO2'
      TABLES
        servlist    = lt_list
      EXCEPTIONS
        icm_error   = 1
        icm_timeout = 2
        OTHERS      = 3.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    APPEND INITIAL LINE TO lt_list ASSIGNING <ls_list>.
    <ls_list>-hostname = 'localhost'.

    li_exit = zcl_abapgit_exit=>get_instance( ).
    li_exit->change_local_host( CHANGING ct_hosts = lt_list ).

    FIND REGEX 'https?://([^/^:]*)' IN iv_url
      SUBMATCHES lv_host.

    READ TABLE lt_list WITH KEY hostname = lv_host TRANSPORTING NO FIELDS.
    rv_bool = boolc( sy-subrc = 0 ).

  ENDMETHOD.