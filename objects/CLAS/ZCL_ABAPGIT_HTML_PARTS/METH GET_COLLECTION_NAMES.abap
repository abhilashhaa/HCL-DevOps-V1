  METHOD get_collection_names.

    FIELD-SYMBOLS <ls_coll> LIKE LINE OF mt_part_collections.
    LOOP AT mt_part_collections ASSIGNING <ls_coll>.
      APPEND <ls_coll>-name TO rt_list.
    ENDLOOP.

  ENDMETHOD.