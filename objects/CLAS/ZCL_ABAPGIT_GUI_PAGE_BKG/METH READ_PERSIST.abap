  METHOD read_persist.

    DATA: lo_per TYPE REF TO zcl_abapgit_persist_background,
          lt_per TYPE zcl_abapgit_persist_background=>tt_background.


    CREATE OBJECT lo_per.
    lt_per = lo_per->list( ).

    READ TABLE lt_per INTO rs_persist WITH KEY key = io_repo->get_key( ).
    IF sy-subrc <> 0.
      CLEAR rs_persist.
    ENDIF.

  ENDMETHOD.