  METHOD run.

    CONSTANTS: lc_enq_type TYPE c LENGTH 12 VALUE 'BACKGROUND'.

    DATA: lo_per        TYPE REF TO zcl_abapgit_persist_background,
          lo_repo       TYPE REF TO zcl_abapgit_repo_online,
          lt_list       TYPE zcl_abapgit_persist_background=>tt_background,
          li_background TYPE REF TO zif_abapgit_background,
          li_log        TYPE REF TO zif_abapgit_log,
          lv_repo_name  TYPE string.

    FIELD-SYMBOLS: <ls_list> LIKE LINE OF lt_list.


    CALL FUNCTION 'ENQUEUE_EZABAPGIT'
      EXPORTING
        mode_zabapgit  = 'E'
        type           = lc_enq_type
        _scope         = '3'
      EXCEPTIONS
        foreign_lock   = 1
        system_failure = 2
        OTHERS         = 3.
    IF sy-subrc <> 0.
      WRITE: / 'Another intance of the program is already running'.
      RETURN.
    ENDIF.

    CREATE OBJECT lo_per.
    lt_list = lo_per->list( ).

    WRITE: / 'Background mode'.

    LOOP AT lt_list ASSIGNING <ls_list>.
      lo_repo ?= zcl_abapgit_repo_srv=>get_instance( )->get( <ls_list>-key ).
      lv_repo_name = lo_repo->get_name( ).
      WRITE: / <ls_list>-method, lv_repo_name.

      zcl_abapgit_login_manager=>set(
        iv_uri      = lo_repo->get_url( )
        iv_username = <ls_list>-username
        iv_password = <ls_list>-password ).

      CREATE OBJECT li_log TYPE zcl_abapgit_log.
      CREATE OBJECT li_background TYPE (<ls_list>-method).

      li_background->run(
        io_repo     = lo_repo
        ii_log      = li_log
        it_settings = <ls_list>-settings ).

      zcl_abapgit_log_viewer=>write_log( li_log ).
    ENDLOOP.

    IF lines( lt_list ) = 0.
      WRITE: / 'Nothing configured'.
    ENDIF.

    CALL FUNCTION 'DEQUEUE_EZABAPGIT'
      EXPORTING
        type = lc_enq_type.

  ENDMETHOD.