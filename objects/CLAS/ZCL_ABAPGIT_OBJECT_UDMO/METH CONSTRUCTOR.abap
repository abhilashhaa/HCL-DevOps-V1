  METHOD constructor.

    super->constructor( is_item  =  is_item
                        iv_language = iv_language ).


    " Conversion to Data model
    me->mv_data_model = is_item-obj_name.
    " Default activation state is active
    me->mv_activation_state = c_active_state.
    " Derive the data model's text object
    mv_text_object = 'UDMD' && is_item-obj_name.
    " And set the text object to active
    mv_text_object+30(1) = mv_activation_state.
    mv_lxe_text_name = mv_text_object.

    " Correction and Transport System object
    me->ms_object_type-objtype = c_correction_object_type.
    me->ms_object_type-objname = is_item-obj_name.


  ENDMETHOD.