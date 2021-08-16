  METHOD to_xml.

    DATA: ls_xml TYPE zif_abapgit_persistence=>ty_repo_xml.


    MOVE-CORRESPONDING is_repo TO ls_xml.

    CALL TRANSFORMATION id
      SOURCE repo = ls_xml
      RESULT XML rv_repo_xml_string.
  ENDMETHOD.