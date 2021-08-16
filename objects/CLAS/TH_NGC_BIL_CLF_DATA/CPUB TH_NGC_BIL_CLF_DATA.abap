CLASS th_ngc_bil_clf_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  FOR TESTING .

  PUBLIC SECTION.

    CONSTANTS:
      BEGIN OF cs_class,
        cid                   TYPE abp_behv_cid VALUE 'CID_4',
        class                 TYPE klasse_d     VALUE 'AUCLFN_T04',
        classinternalid       TYPE clint        VALUE '0000000001',
        classtype             TYPE klassenart   VALUE 'AU1',
        classstatus           TYPE klstatus     VALUE 1,
        classgroup            TYPE klassengr    VALUE 'CLGRP',
        docnumber             TYPE doknr        VALUE '99999992989',
        documenttype          TYPE dokar        VALUE 'DRW',
        documentpart          TYPE doktl_d      VALUE '000',
        documentversion       TYPE dokvr        VALUE '00',
        classsearchauthgrp    TYPE bgrse        VALUE 'AAA',
        classmaintauthgrp     TYPE bgrkp        VALUE 'BBB',
        classclassfctnauthgrp TYPE bgrkl        VALUE 'CCC',
      END OF cs_class .

    CLASS-DATA gt_objectclass_read_multi_clfd TYPE ngct_classification_data .
    CLASS-DATA gt_objectclass_read_multi_obji TYPE ngct_clf_obj_int_id .
    CLASS-DATA gt_objectcharcval_val_data_sng TYPE ngct_valuation_data .
    CLASS-DATA gt_objectcharcval_val_data_mul TYPE ngct_valuation_data .
    CLASS-DATA gs_objectcharcval_charc_header TYPE ngcs_characteristic .
    CLASS-DATA gt_objectcharcval_charc_header TYPE ngct_characteristic .
    CLASS-DATA gt_objectclass_create_single   TYPE if_ngc_bil_clf=>ts_objclass-create-t_input .
    CLASS-DATA gt_objectcl_create_cls_by_obj  TYPE if_ngc_bil_clf=>ts_obj-create_by-_objectclass-t_input .
    CLASS-DATA gt_objectclass_create_multi    TYPE if_ngc_bil_clf=>ts_objclass-create-t_input .
    CLASS-DATA gt_objectclass_delete_single   TYPE if_ngc_bil_clf=>ts_objclass-delete-t_input .
    CLASS-DATA gt_objectclass_delete_multi    TYPE if_ngc_bil_clf=>ts_objclass-delete-t_input .
    CLASS-DATA gt_objectclass_read_multi_in   TYPE if_ngc_bil_clf=>ts_objclass-read-t_input .
    CLASS-DATA gt_objectclass_read_multi_out  TYPE if_ngc_bil_clf=>ts_objclass-read-t_result .
    CLASS-DATA gt_objectcharc_read_multi      TYPE if_ngc_bil_clf=>ts_objcharc-read-t_input .
    CLASS-DATA gt_objectcharc_read_by_object  TYPE if_ngc_bil_clf=>ts_obj-read_by-_objectcharc-t_input .
    CLASS-DATA gt_objectclass_readb_multi_in  TYPE if_ngc_bil_clf=>ts_obj-read_by-_objectclass-t_input .
    CLASS-DATA gt_objectclass_readb_multi_out TYPE if_ngc_bil_clf=>ts_obj-read_by-_objectclass-t_result .
    CLASS-DATA gt_objectclass_readb_multi_l   TYPE if_ngc_bil_clf=>ts_obj-read_by-_objectclass-t_link .
    CLASS-DATA gt_objectcharcval_create       TYPE if_ngc_bil_clf=>ts_objcharcval-create-t_input .
    CLASS-DATA gt_objectcharcval_update       TYPE if_ngc_bil_clf=>ts_objcharcval-update-t_input .
    CLASS-DATA gt_objectcharcval_cret_by_chr  TYPE if_ngc_bil_clf=>ts_objcharc-create_by-_objectcharcvalue-t_input .
    CLASS-DATA gt_objectcharcval_delete_singl TYPE if_ngc_bil_clf=>ts_objcharcval-delete-t_input .
    CLASS-DATA gt_objectcharcval_read         TYPE if_ngc_bil_clf=>ts_objcharcval-read-t_input .
    CLASS-DATA gt_objectcharcval_read_by_chr  TYPE if_ngc_bil_clf=>ts_objcharc-read_by-_objectcharcvalue-t_input .
    CLASS-DATA gt_objectcharcval_delete_multi TYPE if_ngc_bil_clf=>ts_objcharcval-delete-t_input .

  CLASS-METHODS class_constructor .