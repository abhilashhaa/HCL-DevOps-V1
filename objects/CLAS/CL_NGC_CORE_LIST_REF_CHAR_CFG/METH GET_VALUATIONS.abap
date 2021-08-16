  METHOD get_valuations.

    SELECT
    FROM cabn INNER JOIN
         ausp  ON cabn~atinn = ausp~atinn INNER JOIN
         inob  ON ausp~objek = inob~cuobj INNER JOIN
         tcla  ON ausp~klart = tcla~klart
              AND inob~klart = tcla~klart
              AND inob~obtab = 'MARA' INNER JOIN
         tclao ON tcla~klart = tclao~klart
              AND tclao~zaehl <> '00'
              AND inob~obtab = tclao~obtab INNER JOIN
         mara  ON inob~objek = mara~matnr
              AND mara~kzkfg = 'X'
    FIELDS
      inob~obtab,
      inob~objek,
      'MA' && inob~objek AS objnr,
      inob~cuobj,
      ausp~atinn,
      ausp~atwrt,
      ausp~atflv,
      ausp~atflb,
      ausp~atcod
    WHERE cabn~lkenz = ' '
      AND cabn~atxac = ' '
      AND ( cabn~attab = 'MARA'
         OR cabn~attab = 'MAKT' )
      AND ausp~mafid = 'O'
      AND tcla~multobj = 'X'
      AND tcla~varklart = 'X'

    UNION ALL

    SELECT
    FROM cabn INNER JOIN
         cabnz ON cabn~atinn = cabnz~atinn INNER JOIN
         ausp  ON cabn~atinn = ausp~atinn INNER JOIN
         inob  ON ausp~objek = inob~cuobj INNER JOIN
         tcla  ON ausp~klart = tcla~klart
              AND inob~klart = tcla~klart
              AND inob~obtab = 'MARA' INNER JOIN
         tclao ON tcla~klart = tclao~klart
              AND tclao~zaehl <> '00'
              AND inob~obtab = tclao~obtab INNER JOIN
         mara  ON inob~objek = mara~matnr              "#EC CI_BUFFJOIN
              AND mara~kzkfg = 'X'
    FIELDS
      inob~obtab,
      inob~objek,
      'MA' && inob~objek AS objnr,
      inob~cuobj,
      ausp~atinn,
      ausp~atwrt,
      ausp~atflv,
      ausp~atflb,
      ausp~atcod
    WHERE cabn~lkenz = ' '
      AND cabn~atxac = 'X'
      AND ( cabnz~attab = 'MARA'
         OR cabnz~attab = 'MAKT' )
      AND ausp~mafid = 'O'
      AND tcla~multobj = 'X'
      AND tcla~varklart = 'X'

    INTO CORRESPONDING FIELDS OF TABLE @rt_valuations.

    SORT rt_valuations ASCENDING BY obtab objek cuobj atinn.
    DELETE ADJACENT DUPLICATES FROM rt_valuations COMPARING obtab objek cuobj atinn.

  ENDMETHOD.