METHOD if_ngc_drf_ewm_util~apo_irrelevant_tcme.

  DATA:
    lt_r_klart TYPE if_cif_enhance_batch_char=>ty_r_klart,
    ls_klart   TYPE if_cif_enhance_batch_char=>ty_sr_klart.

  IF lt_r_klart[] IS INITIAL.
    ls_klart-sign   = 'I'.
    ls_klart-option = 'EQ'.
    ls_klart-low = '001'.
    COLLECT ls_klart INTO lt_r_klart.
    ls_klart-low = '230'.
    COLLECT ls_klart INTO lt_r_klart.
    ls_klart-low = '300'.
    COLLECT ls_klart INTO lt_r_klart.
  ENDIF.
  DELETE ct_tcme WHERE klart NOT IN lt_r_klart[].

ENDMETHOD.