  METHOD zif_abapgit_object~deserialize.

    DATA: ls_scp1 TYPE ty_scp1.


    io_xml->read(
      EXPORTING iv_name = 'SCP1'
      CHANGING  cg_data = ls_scp1 ).

    adjust_inbound( CHANGING cs_scp1 = ls_scp1 ).

    IF ls_scp1-scprattr-type = 'TMP'.
      save_hier( ls_scp1 ).
    ELSE.
      save( ls_scp1 ).
    ENDIF.

    dequeue( ).

    tadir_insert( iv_package ).

  ENDMETHOD.