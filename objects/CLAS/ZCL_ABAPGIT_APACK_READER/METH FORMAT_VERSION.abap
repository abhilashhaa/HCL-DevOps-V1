  METHOD format_version.

    FIELD-SYMBOLS: <ls_dependency> TYPE zif_abapgit_apack_definitions=>ty_dependency.

    TRANSLATE ms_cached_descriptor-version TO LOWER CASE.
    ms_cached_descriptor-sem_version = zcl_abapgit_version=>conv_str_to_version( ms_cached_descriptor-version ).

    LOOP AT ms_cached_descriptor-dependencies ASSIGNING <ls_dependency>.
      <ls_dependency>-sem_version = zcl_abapgit_version=>conv_str_to_version( <ls_dependency>-version ).
    ENDLOOP.

  ENDMETHOD.