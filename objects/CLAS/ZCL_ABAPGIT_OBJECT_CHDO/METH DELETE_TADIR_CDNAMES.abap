  METHOD delete_tadir_cdnames.

    DATA: lv_obj_name TYPE sobj_name.

    IF is_cdnames-repnamec IS NOT INITIAL.
      lv_obj_name = is_cdnames-repnamec.
      CALL FUNCTION 'TR_TADIR_INTERFACE'
        EXPORTING
          wi_delete_tadir_entry    = abap_true
          wi_tadir_pgmid           = 'R3TR'
          wi_tadir_object          = 'PROG'
          wi_tadir_obj_name        = lv_obj_name
        EXCEPTIONS
          tadir_entry_not_existing = 1
          OTHERS                   = 2.
      IF sy-subrc > 1.
        zcx_abapgit_exception=>raise( |Error from TR_TADIR_INTERFACE (subrc={ sy-subrc } ).| ).
      ENDIF.
    ENDIF.

    IF is_cdnames-repnamet IS NOT INITIAL.
      lv_obj_name = is_cdnames-repnamet.
      CALL FUNCTION 'TR_TADIR_INTERFACE'
        EXPORTING
          wi_delete_tadir_entry    = abap_true
          wi_tadir_pgmid           = 'R3TR'
          wi_tadir_object          = 'PROG'
          wi_tadir_obj_name        = lv_obj_name
        EXCEPTIONS
          tadir_entry_not_existing = 1
          OTHERS                   = 2.
      IF sy-subrc > 1.
        zcx_abapgit_exception=>raise( |Error from TR_TADIR_INTERFACE (subrc={ sy-subrc } ).| ).
      ENDIF.
    ENDIF.

    IF is_cdnames-repnamefix IS NOT INITIAL.
      lv_obj_name = is_cdnames-repnamefix.
      CALL FUNCTION 'TR_TADIR_INTERFACE'
        EXPORTING
          wi_delete_tadir_entry    = abap_true
          wi_tadir_pgmid           = 'R3TR'
          wi_tadir_object          = 'PROG'
          wi_tadir_obj_name        = lv_obj_name
        EXCEPTIONS
          tadir_entry_not_existing = 1
          OTHERS                   = 2.
      IF sy-subrc > 1.
        zcx_abapgit_exception=>raise( |Error from TR_TADIR_INTERFACE (subrc={ sy-subrc } ).| ).
      ENDIF.
    ENDIF.

    IF is_cdnames-repnamevar IS NOT INITIAL.
      lv_obj_name = is_cdnames-repnamevar.
      CALL FUNCTION 'TR_TADIR_INTERFACE'
        EXPORTING
          wi_delete_tadir_entry    = abap_true
          wi_tadir_pgmid           = 'R3TR'
          wi_tadir_object          = 'PROG'
          wi_tadir_obj_name        = lv_obj_name
        EXCEPTIONS
          tadir_entry_not_existing = 1
          OTHERS                   = 2.
      IF sy-subrc > 1.
        zcx_abapgit_exception=>raise( |Error from TR_TADIR_INTERFACE (subrc={ sy-subrc } ).| ).
      ENDIF.
    ENDIF.

    IF is_cdnames-fgrp IS NOT INITIAL.
      lv_obj_name = is_cdnames-fgrp.
      CALL FUNCTION 'TR_TADIR_INTERFACE'
        EXPORTING
          wi_delete_tadir_entry    = abap_true
          wi_tadir_pgmid           = 'R3TR'
          wi_tadir_object          = 'FUGR'
          wi_tadir_obj_name        = lv_obj_name
        EXCEPTIONS
          tadir_entry_not_existing = 1
          OTHERS                   = 2.
      IF sy-subrc > 1.
        zcx_abapgit_exception=>raise( |Error from TR_TADIR_INTERFACE (subrc={ sy-subrc } ).| ).
      ENDIF.
    ENDIF.

  ENDMETHOD.