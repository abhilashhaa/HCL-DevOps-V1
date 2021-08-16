METHOD if_ngc_drf_ewm_util~get_selected_classifications.

  CLEAR: et_clf_key.

  SELECT DISTINCT
    inob~obtab AS object_table,
    inob~klart AS klart,
    inob~cuobj AS objkey,
    inob~objek AS matnrwerkscharg
    FROM ( tcla INNER JOIN kssk ON tcla~klart = kssk~klart
                INNER JOIN inob ON kssk~objek = inob~cuobj
                INNER JOIN klah ON kssk~clint = klah~clint
                INNER JOIN ksml ON kssk~clint = ksml~clint
                INNER JOIN p_drfewmbatch ON substring( inob~objek, 1, 40 ) = p_drfewmbatch~matnr ##NUMBER_OK
                                       AND substring( inob~objek, 41, 10 ) = p_drfewmbatch~charg ) ##NUMBER_OK "#EC CI_BUFFJOIN
    WHERE tcla~multobj = 'X'
      AND tcla~klart IN @it_range_klart
      AND kssk~mafid = 'O'
      AND inob~obtab IN @it_range_obtab
      AND substring( inob~objek, 1, 40 ) IN @it_range_matnr
      AND klah~class IN @it_range_class
      AND ksml~ewm_rel = 'X'
      AND p_drfewmbatch~matnr IN @it_range_matnr
      AND p_drfewmbatch~lgnum IN @it_range_lgnum
      AND (iv_additional_where_cnd) "#EC CI_DYNWHERE
    INTO CORRESPONDING FIELDS OF TABLE @et_clf_key.
  LOOP AT et_clf_key ASSIGNING FIELD-SYMBOL(<es_clf_key>).
    " Filling the werks part with 4 spaces
    MOVE:
      <es_clf_key>-matnrwerkscharg+40(10) TO <es_clf_key>-matnrwerkscharg+44(10),
      `    `   TO <es_clf_key>-matnrwerkscharg+40(4).
  ENDLOOP.

ENDMETHOD.