  METHOD if_ngc_core_cls_hier_dbaccess~get_direct_relations.
    TYPES: BEGIN OF ts_kssk_small,                       "begin 2699010
             mandt     TYPE mandt,
             objek(10) TYPE c,
             clint     TYPE kssk-clint,
             datuv     TYPE kssk-datuv,
             datub     TYPE kssk-datub,
             klart     TYPE kssk-klart,
             aennr     TYPE kssk-aennr,
           END OF ts_kssk_small.

    DATA: lt_kssk_small      TYPE TABLE OF ts_kssk_small,
          lt_relations       TYPE tt_kssk,
          lt_relations_fae   TYPE ngct_clhier_idx,
          lv_pack_size       TYPE i VALUE 100000,
          lv_pack_size_fae   TYPE i VALUE 2500,
          lv_tabix_from      TYPE sy-tabix,
          lv_tabix_to        TYPE sy-tabix,
          lv_tabix_max       TYPE sy-tabix.

    IF it_relations IS NOT INITIAL.

      lv_tabix_from = 1.
      lv_tabix_max  = lines( it_relations ).

      DO.

        lv_tabix_to = lv_tabix_from + lv_pack_size_fae  .
        REFRESH lt_relations_fae.
        APPEND LINES OF it_relations FROM lv_tabix_from TO lv_tabix_to TO lt_relations_fae .
        lv_tabix_from = lv_tabix_to + 1.

        CLEAR lt_relations.
        lt_relations = convert_kssk_from_idx( lt_relations_fae  ).

        SELECT objek clint datuv datub klart aennr FROM kssk
        PACKAGE SIZE lv_pack_size
        INTO CORRESPONDING FIELDS OF TABLE lt_kssk_small
      FOR ALL ENTRIES IN lt_relations
      WHERE
        ( objek = lt_relations-objek OR
          clint = lt_relations-clint ) AND
        mafid = 'K' AND
        lkenz = ' '.
          APPEND LINES OF lt_kssk_small TO rt_relations.
        ENDSELECT.
* sort inside DO, yes
        SORT rt_relations.
        DELETE ADJACENT DUPLICATES FROM rt_relations.
        IF lv_tabix_from > lv_tabix_max.
           EXIT.
        ENDIF.
      ENDDO.

    ENDIF.                            "end 2699010
  ENDMETHOD.