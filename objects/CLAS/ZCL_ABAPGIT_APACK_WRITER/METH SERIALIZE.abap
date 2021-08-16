  METHOD serialize.

    DATA: ls_manifest_descriptor LIKE ms_manifest_descriptor.
    FIELD-SYMBOLS: <ls_dependency> LIKE LINE OF ls_manifest_descriptor-dependencies.

    " Setting repository type automatically to 'abapGit' as there is no other one right now
    ms_manifest_descriptor-repository_type = zif_abapgit_apack_definitions=>c_repository_type_abapgit.

    ls_manifest_descriptor = ms_manifest_descriptor.
    CLEAR: ls_manifest_descriptor-sem_version.

    LOOP AT ls_manifest_descriptor-dependencies ASSIGNING <ls_dependency>.
      CLEAR: <ls_dependency>-sem_version.
    ENDLOOP.

    CALL TRANSFORMATION id
      OPTIONS initial_components = 'suppress'
      SOURCE data = ls_manifest_descriptor
      RESULT XML rv_xml.

    rv_xml = zcl_abapgit_xml_pretty=>print( rv_xml ).

    REPLACE FIRST OCCURRENCE
      OF REGEX '<\?xml version="1\.0" encoding="[\w-]+"\?>'
      IN rv_xml
      WITH '<?xml version="1.0" encoding="utf-8"?>'.

  ENDMETHOD.