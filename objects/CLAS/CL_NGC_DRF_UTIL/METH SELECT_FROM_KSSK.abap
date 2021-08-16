METHOD select_from_kssk.

  DATA:
    lv_key_date TYPE syst_datum.

  CLEAR: et_classification.

  lv_key_date = sy-datum.

  LOOP AT it_tcla ASSIGNING FIELD-SYMBOL(<ls_tcla>).

    TEST-SEAM select_kssk.
      IF iv_where = abap_true.

        IF <ls_tcla>-multobj IS INITIAL.
          SELECT DISTINCT kssk~objek kssk~klart kssk~mafid MAX( kssk~datuv ) tcla~obtab "#EC CI_BUFFJOIN
            APPENDING TABLE et_classification
            FROM ( kssk JOIN klah ON kssk~clint EQ klah~clint )
                  JOIN tcla ON klah~klart EQ tcla~klart
            WHERE klah~klart EQ <ls_tcla>-klart
            AND   kssk~datuv LE lv_key_date
            AND   kssk~mafid EQ if_ngc_drf_c=>gc_classification_type_object
            AND   (it_where)
            GROUP BY kssk~objek kssk~klart kssk~mafid tcla~obtab. "#EC CI_DYNWHERE
*          " OBTAB will be empty when we use class hierarchies
*          SELECT DISTINCT kssk~objek kssk~klart kssk~mafid MAX( kssk~datuv )
*            APPENDING TABLE et_classification
*            FROM kssk JOIN klah ON kssk~clint EQ klah~clint
*            WHERE klah~klart EQ <ls_tcla>-klart
*            AND   kssk~datuv LE lv_key_date
*            AND   kssk~mafid EQ if_ngc_drf_c=>gc_classification_type_class
*            AND   (it_where)
*            GROUP BY kssk~objek kssk~klart kssk~mafid ##TOO_MANY_ITAB_FIELDS. "#EC CI_DYNWHERE.
        ELSE.
          SELECT kssk~objek kssk~klart kssk~mafid MAX( kssk~datuv ) inob~obtab
            APPENDING TABLE et_classification
            FROM  ( kssk JOIN klah ON kssk~clint EQ klah~clint )
                  JOIN inob ON kssk~objek EQ inob~cuobj
            WHERE inob~klart  EQ <ls_tcla>-klart
            AND   inob~robtab EQ space
            AND   klah~klart  EQ <ls_tcla>-klart
            AND   kssk~datuv  LE lv_key_date
            AND   (it_where)
            GROUP BY kssk~objek kssk~klart kssk~mafid inob~obtab. "#EC CI_DYNWHERE.
*          " OBTAB will be empty when we use class hierarchies
*          SELECT kssk~objek kssk~klart kssk~mafid MAX( kssk~datuv )
*            APPENDING TABLE et_classification
*            FROM  kssk JOIN klah ON kssk~clint EQ klah~clint
*            WHERE klah~klart EQ <ls_tcla>-klart
*            AND   kssk~datuv LE lv_key_date
*            AND   kssk~mafid EQ if_ngc_drf_c=>gc_classification_type_class
*            AND   (it_where)
*            GROUP BY kssk~objek kssk~klart kssk~mafid ##TOO_MANY_ITAB_FIELDS. "#EC CI_DYNWHERE.
        ENDIF.

      ELSE.

        IF <ls_tcla>-multobj IS INITIAL.
          SELECT DISTINCT kssk~objek kssk~klart kssk~mafid MAX( kssk~datuv ) tcla~obtab
            APPENDING TABLE et_classification
            FROM ( kssk JOIN klah ON kssk~clint EQ klah~clint )
                  JOIN tcla ON klah~klart EQ tcla~klart
            WHERE klah~klart EQ <ls_tcla>-klart
            AND   kssk~datuv LE lv_key_date
            AND   kssk~mafid EQ if_ngc_drf_c=>gc_classification_type_object
            GROUP BY kssk~objek kssk~klart kssk~mafid tcla~obtab. "#EC CI_BUFFJOIN
*          " OBTAB will be empty when we use class hierarchies
*          SELECT DISTINCT kssk~objek kssk~klart kssk~mafid MAX( kssk~datuv )
*            APPENDING TABLE et_classification
*            FROM kssk JOIN klah ON kssk~clint EQ klah~clint
*            WHERE klah~klart EQ <ls_tcla>-klart
*            AND   kssk~datuv LE lv_key_date
*            AND   kssk~mafid EQ if_ngc_drf_c=>gc_classification_type_class
*            GROUP BY kssk~objek kssk~klart kssk~mafid ##TOO_MANY_ITAB_FIELDS.
        ELSE.
          SELECT kssk~objek kssk~klart kssk~mafid MAX( kssk~datuv ) inob~obtab
            APPENDING TABLE et_classification
            FROM  ( kssk JOIN klah ON kssk~clint EQ klah~clint )
                  JOIN inob ON kssk~objek EQ inob~cuobj
            WHERE inob~klart  EQ <ls_tcla>-klart
            AND   inob~robtab EQ space
            AND   klah~klart  EQ <ls_tcla>-klart
            AND   kssk~datuv  LE lv_key_date
            GROUP BY kssk~objek kssk~klart kssk~mafid inob~obtab.
*          " OBTAB will be empty when we use class hierarchies
*          SELECT kssk~objek kssk~klart kssk~mafid MAX( kssk~datuv )
*            APPENDING TABLE et_classification
*            FROM  kssk JOIN klah ON kssk~clint EQ klah~clint
*            WHERE klah~klart EQ <ls_tcla>-klart
*            AND   kssk~datuv LE lv_key_date
*            AND   kssk~mafid EQ if_ngc_drf_c=>gc_classification_type_class
*            GROUP BY kssk~objek kssk~klart kssk~mafid ##TOO_MANY_ITAB_FIELDS.
        ENDIF.

      ENDIF.
    END-TEST-SEAM.

  ENDLOOP.

ENDMETHOD.