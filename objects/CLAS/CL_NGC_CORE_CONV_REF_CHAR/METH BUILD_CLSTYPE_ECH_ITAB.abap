METHOD build_clstype_ech_itab.

  SELECT klart, obtab, aediezuord
    FROM tcla
    WHERE tcla~multobj = ' '
    INTO CORRESPONDING FIELDS OF TABLE @mt_clstype_ech.
  SELECT tclao~klart, tclao~obtab, tclao~aediezuord
    FROM tcla INNER JOIN tclao ON tcla~klart = tclao~klart "#EC CI_BUFFJOIN
    WHERE tcla~multobj = 'X'
    APPENDING CORRESPONDING FIELDS OF TABLE @mt_clstype_ech.
  SELECT tcla~klart, tcla~obtab, tcla~aediezuord
    FROM tcla LEFT OUTER JOIN tclao ON tcla~klart = tclao~klart AND tcla~obtab = tclao~obtab "#EC CI_BUFFJOIN
    WHERE tcla~multobj = 'X' AND tclao~obtab IS NULL
    APPENDING CORRESPONDING FIELDS OF TABLE @mt_clstype_ech.

ENDMETHOD.