  PROTECTED SECTION.

    DATA mv_appl_name TYPE if_shdb_pfw_def=>tv_pfw_appl_name .
    DATA mt_event_count TYPE ltt_event_count .
    DATA mt_object_check_names TYPE ltt_object_check_names .
    DATA mv_language TYPE sy-langu .
    DATA mv_lock TYPE boole_d .
    DATA mv_testmode TYPE boole_d .
    DATA ms_print_parameters TYPE pri_params .
    DATA mv_package_size TYPE i VALUE 20000 ##NO_TEXT.
    DATA mtr_objek TYPE ltr_objek .
    DATA mo_conv_util TYPE REF TO if_ngc_core_conv_util .
    DATA mo_conv_logger TYPE REF TO if_ngc_core_conv_logger .
    DATA mo_pfw_util TYPE REF TO if_ngc_core_conv_pfw_util.
    DATA mv_log2file TYPE boole_d .