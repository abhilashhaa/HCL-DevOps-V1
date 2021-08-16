  METHOD to_xml.

    CALL TRANSFORMATION id
      OPTIONS initial_components = 'suppress'
      SOURCE data = is_data
      RESULT XML rv_xml.

    rv_xml = zcl_abapgit_xml_pretty=>print( rv_xml ).

    REPLACE FIRST OCCURRENCE
      OF REGEX '<\?xml version="1\.0" encoding="[\w-]+"\?>'
      IN rv_xml
      WITH '<?xml version="1.0" encoding="utf-8"?>'.
    ASSERT sy-subrc = 0.

  ENDMETHOD.