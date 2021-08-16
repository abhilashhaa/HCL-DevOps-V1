  METHOD zif_abapgit_oo_object_fnc~deserialize_source.

    DATA: lv_updated TYPE abap_bool,
          lv_program TYPE program,
          lo_scanner TYPE REF TO cl_oo_source_scanner_class,
          lt_methods TYPE cl_oo_source_scanner_class=>type_method_implementations,
          lv_method  LIKE LINE OF lt_methods,
          lt_public  TYPE seop_source_string,
          lt_source  TYPE seop_source_string.

    "Buffer needs to be refreshed,
    "otherwise standard SAP CLIF_SOURCE reorder methods alphabetically
    CALL FUNCTION 'SEO_BUFFER_INIT'.
    CALL FUNCTION 'SEO_BUFFER_REFRESH'
      EXPORTING
        cifkey  = is_key
        version = seoc_version_inactive.

    lo_scanner = init_scanner(
      it_source = it_source
      iv_name   = is_key-clsname ).

* public
    lt_public = lo_scanner->get_public_section_source( ).
    IF lt_public IS NOT INITIAL.
      lv_program = cl_oo_classname_service=>get_pubsec_name( is_key-clsname ).
      lv_updated = update_report( iv_program = lv_program
                                  it_source  = lt_public ).
      IF lv_updated = abap_true.
        update_meta( iv_name     = is_key-clsname
                     iv_exposure = seoc_exposure_public
                     it_source   = lt_public ).
      ENDIF.
    ENDIF.

* protected
    lt_source = lo_scanner->get_protected_section_source( ).
    IF lt_source IS NOT INITIAL.
      lv_program = cl_oo_classname_service=>get_prosec_name( is_key-clsname ).
      lv_updated = update_report( iv_program = lv_program
                                  it_source  = lt_source ).
      IF lv_updated = abap_true.
        update_meta( iv_name     = is_key-clsname
                     iv_exposure = seoc_exposure_protected
                     it_source   = lt_source ).
      ENDIF.
    ENDIF.

* private
    lt_source = lo_scanner->get_private_section_source( ).
    IF lt_source IS NOT INITIAL.
      lv_program = cl_oo_classname_service=>get_prisec_name( is_key-clsname ).
      lv_updated = update_report( iv_program = lv_program
                                  it_source  = lt_source ).
      IF lv_updated = abap_true.
        update_meta( iv_name     = is_key-clsname
                     iv_exposure = seoc_exposure_private
                     it_source   = lt_source ).
      ENDIF.
    ENDIF.

* methods
    lt_methods = lo_scanner->get_method_implementations( ).

    LOOP AT lt_methods INTO lv_method.
      TRY.
          lt_source = lo_scanner->get_method_impl_source( lv_method ).
        CATCH cx_oo_clif_component.
          zcx_abapgit_exception=>raise( 'error from GET_METHOD_IMPL_SOURCE' ).
      ENDTRY.
      lv_program = determine_method_include(
        iv_name   = is_key-clsname
        iv_method = lv_method ).

      update_report(
        iv_program = lv_program
        it_source  = lt_source ).
    ENDLOOP.

* full class include
    update_full_class_include( iv_classname = is_key-clsname
                               it_source    = it_source
                               it_methods   = lt_methods ).

    update_source_index(
      iv_clsname = is_key-clsname
      io_scanner = lo_scanner ).

* TODO, perhaps move this call to somewhere else, to be done while cleaning up the CLAS deserialization
    zcl_abapgit_objects_activation=>add(
      iv_type = 'CLAS'
      iv_name = is_key-clsname ).

  ENDMETHOD.