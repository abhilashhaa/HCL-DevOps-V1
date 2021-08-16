  METHOD zif_abapgit_object~exists.

    DATA: lv_count TYPE i.

    SELECT SINGLE COUNT( * ) FROM dokil INTO lv_count
           WHERE id   = c_id
           AND object = mv_doc_object.                  "#EC CI_GENBUFF

    rv_bool = boolc( lv_count > 0 ).

  ENDMETHOD.