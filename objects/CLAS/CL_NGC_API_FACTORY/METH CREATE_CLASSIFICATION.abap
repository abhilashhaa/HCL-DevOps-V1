METHOD create_classification.

  ro_classification = NEW cl_ngc_classification( is_classification_key  = is_classification_key
                                                 it_classification_data = it_classification_data
                                                 it_assigned_classes    = it_assigned_classes
                                                 it_valuation_data      = it_valuation_data
                                                 io_ngc_api_factory     = me ).

ENDMETHOD.