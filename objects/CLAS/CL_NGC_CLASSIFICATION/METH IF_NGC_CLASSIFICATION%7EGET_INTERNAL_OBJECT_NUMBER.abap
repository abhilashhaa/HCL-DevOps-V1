  METHOD if_ngc_classification~get_internal_object_number.

    rt_obj_int_id = mo_clf_persistency->read_internal_object_number(
                                          EXPORTING
                                            it_classtype          = mt_classtype
                                            is_classification_key = ms_classification_key
                                        ).

  ENDMETHOD.