  PRIVATE SECTION.

    TYPES:
      lty_t_class_table TYPE STANDARD TABLE OF cl_ngc_bil_cls=>lty_clfn_class_cds-t_class WITH DEFAULT KEY .
    TYPES:
      lty_t_class_control_table TYPE STANDARD TABLE OF th_ngc_bil_cls_data=>lty_t_class_control WITH DEFAULT KEY .

    METHODS get_exporting_parameters
      EXPORTING
        !et_failed   TYPE if_ngc_bil_cls_c=>lty_clfnclassdesctp-t_failed
        !et_reported TYPE if_ngc_bil_cls_c=>lty_clfnclassdesctp-t_reported
        !et_mapped   TYPE if_ngc_bil_cls_c=>lty_clfnclassdesctp-t_mapped .