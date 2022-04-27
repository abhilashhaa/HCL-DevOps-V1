*&---------------------------------------------------------------------*
*& Report  ZHCL_IMPACT_HANA_ARCH
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT zhcl_impact_hana_arch.

INCLUDE zhcl_impact_hana_arch_top.
INCLUDE zhcl_impact_hana_arch_forms.

INITIALIZATION.

  PERFORM f_get_config_data.

START-OF-SELECTION.
***Fill ALV data
  IF s_objnam IS NOT INITIAL.
    IF rb_prog IS NOT INITIAL.
      SELECT name FROM trdir
        INTO TABLE gi_trdir WHERE name IN s_objnam AND
                            dbapl <> 'S' AND
                            fixpt = 'X'.
    ELSEIF rb_fugr IS NOT INITIAL.
      SELECT area FROM tlibg
        INTO TABLE gi_trdir WHERE area IN s_objnam.
      IF sy-subrc = 0.
        SORT gi_trdir BY name.
        LOOP AT gi_trdir ASSIGNING <fs_trdir>.
          CONCATENATE 'SAPL' <fs_trdir>-name INTO <fs_trdir>-name.
        ENDLOOP.
        SELECT funcname pname include INTO TABLE gi_tfdir
          FROM tfdir
          FOR ALL ENTRIES IN gi_trdir
          WHERE pname = gi_trdir-name.
        IF sy-subrc = 0.
          LOOP AT gi_tfdir ASSIGNING <fs_tfdir>.
            gv_len = strlen( <fs_tfdir>-pname ).
            CONCATENATE <fs_tfdir>-pname+3(gv_len) 'U' <fs_tfdir>-include INTO <fs_tfdir>-inclname.
          ENDLOOP.
          gi_tfdir_tmp[] = gi_tfdir[].
          SORT gi_tfdir BY  inclname.
          SORT gi_tfdir_tmp BY funcname.
        ENDIF.
      ENDIF.
    ELSEIF rb_func IS NOT INITIAL.
      SELECT funcname pname include INTO TABLE gi_tfdir
         FROM tfdir WHERE funcname IN s_objnam.
      IF sy-subrc = 0.
        LOOP AT gi_tfdir ASSIGNING <fs_tfdir>.
          gv_len = strlen( <fs_tfdir>-pname ).
          CONCATENATE <fs_tfdir>-pname+3(gv_len) 'U' <fs_tfdir>-include INTO <fs_tfdir>-inclname.
          APPEND INITIAL LINE TO gi_trdir ASSIGNING <fs_trdir>.
          <fs_trdir>-name = <fs_tfdir>-inclname.
        ENDLOOP.
        gi_tfdir_tmp[] = gi_tfdir[].
        SORT gi_tfdir BY  inclname.
        SORT gi_tfdir_tmp BY funcname.
      ENDIF.
    ELSEIF rb_clas IS NOT INITIAL.
      SELECT clsname FROM seoclass
        INTO TABLE gi_class
        WHERE clsname IN s_objnam.
      IF sy-subrc = 0.
        LOOP AT gi_class INTO gs_class.
          CLEAR gi_cls_incl[].
          CALL FUNCTION 'SEO_CLASS_GET_METHOD_INCLUDES'
            EXPORTING
              clskey                       = gs_class
            IMPORTING
              includes                     = gi_cls_incl
            EXCEPTIONS
              _internal_class_not_existing = 1
              OTHERS                       = 2.
          IF gi_cls_incl IS NOT INITIAL.
            append LINES OF gi_cls_incl TO gi_cls_incl_tmp.
          ENDIF.
        ENDLOOP.
        IF gi_cls_incl_tmp IS NOT INITIAL.
          gi_cls_incl[] = gi_cls_incl_tmp[].
          SORT gi_cls_incl BY incname.
          SORT gi_cls_incl_tmp BY cpdkey-clsname cpdkey-cpdname.
          LOOP AT gi_cls_incl INTO gs_cls_incl.
            APPEND INITIAL LINE TO gi_trdir ASSIGNING <fs_trdir>.
            <fs_trdir>-name = gs_cls_incl-incname.
          ENDLOOP.
        ENDIF.
      ENDIF.
    ENDIF.
    IF gi_trdir IS NOT INITIAL.
      LOOP AT gi_trdir INTO gs_trdir.
        gv_prog = gs_trdir-name.
        PERFORM f_fill_alv_prog USING    gv_prog
                                         gi_keywords
                                CHANGING gi_final.
      ENDLOOP.
    ENDIF.
  ENDIF.


** ALV Display

  IF gi_final IS NOT INITIAL.
    SORT gi_final BY objtyp objnam.
    PERFORM f_display_alv.
  ELSE.
    MESSAGE 'No data found' TYPE 'I'.
  ENDIF.