  PROTECTED SECTION.

    CLASS-METHODS parse_commit_request
      IMPORTING
        !it_postdata TYPE cnht_post_data_tab
      EXPORTING
        !eg_fields   TYPE any .

    METHODS render_content REDEFINITION .
