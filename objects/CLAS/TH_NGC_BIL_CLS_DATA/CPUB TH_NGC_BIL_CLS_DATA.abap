class TH_NGC_BIL_CLS_DATA definition
  public
  final
  create public
  for testing .

public section.

  types:
    BEGIN OF lty_s_class_control.
        INCLUDE TYPE if_ngc_bil_cls_c=>lty_clfnclasstp-s_create-%control .
    TYPES: END OF lty_s_class_control .
  types:
    lty_t_class_control TYPE STANDARD TABLE OF lty_s_class_control WITH DEFAULT KEY .

  constants CV_KEYDATE_2017 type DATS value '20170101' ##NO_TEXT.
  constants:
    BEGIN OF cs_class_wo_classtype,
                 cid   TYPE abp_behv_cid VALUE 'CID_1',
                 class TYPE klasse_d VALUE 'AUCLFN_T10',
               END OF cs_class_wo_classtype .
  constants:
    BEGIN OF cs_class_wo_description,
                 cid       TYPE abp_behv_cid VALUE 'CID_2',
                 class     TYPE klasse_d VALUE 'AUCLFN_T02',
                 classtype TYPE klassenart VALUE 'AU1',
               END OF cs_class_wo_description .
  constants:
    BEGIN OF cs_class_existing,
                 cid             TYPE abp_behv_cid VALUE 'CID_3',
                 class           TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_class-class VALUE 'AUCLFN_T03',
                 classtype       TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_class-classtype VALUE 'AU1',
                 classinternalid TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-s_class-classinternalid VALUE '2000000001',
               END OF cs_class_existing .
  constants:
    BEGIN OF cs_class,
                 cid                   TYPE abp_behv_cid VALUE 'CID_4',
                 class                 TYPE klasse_d VALUE 'AUCLFN_T04',
                 classinternalid       TYPE clint VALUE '0000000001', "tempolary
                 classtype             TYPE klassenart VALUE 'AU1',
                 classstatus           TYPE klstatus VALUE 1,
                 classgroup            TYPE klassengr VALUE 'CLGRP',
                 docnumber             TYPE doknr VALUE '99999992989',
                 documenttype          TYPE dokar VALUE 'DRW',
                 documentpart          TYPE doktl_d VALUE '000',
                 documentversion       TYPE dokvr VALUE '00',
                 classsearchauthgrp    TYPE bgrse VALUE 'AAA',
                 classmaintauthgrp     TYPE bgrkp VALUE 'BBB',
                 classclassfctnauthgrp TYPE bgrkl VALUE 'CCC',
               END OF cs_class .
  constants:
    BEGIN OF cs_class_not_existing,
                 cid             TYPE abp_behv_cid VALUE 'CID_5',
                 class           TYPE klasse_d VALUE 'AUCLFN_T05',
                 classtype       TYPE klassenart VALUE 'AU1',
                 classinternalid TYPE clint VALUE '2000000005',
               END OF cs_class_not_existing .
  constants:
    BEGIN OF cs_class_update,
                 classstatus        TYPE klstatus VALUE 1,
                 classgroup         TYPE klassengr VALUE 'NEWGRP',
                 classsearchauthgrp TYPE bgrse VALUE 'JKL',
               END OF cs_class_update .
  constants:
    BEGIN OF cs_classcharc_existing,
                 cid                   TYPE abp_behv_cid VALUE 'CID_6',
                 charcinternalid       TYPE clint VALUE '1000000001',
                 charcissearchrelevant TYPE bgrse VALUE 'X',
                 characteristic        TYPE atnam VALUE 'AU_CHR3',
               END OF cs_classcharc_existing .
  constants:
    BEGIN OF cs_classcharc_restricted,
                 cid                   TYPE abp_behv_cid VALUE 'CID_7',
                 charcinternalid       TYPE clint VALUE '1000000003',
                 classtype_1           type klassenart VALUE 'AU2',
                 classtype_2           type klassenart VALUE 'AU3',
                 charcissearchrelevant TYPE bgrse VALUE 'X',
                 characteristic        TYPE atnam VALUE 'AU_CHR5',
               END OF cs_classcharc_restricted.
  constants:
    BEGIN OF cs_charc_existing,
                 cid             TYPE string VALUE 'CID_15',
                 charcinternalid TYPE atinn VALUE '1000000001',
                 characteristic  TYPE atnam VALUE 'AU_CHR1',
               END OF cs_charc_existing .
  constants:
    BEGIN OF cs_classcharc_new,
                 cid                  TYPE abp_behv_cid VALUE 'CID_7',
                 charcinternalid      TYPE clint VALUE '1000000002',
                 charcisprintrelevant TYPE bgrse VALUE 'X',
                 characteristic       TYPE atnam VALUE 'AU_CHR4',
               END OF cs_classcharc_new .
  constants:
    BEGIN OF cs_charc_new,
                 charcinternalid TYPE atinn VALUE '1000000002',
                 characteristic  TYPE atnam VALUE 'AU_CHR2',
               END OF cs_charc_new .
  constants:
    BEGIN OF cs_classkeyword_existing,
                 cid                        TYPE string VALUE 'CID_17',
                 language                   TYPE spras VALUE 'E',
                 classkeywordpositionnumber TYPE klapos VALUE '02',
                 classkeywordtext           TYPE klschl VALUE 'keyword 1' ##NO_TEXT,
               END OF cs_classkeyword_existing .
  constants:
    BEGIN OF cs_classkeyword_new_langu,
                 cid                        TYPE string VALUE 'CID_17',
                 language                   TYPE spras VALUE 'F',
                 classkeywordtext           TYPE klschl VALUE 'keyword FR' ##NO_TEXT,
               END OF cs_classkeyword_new_langu .
  constants:
    BEGIN OF cs_classkeyword_new,
                 language                   TYPE spras VALUE 'E',
                 cid                        TYPE string VALUE 'CID_11',
                 classkeywordpositionnumber TYPE klapos VALUE '04',
                 classkeywordtext           TYPE klschl VALUE 'keyword new' ##NO_TEXT,
               END OF cs_classkeyword_new .
  constants:
    BEGIN OF cs_classkeyword,
                 language_de                   TYPE spras VALUE 'D',
                 language_en                   TYPE spras VALUE 'E',
                 cid1                        TYPE string VALUE 'CID_11',
                 cid2                        TYPE string VALUE 'CID_12',
                 cid3                        TYPE string VALUE 'CID_13',
                 cid4                        TYPE string VALUE 'CID_14',
                 classkeywordpositionnumber1 TYPE klapos VALUE '03',
                 classkeywordpositionnumber2 TYPE klapos VALUE '04',
                 classkeywordpositionnumber3 TYPE klapos VALUE '05',
                 classkeywordpositionnumber4 TYPE klapos VALUE '06',
                 classkeywordtext1           TYPE klschl VALUE 'keyword 1 EN' ##NO_TEXT,
                 classkeywordtext2           TYPE klschl VALUE 'keyword 2 EN' ##NO_TEXT,
                 classkeywordtext3           TYPE klschl VALUE 'keyword 1 DE' ##NO_TEXT,
                 classkeywordtext4           TYPE klschl VALUE 'keyword 2 DE' ##NO_TEXT,
               END OF cs_classkeyword .
  constants:
    BEGIN OF cs_classdesc_existing,
                 cid              TYPE string VALUE 'CID_16',
                 language         TYPE spras  VALUE 'E',
                 classdescription TYPE klschl VALUE 'desc EN' ##NO_TEXT,
               END OF cs_classdesc_existing .
  constants:
    BEGIN OF cs_classdesc_new,
                 language         TYPE spras VALUE 'D',
                 classdescription TYPE klschl VALUE 'desc NEW DE' ##NO_TEXT,
                 cid              TYPE string VALUE 'CID_10',
               END OF cs_classdesc_new .
  constants:
    BEGIN OF cs_classdesc_delete,
                 language         TYPE spras VALUE 'F',
                 classdescription TYPE klschl VALUE 'desc FR' ##NO_TEXT,
               END OF cs_classdesc_delete .
  constants:
    BEGIN OF cs_classtext_existing,
                 cid              TYPE string VALUE 'CID_18',
                 language         TYPE spras  VALUE 'E',
                 longtextid_00    TYPE textid VALUE '0000',
                 classtext_00     TYPE txtbz  VALUE 'long desc EN' ##NO_TEXT,
                 longtextid_01    TYPE textid VALUE '0001',
                 classtext_01     TYPE txtbz  VALUE 'standard EN' ##NO_TEXT,
                 classtext_01_new TYPE txtbz  VALUE 'standard EN NEW' ##NO_TEXT,
               END OF cs_classtext_existing .
  constants:
    BEGIN OF cs_classtext_new,
                 cid        TYPE string VALUE 'CID_18',
                 language   TYPE spras VALUE 'D',
                 longtextid TYPE textid VALUE '0000',
                 classtext  TYPE txtbz VALUE 'long desc DE' ##NO_TEXT,
               END OF cs_classtext_new .
  constants:
    BEGIN OF cs_classtext_delete,
                 cid        TYPE string VALUE 'CID_19',
                 language   TYPE spras VALUE 'E',
                 longtextid TYPE textid VALUE '0001',
                 classtext  TYPE txtbz VALUE 'standard EN' ##NO_TEXT,
               END OF cs_classtext_delete .
  constants:
    BEGIN OF cs_classtext_id,
                 language    TYPE spras VALUE 'E',
                 textblock 	 TYPE tberid VALUE '00',
                 texttype_00 TYPE tartid VALUE '00',
                 texttype_01 TYPE tartid VALUE '01',
                 texttype_02 TYPE tartid VALUE '02',
               END OF cs_classtext_id .