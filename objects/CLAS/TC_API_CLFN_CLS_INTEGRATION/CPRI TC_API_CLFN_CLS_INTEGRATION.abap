private section.

  constants:
    BEGIN OF cs_class_cre,
      class     TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_class-class VALUE 'AUCLFN_CLS0',"create class
      classtype TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_class-classtype VALUE '001',
    END OF cs_class_cre .
  constants:
    BEGIN OF cs_class_del,
      class     TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_class-class VALUE 'AUCLFN_CLS1',"create class
      classtype TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_class-classtype VALUE '001',
    END OF cs_class_del .
  constants:
    BEGIN OF cs_class_single,
      class     TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_class-class VALUE 'AUCLFN_CLS2',"create class
      classtype TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_class-classtype VALUE '001',
    END OF cs_class_single .
  constants:
    BEGIN OF cs_charc,
      characteristic_0 TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_charc-characteristic VALUE 'AUCLFN_CHR0',
      characteristic_1 TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_charc-characteristic VALUE 'AUCLFN_CHR1',
      charcdatatype  TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_charc-charcdatatype VALUE 'CHAR',
      charclength    TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_charc-charclength VALUE 2,
    END OF cs_charc .

  methods TEARDOWN .