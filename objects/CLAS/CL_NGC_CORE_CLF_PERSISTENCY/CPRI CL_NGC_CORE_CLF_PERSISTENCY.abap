  PRIVATE SECTION.

    TYPES:
      BEGIN OF lty_s_class_of_classification .
    TYPES: class_key TYPE ngcs_core_class_key.
    TYPES: classification_key TYPE ngcs_core_classification_key.
    TYPES: END OF lty_s_class_of_classification .
    TYPES:
      lty_t_class_of_classification TYPE STANDARD TABLE OF lty_s_class_of_classification WITH NON-UNIQUE DEFAULT KEY .
    TYPES:
      lty_t_objectclass TYPE STANDARD TABLE OF lty_s_objectclass WITH NON-UNIQUE DEFAULT KEY .
    TYPES:
      BEGIN OF lty_s_kssk_changes .
          INCLUDE TYPE: ngcs_core_classification_key AS classification_key.
      TYPES: clfnobjectid         TYPE cuobn.
    TYPES: classtype            TYPE klassenart.
    TYPES: classinternalid      TYPE clint.
    TYPES: clfnstatus           TYPE clstatus.
    TYPES: mafid                TYPE klmaf.
    TYPES: timeintervalnumber   TYPE adzhl.
    TYPES: classpositionnumber  TYPE posnummer.
    TYPES: classisstandardclass TYPE stdclass.
    TYPES: bomisrecursive       TYPE rekri_cl.
    TYPES: changenumber         TYPE aennr.
    TYPES: validitystartdate    TYPE datuv.
    TYPES: ismarkedfordeletion  TYPE lkenz.
    TYPES: validityenddate      TYPE datub.
    TYPES: object_state         TYPE ngc_core_object_state.
    TYPES: END OF lty_s_kssk_changes .
    TYPES:
      lty_t_kssk_changes TYPE STANDARD TABLE OF lty_s_kssk_changes WITH NON-UNIQUE DEFAULT KEY .
    TYPES:
      BEGIN OF lty_s_inob_changes .
          INCLUDE TYPE: ngcs_core_classification_key AS classification_key.
      TYPES: clfnobjectinternalid TYPE cuobj.
    TYPES: classtype            TYPE klassenart.
    TYPES: clfnobjecttable      TYPE tabelle.
    TYPES: clfnobjectid         TYPE cuobn.
    TYPES: robtab               TYPE tabelle.
    TYPES: robjek               TYPE rcuobn.
    TYPES: clint                TYPE rclint.
    TYPES: statu                TYPE clstatus.
    TYPES: cucozhl              TYPE cucozhl.
    TYPES: parent               TYPE cuobj.
    TYPES: root                 TYPE cuobj.
    TYPES: experte              TYPE exprt.
    TYPES: matnr                TYPE matnr.
    TYPES: datuv                TYPE datuv.
    TYPES: techs                TYPE techs.
    TYPES: object_state         TYPE ngc_core_object_state.
    TYPES: END OF lty_s_inob_changes .
    TYPES:
      lty_t_inob_changes TYPE STANDARD TABLE OF lty_s_inob_changes WITH NON-UNIQUE DEFAULT KEY .
    TYPES:
      BEGIN OF lty_s_ausp_changes .
          INCLUDE TYPE: ngcs_core_classification_key AS classification_key.
      TYPES: clfnobjectid              TYPE cuobn.
    TYPES: charcinternalid           TYPE atinn.
    TYPES: charcvaluepositionnumber  TYPE wzaehl.
    TYPES: clfnobjecttype            TYPE klmaf.
    TYPES: classtype                 TYPE klassenart.
    TYPES: timeintervalnumber        TYPE adzhl.
    TYPES: charcvalue                TYPE atwrt.
    TYPES: charcfromnumericvalue     TYPE atflv.
    TYPES: charcfromnumericvalueunit TYPE msehi.
    TYPES: charctonumericvalue       TYPE atflb.
    TYPES: charctonumericvalueunit   TYPE msehi.
    TYPES: charcvaluedependency      TYPE atcod.
    TYPES: attlv                     TYPE attlv.
    TYPES: attlb                     TYPE attlb.
    TYPES: atprz                     TYPE atprz.
    TYPES: atinc                     TYPE atinc.
    TYPES: characteristicauthor      TYPE ataut.
    TYPES: changenumber              TYPE aennr.
    TYPES: validitystartdate         TYPE datuv.
    TYPES: ismarkedfordeletion       TYPE lkenz.
    TYPES: atimb                     TYPE atimb.
    TYPES: atzis                     TYPE atzis.
    TYPES: atsrt                     TYPE atsrt.
    TYPES: atvglart                  TYPE atvglart.
    TYPES: validityenddate           TYPE datub.
    TYPES: charcfromdecimalvalue     TYPE auspext_dec_from.
    TYPES: charctodecimalvalue       TYPE auspext_dec_to.
    TYPES: charcfromamount           TYPE auspext_curr_from.
    TYPES: charctoamount             TYPE auspext_curr_to.
    TYPES: currency                  TYPE waers_curc.
    TYPES: charcfromdate             TYPE auspext_date_from.
    TYPES: charctodate               TYPE auspext_date_to.
    TYPES: charcfromtime             TYPE auspext_time_from.
    TYPES: charctotime               TYPE auspext_time_to.
    TYPES: object_state              TYPE ngc_core_object_state.
    TYPES: END OF lty_s_ausp_changes .
    TYPES:
      lty_t_ausp_changes TYPE STANDARD TABLE OF lty_s_ausp_changes WITH NON-UNIQUE DEFAULT KEY .
    TYPES:
      BEGIN OF lty_s_material_exist .
    TYPES: matnr TYPE matnr.
    TYPES: exists TYPE boole_d.
    TYPES: END OF lty_s_material_exist .
    TYPES:
      lty_t_material_exist TYPE STANDARD TABLE OF lty_s_material_exist .
    TYPES:
      BEGIN OF lty_s_enqueue_log,
        enqmode TYPE enqmode,
        klart   TYPE klah-klart,
        class   TYPE klah-class,
        mafid   TYPE kssk-mafid,
        objek   TYPE kssk-objek,
      END OF lty_s_enqueue_log .
    TYPES:
      lty_t_enqueue_log TYPE SORTED TABLE OF lty_s_enqueue_log
        WITH UNIQUE KEY enqmode
                        klart
                        class
                        mafid
                        objek .
    TYPES:
      BEGIN OF lty_s_classtype_redun .
    TYPES: classtype TYPE klassenart.
    TYPES: clfnobjecttable TYPE tabelle.
    TYPES: charcredundantstorageisallowed TYPE redundanz.
    TYPES: END OF lty_s_classtype_redun .
    TYPES:
      lty_t_classtype_redun TYPE STANDARD TABLE OF lty_s_classtype_redun .

    DATA mt_loaded_data TYPE ngct_core_classification .
    DATA mo_util TYPE REF TO if_ngc_core_clf_util .
    DATA mo_db_update TYPE REF TO if_ngc_core_clf_db_update .
    DATA mo_locking TYPE REF TO if_ngc_core_clf_locking .
    DATA mt_classtypes TYPE ngct_core_class_type .
    DATA mt_classtypes_redun TYPE lty_t_classtype_redun .
    DATA mt_kssk_changes TYPE lty_t_kssk_changes .
    DATA mt_inob_changes TYPE lty_t_inob_changes .
    DATA mt_ausp_changes TYPE lty_t_ausp_changes .
    DATA mo_bte TYPE REF TO if_ngc_core_clf_bte .
    DATA mo_cls_persistency TYPE REF TO if_ngc_core_cls_persistency .
    DATA gc_obtab_mara TYPE tabelle VALUE 'MARA' ##NO_TEXT.
    DATA gc_obtab_marc TYPE tabelle VALUE 'MARC' ##NO_TEXT.
    DATA mt_classes TYPE ngct_core_class .
    DATA mt_inob_new TYPE lty_t_inob_changes .
    DATA mt_enqueue_log TYPE lty_t_enqueue_log .
    DATA:
      mt_enqueue_ecksskxe_log TYPE STANDARD TABLE OF cuobn .

    METHODS call_bte
      IMPORTING
        !it_kssk_insert_fm TYPE rmclkssk_tab
        !it_kssk_delete_fm TYPE lty_t_rmcldel
        !it_inob_insert_fm TYPE tt_inob
        !it_inob_delete_fm TYPE lty_t_rinob
        !it_ausp_fm        TYPE rmclausp_tab .
    METHODS fill_dispo_table
      IMPORTING
        !it_ausp_fm        TYPE rmclausp_tab
        !it_kssk_insert_fm TYPE rmclkssk_tab
      EXPORTING
        !et_clmdcp         TYPE lty_t_clmdcp .
    METHODS get_cuobj
      IMPORTING
        !is_classification_key TYPE ngcs_core_classification_key
        !is_classtype          TYPE ngcs_core_class_type
      EXPORTING
        !ev_cuobj              TYPE cuobj
        !ev_cuobj_is_new       TYPE boole_d .
    METHODS read_classtypes_int .
    METHODS map_cds_to_db
      IMPORTING
        !it_kssk_changes TYPE lty_t_kssk_changes
        !it_inob_changes TYPE lty_t_inob_changes
        !it_ausp_changes TYPE lty_t_ausp_changes
      EXPORTING
        !et_kssk_update  TYPE ngct_core_clf_kssk_upd
        !et_inob_update  TYPE ngct_core_clf_inob_upd
        !et_ausp_update  TYPE ngct_core_clf_ausp_upd .
    METHODS map_cds_to_fm
      IMPORTING
        !it_kssk_changes   TYPE lty_t_kssk_changes
        !it_inob_changes   TYPE lty_t_inob_changes
        !it_ausp_changes   TYPE lty_t_ausp_changes
      EXPORTING
        !et_kssk_insert_fm TYPE rmclkssk_tab
        !et_kssk_delete_fm TYPE lty_t_rmcldel
        !et_inob_insert_fm TYPE tt_inob
        !et_inob_delete_fm TYPE lty_t_rinob
        !et_ausp_fm        TYPE rmclausp_tab .
    METHODS lock
      IMPORTING
        !iv_classtype    TYPE klassenart
        !iv_class        TYPE klasse_d OPTIONAL
        !iv_clfnobjectid TYPE cuobn
        !iv_write        TYPE boole_d DEFAULT abap_false
      EXPORTING
        !es_message      TYPE ngcs_core_msg .
    METHODS unlock
      IMPORTING
        !iv_classtype    TYPE klassenart
        !iv_class        TYPE klasse_d
        !iv_clfnobjectid TYPE cuobn
        !iv_write        TYPE boole_d .
    METHODS unlock_all .
    METHODS write_classification_data
      IMPORTING
        !it_classification TYPE ngct_core_classification_upd
        !it_class          TYPE ngct_core_class
      EXPORTING
        !et_message        TYPE ngct_core_classification_msg .
    METHODS write_valuation_data
      IMPORTING
        !it_classification TYPE ngct_core_classification_upd
      EXPORTING
        !et_message        TYPE ngct_core_classification_msg .