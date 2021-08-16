private section.

  types:
    lty_t_charc_table TYPE STANDARD TABLE OF cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charc WITH DEFAULT KEY .
  types:
    lty_t_charc_control_table TYPE STANDARD TABLE OF th_ngc_bil_chr_data=>lty_t_charc_control WITH DEFAULT KEY .

  methods GET_EXPORTING_PARAMETERS
    exporting
      !ET_FAILED type IF_NGC_BIL_CHR_C=>LTY_CLFNCHARCVALTP-T_FAILED
      !ET_REPORTED type IF_NGC_BIL_CHR_C=>LTY_CLFNCHARCVALTP-T_REPORTED
      !ET_MAPPED type IF_NGC_BIL_CHR_C=>LTY_CLFNCHARCVALTP-T_MAPPED .