  METHOD class_constructor.
    CREATE OBJECT go_single_tags_re
      EXPORTING
        pattern     = '<(AREA|BASE|BR|COL|COMMAND|EMBED|HR|IMG|INPUT|LINK|META|PARAM|SOURCE|!)'
        ignore_case = abap_false.
  ENDMETHOD.