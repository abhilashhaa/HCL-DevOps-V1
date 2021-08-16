  METHOD if_ngc_drf_util~get_classification_data.

    TYPES:
      BEGIN OF lts_clfmas_object_key_cuobj,
        object_table TYPE tabelle,
        klart        TYPE klassenart,
        objkey       TYPE cuobj,
      END OF lts_clfmas_object_key_cuobj.

    DATA:
      lt_tcla              TYPE tt_tcla,
      lt_singleobj_bo_keys TYPE ngct_drf_clfmas_object_key,
      lt_multobj_bo_keys   TYPE STANDARD TABLE OF lts_clfmas_object_key_cuobj.

    CLEAR: et_inob_classification, et_kssk_classification, et_ausp_classification.

    SELECT * FROM tcla INTO TABLE lt_tcla.

    LOOP AT it_bo_keys ASSIGNING FIELD-SYMBOL(<is_bo_key>).
      READ TABLE lt_tcla ASSIGNING FIELD-SYMBOL(<ls_tcla>) WITH KEY klart = <is_bo_key>-klart.
      IF sy-subrc = 0. " No corresponding TCLA entry? -> DB inconsistency! -> Skip this line.
        IF <ls_tcla>-multobj = ' '. " Single object case
          APPEND <is_bo_key> TO lt_singleobj_bo_keys.
        ELSE. " Multi object case
          APPEND <is_bo_key> TO lt_multobj_bo_keys.
        ENDIF.
      ENDIF.
    ENDLOOP.

    IF lines( lt_singleobj_bo_keys ) > 0.
      " KSSK~MAFID?
      SELECT *
        FROM kssk
        FOR ALL ENTRIES IN @lt_singleobj_bo_keys
        WHERE klart = @lt_singleobj_bo_keys-klart AND objek = @lt_singleobj_bo_keys-objkey
        APPENDING TABLE @et_kssk_classification.

      " AUSP~MAFID?
      SELECT *
        FROM ausp
        FOR ALL ENTRIES IN @lt_singleobj_bo_keys
        WHERE klart = @lt_singleobj_bo_keys-klart AND objek = @lt_singleobj_bo_keys-objkey
        APPENDING TABLE @et_ausp_classification.
    ENDIF.

    IF lines( lt_multobj_bo_keys ) > 0.
      SELECT *
        FROM inob
        FOR ALL ENTRIES IN @lt_multobj_bo_keys
        WHERE inob~klart = @lt_multobj_bo_keys-klart AND inob~obtab = @lt_multobj_bo_keys-object_table AND inob~cuobj = @lt_multobj_bo_keys-objkey
        APPENDING TABLE @et_inob_classification.

      " Here we filter out incosistent kssk entries, which do not have a corresponding inob entry
      " KSSK~MAFID?
      SELECT kssk~*
        FROM ( kssk INNER JOIN inob ON kssk~klart = inob~klart AND kssk~objek = inob~cuobj )
        FOR ALL ENTRIES IN @lt_multobj_bo_keys
        WHERE inob~klart = @lt_multobj_bo_keys-klart AND inob~obtab = @lt_multobj_bo_keys-object_table AND inob~cuobj = @lt_multobj_bo_keys-objkey
        APPENDING CORRESPONDING FIELDS OF TABLE @et_kssk_classification.

      " At this point, we assume a consistent DB, so every ausp row should have a corresponding row in kssk
      " But we filter out incosistent ausp entries, which do not have a corresponding inob entry
      " AUSP~MAFID?
      SELECT ausp~*
        FROM ( ausp INNER JOIN inob ON ausp~klart = inob~klart AND ausp~objek = inob~cuobj )
        FOR ALL ENTRIES IN @lt_multobj_bo_keys
        WHERE inob~klart = @lt_multobj_bo_keys-klart AND inob~obtab = @lt_multobj_bo_keys-object_table AND inob~cuobj = @lt_multobj_bo_keys-objkey
        APPENDING CORRESPONDING FIELDS OF TABLE @et_ausp_classification.
    ENDIF.

  ENDMETHOD.