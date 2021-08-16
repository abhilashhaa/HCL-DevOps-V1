  METHOD zif_abapgit_object~exists.

    DATA: ls_tadir TYPE zif_abapgit_definitions=>ty_tadir,
          ls_key   TYPE ty_sicf_key.

    ls_tadir = read_tadir_sicf( ms_item-obj_name ).

    rv_bool = boolc( NOT ls_tadir IS INITIAL ).

    IF rv_bool = abap_true.
      ls_key = ls_tadir-obj_name.
      SELECT SINGLE icfaltnme FROM icfservice INTO ls_key-icf_name
        WHERE icf_name = ls_key-icf_name
        AND icfparguid = ls_key-icfparguid.
      rv_bool = boolc( sy-subrc = 0 ).
    ENDIF.

  ENDMETHOD.