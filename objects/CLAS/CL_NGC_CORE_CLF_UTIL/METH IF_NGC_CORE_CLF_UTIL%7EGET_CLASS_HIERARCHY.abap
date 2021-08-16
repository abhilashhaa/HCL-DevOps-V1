  METHOD if_ngc_core_clf_util~get_class_hierarchy.

    CLEAR: et_ghcl.

    CALL FUNCTION 'CLHI_STRUCTURE_CLASSES'
      EXPORTING
        i_klart             = iv_classtype
        i_class             = iv_class
*       I_CLINT             =
        i_bup               = abap_true
        i_tdwn              = abap_false
        i_batch             = abap_true
*       I_OBJECT            = ' '
*       I_OBJ_ID            = ' '
*       I_ENQUEUE           = ' '
*       I_GRAPHIC           = ' '
*       I_HEREDITABLE       = ' '
        i_including_text    = abap_false
        i_language          = sy-langu
        i_no_classification = abap_true
*       I_VIEW              = 'K'
*       I_DATE              = SY-DATUM
        i_change_number     = space
        i_no_objects        = abap_true
*       I_SORT_BY_CLASS     = 'X'
*       I_EXCLUDE_CLINT     =
*       I_CALLED_BY_CLASSIFY       = ' '
        i_structured_list   = abap_false
*       I_ONE_STEP          = ' '
      TABLES
        daten               = et_ghcl
*       INDEX               =
*       EXP_KLAH            =
      EXCEPTIONS
        class_not_valid     = 1
        classtype_not_valid = 2
        OTHERS              = 3.
    IF sy-subrc <> 0.
      CLEAR: et_ghcl.
    ENDIF.

  ENDMETHOD.