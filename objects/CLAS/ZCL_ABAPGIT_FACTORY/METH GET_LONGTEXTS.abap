  METHOD get_longtexts.

    IF gi_longtext IS NOT BOUND.
      CREATE OBJECT gi_longtext TYPE zcl_abapgit_longtexts.
    ENDIF.
    ri_longtexts = gi_longtext.

  ENDMETHOD.