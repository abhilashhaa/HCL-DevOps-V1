  METHOD modify_class_data.

    DATA(ls_class_data) = is_class_data.

    INSERT LINES OF ls_class_data-t_classdesc INTO ls_class_data-t_classkeyword INDEX 1.
    INSERT LINES OF ls_class_data-t_classdesc_new INTO ls_class_data-t_classkeyword_new INDEX 1.

    IF iv_deep_insert = abap_true.
      rt_return = mo_ngc_db_access->create_class_api(
        iv_class            = ls_class_data-class
        iv_classtype        = ls_class_data-classtype
        is_classbasic       = ls_class_data-s_classbasic_new
        it_classcharc       = CORRESPONDING #( ls_class_data-t_classcharc_new )
        it_classkeyword     = CORRESPONDING #( ls_class_data-t_classkeyword_new )
        it_classtext        = ls_class_data-t_classtext_new ).
    ELSE.
      rt_return = mo_ngc_db_access->change_class_api(
        EXPORTING
          iv_class            = ls_class_data-class
          iv_classtype        = ls_class_data-classtype
          is_classbasic       = CORRESPONDING #( ls_class_data-s_classbasic )
          is_classbasic_new   = ls_class_data-s_classbasic_new
          it_classcharc       = CORRESPONDING #( ls_class_data-t_classcharc )
          it_classcharc_new   = CORRESPONDING #( ls_class_data-t_classcharc_new )
          it_classkeyword     = CORRESPONDING #( ls_class_data-t_classkeyword )
          it_classkeyword_new = CORRESPONDING #( ls_class_data-t_classkeyword_new )
          it_classtext        = ls_class_data-t_classtext
          it_classtext_new    = ls_class_data-t_classtext_new ).
    ENDIF.

    IF iv_clear_buffer = abap_true.
      mo_ngc_db_access->clear_bapi_buffer( ).
    ENDIF.

  ENDMETHOD.