  METHOD pre_check.

    CONSTANTS:
      lc_act_delete TYPE activ_auth VALUE '06'.

    DATA:
      lv_act_head            TYPE activ_auth,
      lv_dummy               TYPE string,
      lo_suso                TYPE REF TO object,
      lv_failed              TYPE abap_bool,
      lv_suso_collect_in_cts TYPE i,
      ls_clskey              TYPE seoclskey.

    " Downport: CL_SUSO_GEN doesn't exist in 702
    ls_clskey-clsname = |CL_SUSO_GEN|.

    CALL FUNCTION 'SEO_CLASS_EXISTENCE_CHECK'
      EXPORTING
        clskey        = ls_clskey
      EXCEPTIONS
        not_specified = 1
        not_existing  = 2
        is_interface  = 3
        no_text       = 4
        inconsistent  = 5
        OTHERS        = 6.

    IF sy-subrc = 0.

      " so these check are not executed in 702

      CREATE OBJECT lo_suso
        TYPE
          ('CL_SUSO_GEN').

      CALL METHOD lo_suso->('SUSO_LOAD_FROM_DB')
        EXPORTING
          id_object = mv_objectname
        RECEIVING
          ed_failed = lv_failed.

      IF lv_failed = abap_true.
        " Object & does not exist; choose an existing object
        MESSAGE s111(01) WITH mv_objectname INTO lv_dummy.
        zcx_abapgit_exception=>raise_t100( ).
      ENDIF.

      CALL METHOD lo_suso->('GET_SUSO_EDIT_MODE')
        EXPORTING
          id_object     = mv_objectname
          id_planed_act = lc_act_delete
        IMPORTING
          ed_mode_head  = lv_act_head.

      IF lv_act_head <> lc_act_delete.
        zcx_abapgit_exception=>raise( |SUSO { mv_objectname }: Delete not allowed. Check where-used in SU21| ).
      ENDIF.

      CALL METHOD lo_suso->('SUSO_COLLECT_IN_CTS')
        EXPORTING
          id_object = mv_objectname
        RECEIVING
          ed_result = lv_suso_collect_in_cts.

      IF lv_suso_collect_in_cts IS NOT INITIAL.
        zcx_abapgit_exception=>raise( |SUSO { mv_objectname }: Cannot delete| ).
      ENDIF.

    ENDIF.

  ENDMETHOD.