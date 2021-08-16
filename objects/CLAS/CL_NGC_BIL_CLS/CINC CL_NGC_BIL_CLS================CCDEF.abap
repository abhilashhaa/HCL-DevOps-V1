*"* use this source file for any type of declarations (class
*"* definitions, interfaces or type declarations) you need for
*"* components in the private section
INTERFACE lif_ngc_db_access.
  METHODS get_characteristic
    IMPORTING
      iv_charcinternalid       TYPE atinn
    RETURNING
      VALUE(rv_characteristic) TYPE atnam.
  METHODS get_charcinternalid
    IMPORTING
      iv_characteristic         TYPE atnam
    RETURNING
      VALUE(rv_charcinternalid) TYPE atinn.
  METHODS single_class_by_ext_key
    IMPORTING
      iv_class        TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_class-class
      iv_classtype    TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_class-classtype
      iv_keydate      TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_class-keydate
    RETURNING
      VALUE(rs_class) TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_class.
  METHODS single_class_by_int_key
    IMPORTING
      iv_classinternalid TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_class-classinternalid
      iv_keydate         TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_class-keydate
    RETURNING
      VALUE(rs_class)    TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_class.
  METHODS single_classdesc_by_int_key
    IMPORTING
      iv_classinternalid  TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_classdesc-classinternalid
      iv_language         TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_classdesc-language
      iv_keydate          TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_class-keydate
    RETURNING
      VALUE(rs_classdesc) TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_classdesc.
  METHODS single_classkeyword_by_int_key
    IMPORTING
      is_classkeyword        TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_classkeyword
      iv_keydate             TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_class-keydate
    RETURNING
      VALUE(rs_classkeyword) TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_classkeyword.
  METHODS classdesc_by_int_key
    IMPORTING
      iv_classinternalid  TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_class-classinternalid
      iv_keydate          TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_class-keydate
    RETURNING
      VALUE(rt_classdesc) TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-t_classdesc.
  METHODS classtext_by_int_key
    IMPORTING
      iv_classinternalid  TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_class-classinternalid
      iv_keydate          TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_class-keydate
    RETURNING
      VALUE(rt_classtext) TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-t_classtext.
  METHODS classcharc_by_int_key
    IMPORTING
      iv_classinternalid   TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_class-classinternalid
      iv_keydate           TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_class-keydate
    RETURNING
      VALUE(rt_classcharc) TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-t_classcharc.
  METHODS charc_by_int_key
    IMPORTING
      it_charc_key    TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-t_charc_key
    RETURNING
      VALUE(rt_charc) TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-t_charc.
  METHODS classkeyword_by_int_key
    IMPORTING
      iv_classinternalid     TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_class-classinternalid
      iv_keydate             TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_class-keydate
    RETURNING
      VALUE(rt_classkeyword) TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-t_classkeyword.
  METHODS single_classtext_by_int_key
    IMPORTING
      is_classtext        TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_classtext
      iv_keydate          TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_class-keydate
    RETURNING
      VALUE(rs_classtext) TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_classtext.
  METHODS single_classcharc_by_int_key
    IMPORTING
      is_classcharc        TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_classcharc
      iv_keydate           TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_class-keydate
    RETURNING
      VALUE(rs_classcharc) TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_classcharc.
  METHODS delete_class
    IMPORTING
      iv_classinternalid type clint
      iv_class     TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_class-class OPTIONAL
      iv_classtype TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_class-classtype OPTIONAL
    EXPORTING
      et_message   TYPE bapirettab.
  METHODS delete_classtext
    IMPORTING
      iv_class     TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_class-class
      iv_classtype TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_class-classtype
      it_classtext TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-t_classtext
    EXPORTING
      et_message   TYPE bapirettab.
  METHODS create_class
    IMPORTING
      iv_class           TYPE klasse_d
      iv_classtype       TYPE klassenart
      iv_changenumber    TYPE aennr OPTIONAL
      is_classbasic      TYPE bapi1003_basic
      is_classdocument   TYPE bapi1003_docu OPTIONAL
      is_classadditional TYPE bapi1003_add OPTIONAL
      is_classstandard   TYPE bapi1003_stand OPTIONAL
      it_classkeyword    TYPE tt_bapi1003_catch
      it_classtext       TYPE tt_bapi1003_longtext
      it_classcharc      TYPE tt_bapi1003_charact
    EXPORTING
      et_message         TYPE bapirettab.
  METHODS change_class
    IMPORTING
      iv_class               TYPE klasse_d
      iv_classtype           TYPE klassenart
      iv_changenumber        TYPE aennr OPTIONAL
      is_classbasic          TYPE bapi1003_basic
      is_classbasic_new       TYPE bapi1003_basic
      is_classdocument       TYPE bapi1003_docu OPTIONAL
      is_classdocument_new   TYPE bapi1003_docu_new OPTIONAL
      is_classadditional     TYPE bapi1003_add OPTIONAL
      is_classadditional_new TYPE bapi1003_add_new OPTIONAL
      is_classstandard       TYPE bapi1003_stand OPTIONAL
      is_classstandardnew    TYPE bapi1003_stand_new OPTIONAL
      it_classkeyword        TYPE tt_bapi1003_catch
      it_classkeyword_new    TYPE tt_bapi1003_catch_new
      it_classtext           TYPE tt_bapi1003_longtext
      it_classtext_new       TYPE tt_bapi1003_longtext
      it_classcharc          TYPE tt_bapi1003_charact
      it_classcharc_new      TYPE tt_bapi1003_charact_new OPTIONAL
*      it_classtext_curr    TYPE tt_bapi1003_longtext OPTIONAL
*      it_classkeyword_curr TYPE tt_bapi1003_catch OPTIONAL
*      it_classcharc_new    TYPE tt_bapi1003_charact_new OPTIONAL
*      it_classtext_new     TYPE tt_bapi1003_longtext OPTIONAL
*      it_classkeyword_new  TYPE tt_bapi1003_catch_new OPTIONAL
    EXPORTING
      et_message             TYPE bapirettab.
  METHODS get_classintid_from_buffer
    IMPORTING
      iv_class                  TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_class-class
      iv_classtype              TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_class-classtype
    RETURNING
      VALUE(rs_classinternalid) TYPE clint.
  METHODS get_class_from_buffer
    IMPORTING
      iv_class        TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_class-class
      iv_classtype    TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_class-classtype
    RETURNING
      VALUE(rs_class) TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_class.
  METHODS get_classdesc_from_buffer
    IMPORTING
      is_classdesc        TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_classdesc
    RETURNING
      VALUE(rs_classdesc) TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_classdesc.
  METHODS get_classkeyword_from_buffer
    IMPORTING
      is_classkeyword        TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_classkeyword
    RETURNING
      VALUE(rs_classkeyword) TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_classkeyword.
  METHODS get_classtext_from_buffer
    IMPORTING
      is_classtext        TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_classtext
    RETURNING
      VALUE(rs_classtext) TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_classtext.
  METHODS get_classcharc_from_buffer
    IMPORTING
      is_classcharc        TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_classcharc
    RETURNING
      VALUE(rs_classcharc) TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_classcharc.
  METHODS classtext_id
    IMPORTING
      iv_classtype           TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-s_class-classtype
    RETURNING
      VALUE(rt_classtext_id) TYPE cl_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-t_classtext_id.
  DATA: mv_test TYPE i.
ENDINTERFACE.