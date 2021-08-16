  METHOD apply.

    DATA: lt_filter TYPE SORTED TABLE OF zif_abapgit_definitions=>ty_tadir
                      WITH NON-UNIQUE KEY object obj_name,
          lv_index  TYPE i.

    FIELD-SYMBOLS: <ls_tadir> LIKE LINE OF ct_tadir.

    filter_generated_tadir( CHANGING ct_tadir = ct_tadir ).

    IF lines( it_filter ) = 0.
      RETURN.
    ENDIF.

    lt_filter = it_filter.

* this is another loop at TADIR, but typically the filter is blank
    LOOP AT ct_tadir ASSIGNING <ls_tadir>.
      lv_index = sy-tabix.
      READ TABLE lt_filter TRANSPORTING NO FIELDS WITH KEY object = <ls_tadir>-object
                                                           obj_name = <ls_tadir>-obj_name
                                                  BINARY SEARCH.
      IF sy-subrc <> 0.
        DELETE ct_tadir INDEX lv_index.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.