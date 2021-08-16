  METHOD refresh.

    DATA: lt_list TYPE zif_abapgit_persistence=>tt_repo.

    FIELD-SYMBOLS: <ls_list> LIKE LINE OF lt_list.


    CLEAR mt_list.

    lt_list = zcl_abapgit_persist_factory=>get_repo( )->list( ).
    LOOP AT lt_list ASSIGNING <ls_list>.
      instantiate_and_add( <ls_list> ).
    ENDLOOP.

    mv_init = abap_true.

  ENDMETHOD.