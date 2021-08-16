  METHOD zif_abapgit_object~is_locked.

    DATA: lv_object TYPE seqg3-garg.

    " example lock entry
    "'001FORM      ZTEST_SAPSCRIPT                                                       TXT'
    lv_object = |{ sy-mandt }{ ms_item-obj_type }      { ms_item-obj_name }|.
    OVERLAY lv_object WITH '                                                                                   '.
    lv_object = lv_object && '*'.

    rv_is_locked = exists_a_lock_entry_for( iv_lock_object = 'ESSFORM'
                                            iv_argument    = lv_object ).


  ENDMETHOD.