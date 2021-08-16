  METHOD create.

    " Create instance of highighter dynamically dependent on syntax type
    IF iv_filename CP '*.abap'.
      CREATE OBJECT ro_instance TYPE zcl_abapgit_syntax_abap.
    ELSEIF iv_filename CP '*.xml' OR iv_filename CP '*.html'.
      CREATE OBJECT ro_instance TYPE zcl_abapgit_syntax_xml.
    ELSEIF iv_filename CP '*.css'.
      CREATE OBJECT ro_instance TYPE zcl_abapgit_syntax_css.
    ELSEIF iv_filename CP '*.js'.
      CREATE OBJECT ro_instance TYPE zcl_abapgit_syntax_js.
    ELSEIF iv_filename CP '*.json'.
      CREATE OBJECT ro_instance TYPE zcl_abapgit_syntax_json.
    ELSE.
      CLEAR ro_instance.
    ENDIF.

  ENDMETHOD.