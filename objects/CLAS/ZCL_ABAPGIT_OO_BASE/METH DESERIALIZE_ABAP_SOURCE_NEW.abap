  METHOD deserialize_abap_source_new.
    DATA: lo_factory  TYPE REF TO object,
          lo_source   TYPE REF TO object,
          lo_settings TYPE REF TO object,
          lr_settings TYPE REF TO data.

    FIELD-SYMBOLS <lg_settings> TYPE any.


    "Buffer needs to be refreshed,
    "otherwise standard SAP CLIF_SOURCE reorder methods alphabetically
    CALL FUNCTION 'SEO_BUFFER_INIT'.
    CALL FUNCTION 'SEO_BUFFER_REFRESH'
      EXPORTING
        cifkey  = is_clskey
        version = seoc_version_inactive.

    CALL METHOD ('CL_OO_FACTORY')=>('CREATE_INSTANCE')
      RECEIVING
        result = lo_factory.

    "Enable modification mode to avoid exception CX_OO_ACCESS_PERMISSON when
    "dealing with objects in foreign namespaces (namespace role = C)
    CALL METHOD lo_factory->('CREATE_SETTINGS')
      EXPORTING
        modification_mode_enabled = abap_true
      RECEIVING
        result                    = lo_settings.

    CREATE DATA lr_settings TYPE REF TO ('IF_OO_CLIF_SOURCE_SETTINGS').
    ASSIGN lr_settings->* TO <lg_settings>.

    <lg_settings> ?= lo_settings.

    CALL METHOD lo_factory->('CREATE_CLIF_SOURCE')
      EXPORTING
        clif_name = is_clskey-clsname
        settings  = <lg_settings>
      RECEIVING
        result    = lo_source.

    TRY.
        CALL METHOD lo_source->('IF_OO_CLIF_SOURCE~LOCK').
      CATCH cx_oo_access_permission.
        zcx_abapgit_exception=>raise( 'source_new, access permission exception' ).
    ENDTRY.

    CALL METHOD lo_source->('IF_OO_CLIF_SOURCE~SET_SOURCE')
      EXPORTING
        source = it_source.

    CALL METHOD lo_source->('IF_OO_CLIF_SOURCE~SAVE').

    CALL METHOD lo_source->('IF_OO_CLIF_SOURCE~UNLOCK').

  ENDMETHOD.