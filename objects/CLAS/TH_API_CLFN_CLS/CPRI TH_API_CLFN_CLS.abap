  PRIVATE SECTION.

    TYPES:
      lty_t_fieldname TYPE STANDARD TABLE OF fieldname .

    METHODS get_body_class
      IMPORTING
        !is_class                  TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_class OPTIONAL
        !it_class_fieldname        TYPE lty_t_fieldname OPTIONAL
        !it_classdesc              TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classdesc OPTIONAL
        !it_classdesc_fieldname    TYPE lty_t_fieldname OPTIONAL
        !it_classkeyword           TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classkeyword OPTIONAL
        !it_classkeyword_fieldname TYPE lty_t_fieldname OPTIONAL
        !it_classtext              TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classtext OPTIONAL
        !it_classtext_fieldname    TYPE lty_t_fieldname OPTIONAL
        !it_classcharc             TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classcharc OPTIONAL
        !it_classcharc_fieldname   TYPE lty_t_fieldname OPTIONAL
      RETURNING
        VALUE(rv_body)             TYPE string .
    METHODS get_body
      IMPORTING
        !it_classkeyword TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classkeyword OPTIONAL
        !it_classdesc    TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classdesc OPTIONAL
        !it_classtext    TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classtext OPTIONAL
        !it_classcharc   TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classcharc OPTIONAL
        !it_fieldname    TYPE lty_t_fieldname
      RETURNING
        VALUE(rv_body)   TYPE string .
    METHODS get_attribtue_value_from_xml
      IMPORTING
        !iv_xml            TYPE string
        !iv_attribute_name TYPE string
      RETURNING
        VALUE(rv_value)    TYPE string .