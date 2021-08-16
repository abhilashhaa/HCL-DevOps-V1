private section.

  types:
    lty_t_class_table TYPE STANDARD TABLE OF cl_ngc_bil_cls=>lty_clfn_class_cds-t_class WITH DEFAULT KEY .
  types:
    lty_t_class_control_table TYPE STANDARD TABLE OF th_ngc_bil_cls_data=>lty_t_class_control WITH DEFAULT KEY .

  methods GET_EXPORTING_PARAMETERS
    exporting
      !ET_FAILED type IF_NGC_BIL_CLS_C=>LTY_CLFNCLASSKEYWORDTP-T_FAILED
      !ET_REPORTED type IF_NGC_BIL_CLS_C=>LTY_CLFNCLASSKEYWORDTP-T_REPORTED
      !ET_MAPPED type IF_NGC_BIL_CLS_C=>LTY_CLFNCLASSKEYWORDTP-T_MAPPED .