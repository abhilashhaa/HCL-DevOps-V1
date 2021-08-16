  PROTECTED SECTION.

    DATA mo_cls_bapi_util TYPE REF TO if_ngc_rap_cls_bapi_util .

    METHODS delete_class
      IMPORTING
        !iv_classinternalid TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_class-classinternalid .
    METHODS delete_class_desc
      IMPORTING
        !is_classdesc TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_classdesc .
    METHODS delete_class_keyword
      IMPORTING
        !is_classkeyword TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_classkeyword .
    METHODS delete_class_text
      IMPORTING
        !is_classtext TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_classtext .
    METHODS delete_class_charc
      IMPORTING
        !is_classcharc TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_classcharc .
    METHODS setup_class
      IMPORTING
        !is_class                 TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_class
        !it_classdesc             TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classdesc
        !it_classkeyword          TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classkeyword OPTIONAL
      RETURNING
        VALUE(rv_classinternalid) TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_class-classinternalid .
    METHODS update_class_desc
      IMPORTING
        !is_classdesc TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_classdesc .
    METHODS create_class_desc
      IMPORTING
        !it_classdesc TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classdesc OPTIONAL
        !is_class     TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_class OPTIONAL .
    METHODS update_class_keyword
      IMPORTING
        !is_classkeyword TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_classkeyword .
    METHODS create_class_keyword
      IMPORTING
        !it_classkeyword TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classkeyword OPTIONAL
        !is_class        TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_class OPTIONAL .
    METHODS update_class_text
      IMPORTING
        !is_classtext TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_classtext .
    METHODS create_class_text
      IMPORTING
        !it_classtext TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classtext OPTIONAL
        !is_class     TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_class OPTIONAL .
    METHODS update_class_charc
      IMPORTING
        !is_classcharc TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_classcharc .
    METHODS create_class_charc_in_batch
      IMPORTING
        !it_classcharc TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classcharc OPTIONAL
        !is_class      TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_class OPTIONAL .
    METHODS create_class_charc
      IMPORTING
        !it_classcharc TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classcharc OPTIONAL
        !is_class      TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_class OPTIONAL .
    METHODS update_class
      IMPORTING
        !is_class TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_class .
    METHODS create_class
      IMPORTING
        !it_classdesc             TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classdesc OPTIONAL
        !it_classkeyword          TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classkeyword OPTIONAL
        !it_classtext             TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classtext OPTIONAL
        !it_classcharc            TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classcharc OPTIONAL
        !is_class                 TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_class
      RETURNING
        VALUE(rv_classinternalid) TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_class-classinternalid .
    METHODS create_charc
      IMPORTING
        !is_charc TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_charc .

    METHODS get_service_name
        REDEFINITION .