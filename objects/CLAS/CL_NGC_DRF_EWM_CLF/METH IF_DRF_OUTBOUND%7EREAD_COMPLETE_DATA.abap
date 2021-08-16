METHOD IF_DRF_OUTBOUND~READ_COMPLETE_DATA.

  " if filter class was already called by framework (incl. external criteria)
  " -> no need for filtering again
  IF ms_runtime_param-runmod = if_drf_const=>runmod_bypass_filter.
    DATA(lt_filtered_object) = VALUE ngct_drf_clfmas_object_key( ).
    get_filter( )->apply_filter(
      EXPORTING
        iv_appl                 = ms_runtime_param-appl
        iv_business_system      = ms_runtime_param-business_system
        iv_outb_impl            = ms_runtime_param-outb_impl
        iv_runmod               = ms_runtime_param-runmod
        io_bal                  = ms_runtime_param-bal
        iv_dlmod                = ms_runtime_param-dlmod
        it_unfiltered_objects   = ct_relevant_objects
        is_c_fobj               = VALUE #( ) "filter config not available / required
        is_filt                 = VALUE #( ) "filter config not available / required
        it_external_criteria    = VALUE #( ) "must stay empty, stipulated by runmod
      IMPORTING
        et_filtered_objects     = lt_filtered_object
    ).
    ct_relevant_objects = lt_filtered_object.
  ENDIF.

  mt_relevant_objects = ct_relevant_objects.

ENDMETHOD.