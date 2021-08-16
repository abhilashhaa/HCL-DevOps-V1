protected section.

  methods CONVERT_IDX_FROM_KSSK
    importing
      !IT_RELATIONS type TT_KSSK
    returning
      value(RT_RELATIONS) type NGCT_CLHIER_IDX .
  methods CONVERT_KSSK_FROM_IDX
    importing
      !IT_RELATIONS type NGCT_CLHIER_IDX
    returning
      value(RT_RELATIONS) type TT_KSSK .