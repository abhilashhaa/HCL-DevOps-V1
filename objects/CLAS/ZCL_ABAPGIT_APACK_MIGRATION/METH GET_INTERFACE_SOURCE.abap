  METHOD get_interface_source.

    INSERT `INTERFACE zif_apack_manifest PUBLIC.` INTO TABLE rt_source.
    INSERT `` INTO TABLE rt_source.
    INSERT `  TYPES: BEGIN OF ty_dependency,` INTO TABLE rt_source.
    INSERT `           group_id       TYPE string,` INTO TABLE rt_source.
    INSERT `           artifact_id    TYPE string,` INTO TABLE rt_source.
    INSERT `           version        TYPE string,` INTO TABLE rt_source.
    INSERT `           git_url        TYPE string,` INTO TABLE rt_source.
    INSERT `           target_package TYPE devclass,` INTO TABLE rt_source.
    INSERT `         END OF ty_dependency,` INTO TABLE rt_source.
    INSERT `         ty_dependencies    TYPE STANDARD TABLE OF ty_dependency` INTO TABLE rt_source.
    INSERT `                            WITH NON-UNIQUE DEFAULT KEY,` INTO TABLE rt_source.
    INSERT `         ty_repository_type TYPE string,` INTO TABLE rt_source.
    INSERT `         BEGIN OF ty_descriptor,` INTO TABLE rt_source.
    INSERT `           group_id        TYPE string,` INTO TABLE rt_source.
    INSERT `           artifact_id     TYPE string,` INTO TABLE rt_source.
    INSERT `           version         TYPE string,` INTO TABLE rt_source.
    INSERT `           repository_type TYPE ty_repository_type,` INTO TABLE rt_source.
    INSERT `           git_url         TYPE string,` INTO TABLE rt_source.
    INSERT `           dependencies    TYPE ty_dependencies,` INTO TABLE rt_source.
    INSERT `         END OF ty_descriptor.` INTO TABLE rt_source.
    INSERT `` INTO TABLE rt_source.
    INSERT `  CONSTANTS: co_file_name         TYPE string VALUE '.apack-manifest.xml',` INTO TABLE rt_source.
    INSERT `             co_abap_git          TYPE ty_repository_type VALUE 'abapGit',` INTO TABLE rt_source.
    INSERT `             co_interface_version TYPE i VALUE 1.` INTO TABLE rt_source.
    INSERT `` INTO TABLE rt_source.
    INSERT `  DATA: descriptor TYPE ty_descriptor READ-ONLY.` INTO TABLE rt_source.
    INSERT `` INTO TABLE rt_source.
    INSERT `ENDINTERFACE.` INTO TABLE rt_source.

  ENDMETHOD.