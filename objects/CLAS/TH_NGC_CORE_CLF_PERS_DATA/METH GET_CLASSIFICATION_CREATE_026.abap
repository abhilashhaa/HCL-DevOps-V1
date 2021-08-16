  METHOD GET_CLASSIFICATION_CREATE_026.

    rt_classification_upd = VALUE #(
      ( object_key          = cv_object_key_01
        technical_object    = cv_object_table_mara
        key_date            = cv_keydate_2017
        classification_data = VALUE #(
          ( classinternalid     = cv_class_01_id
            clfnstatus          = '1'
            classpositionnumber = '0'
            object_state        = if_ngc_c=>gc_object_state-created ) ) )
      ( object_key          = cv_object_key_01
        technical_object    = cv_object_table_marat
        key_date            = cv_keydate_2017
        classification_data = VALUE #(
          ( classinternalid     = cv_class_02_id
            clfnstatus          = '1'
            classpositionnumber = '0'
            object_state        = if_ngc_c=>gc_object_state-created ) ) )
      ).

  ENDMETHOD.