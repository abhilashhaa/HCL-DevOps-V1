  METHOD constructor.

    DATA:
      ls_classification_data_upd TYPE ngcs_classification_data_upd,
      ls_valuation_data_upd      TYPE ngcs_valuation_data_upd.

    mo_ngc_util               = cl_ngc_core_util=>get_instance( ).
    ms_classification_key     = is_classification_key.
    mo_clf_persistency        = cl_ngc_core_factory=>get_clf_persistency( ).
    mo_chr_persistency        = cl_ngc_core_factory=>get_chr_persistency( ).
    mo_cls_persistency        = cl_ngc_core_factory=>get_cls_persistency( ).
    mo_clf_validation_manager = cl_ngc_clf_validation_mgr=>get_instance( ).
    mo_clf_util_intersect     = NEW cl_ngc_clf_util_intersect( ).
    mo_core_util_intersect    = cl_ngc_core_cls_util_intersect=>get_instance( ).
    mo_ngc_api_factory        = io_ngc_api_factory.
    mo_clf_status             = cl_ngc_clf_status=>get_instance( ).
    mo_clf_util_valuation     = cl_ngc_clf_util_valuation_ext=>get_instance( ).

    LOOP AT it_classification_data ASSIGNING FIELD-SYMBOL(<ls_classification_data>).
      MOVE-CORRESPONDING <ls_classification_data> TO ls_classification_data_upd.
      ls_classification_data_upd-object_state = if_ngc_c=>gc_object_state-loaded.
      INSERT ls_classification_data_upd INTO TABLE mt_classification_data.
    ENDLOOP.

    LOOP AT it_assigned_classes ASSIGNING FIELD-SYMBOL(<ls_assigned_classes>).
      APPEND INITIAL LINE TO mt_assigned_class ASSIGNING FIELD-SYMBOL(<ls_assigned_classes_upd>).
      MOVE-CORRESPONDING <ls_assigned_classes> TO <ls_assigned_classes_upd>.
      <ls_assigned_classes_upd>-object_state = if_ngc_c=>gc_object_state-loaded.
    ENDLOOP.

    " use hash table for valuation data
*    CLEAR: mv_valuation_hash_table.

    LOOP AT it_valuation_data ASSIGNING FIELD-SYMBOL(<ls_valuation_data>).
      IF mv_valuation_hash_table IS NOT INITIAL.
        MOVE-CORRESPONDING <ls_valuation_data> TO ls_valuation_data_upd.
        ls_valuation_data_upd-object_state = if_ngc_c=>gc_object_state-loaded.
        INSERT ls_valuation_data_upd INTO TABLE mt_valuation_data_h.
      ELSE.
        APPEND INITIAL LINE TO mt_valuation_data ASSIGNING FIELD-SYMBOL(<ls_valuation_data_upd>).
        MOVE-CORRESPONDING <ls_valuation_data> TO <ls_valuation_data_upd>.
        <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-loaded.
      ENDIF.
    ENDLOOP.

    IF mv_valuation_hash_table IS INITIAL.
      SORT mt_valuation_data ASCENDING BY clfnobjectid classtype charcinternalid charcvaluepositionnumber timeintervalnumber.
    ENDIF.

    " setup node leaf concept
    setup_classtypes_node_leaf( ).

  ENDMETHOD.