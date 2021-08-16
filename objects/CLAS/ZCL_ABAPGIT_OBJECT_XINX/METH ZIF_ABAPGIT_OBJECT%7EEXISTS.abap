  METHOD zif_abapgit_object~exists.

    DATA: ls_dd12v TYPE dd12v.

    CALL FUNCTION 'DDIF_INDX_GET'
      EXPORTING
        name          = mv_name
        id            = mv_id
      IMPORTING
        dd12v_wa      = ls_dd12v
      EXCEPTIONS
        illegal_input = 1
        OTHERS        = 2.

    rv_bool = boolc( ls_dd12v IS NOT INITIAL ).

  ENDMETHOD.