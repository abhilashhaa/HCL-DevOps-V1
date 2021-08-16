  METHOD filter_files_to_deserialize.

    DATA lt_objects LIKE rt_results.
    DATA lr_object  TYPE REF TO zif_abapgit_definitions=>ty_result.
    DATA ls_item    TYPE zif_abapgit_definitions=>ty_item.
    DATA lv_tabix   TYPE sy-tabix.

    rt_results = it_results.

    "preparation for object logging, sort all file entries by objects
    IF ii_log IS BOUND.
      lt_objects = rt_results.
      SORT lt_objects
        BY obj_type
           obj_name.
      DELETE ADJACENT DUPLICATES FROM lt_objects COMPARING obj_type obj_name.
      DELETE lt_objects WHERE obj_type IS INITIAL AND obj_name IS INITIAL.
    ENDIF.

    "ignore objects w/o changes
    DELETE rt_results WHERE match = abap_true.     " Full match
    "log objects w/o changes
    IF sy-subrc = 0 AND ii_log IS BOUND.
      SORT rt_results BY obj_type obj_name.
      LOOP AT lt_objects REFERENCE INTO lr_object.
        lv_tabix = sy-tabix.
        READ TABLE rt_results WITH KEY obj_type = lr_object->obj_type
                                       obj_name = lr_object->obj_name
                              BINARY SEARCH TRANSPORTING NO FIELDS.
        IF sy-subrc <> 0.
          "all parts of the objects have not changed
          ls_item-devclass = lr_object->package.
          ls_item-obj_type = lr_object->obj_type.
          ls_item-obj_name = lr_object->obj_name.
          ii_log->add_success(
            iv_msg  = |Object { ls_item-obj_name } (type { ls_item-obj_type }) not changed; no import required|
            is_item = ls_item ).
          "ignore object for further messages
          DELETE lt_objects INDEX lv_tabix.
        ENDIF.
      ENDLOOP.
    ENDIF.

    "ignore objects w/o object type
    DELETE rt_results WHERE obj_type IS INITIAL.
    "log objects w/o object type
    IF sy-subrc = 0 AND ii_log IS BOUND.
      LOOP AT lt_objects REFERENCE INTO lr_object WHERE obj_type IS INITIAL.
        CHECK lr_object->obj_name IS NOT INITIAL.
        ls_item-devclass = lr_object->package.
        ls_item-obj_type = lr_object->obj_type.
        ls_item-obj_name = lr_object->obj_name.
        ii_log->add_warning(
          iv_msg  = |Object type for { ls_item-obj_name } not defined - will be ignored by abapGit|
          is_item = ls_item ).
      ENDLOOP.
      DELETE lt_objects WHERE obj_type IS INITIAL.
    ENDIF.

    "ignore objects that exists only local
    DELETE rt_results WHERE lstate = zif_abapgit_definitions=>c_state-added AND rstate IS INITIAL.
    "log objects that exists only local
    IF sy-subrc = 0 AND ii_log IS BOUND.
      SORT rt_results BY obj_type obj_name.
      LOOP AT lt_objects REFERENCE INTO lr_object.
        lv_tabix = sy-tabix.
        READ TABLE rt_results WITH KEY obj_type = lr_object->obj_type
                                       obj_name = lr_object->obj_name
                              BINARY SEARCH TRANSPORTING NO FIELDS.
        IF sy-subrc <> 0.
          "all parts exists only local
          "no log message; ignore object for further messages
          DELETE lt_objects INDEX lv_tabix.
        ENDIF.
      ENDLOOP.
    ENDIF.

    SORT rt_results
      BY obj_type ASCENDING
         obj_name ASCENDING
         rstate   DESCENDING  " ensures that non-empty rstate is kept
         lstate   DESCENDING. " ensures that non-empty lstate is kept
    DELETE ADJACENT DUPLICATES FROM rt_results COMPARING obj_type obj_name.

  ENDMETHOD.