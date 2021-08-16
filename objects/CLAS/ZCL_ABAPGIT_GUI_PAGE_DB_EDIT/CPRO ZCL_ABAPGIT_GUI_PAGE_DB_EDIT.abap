  PROTECTED SECTION.

    CLASS-METHODS dbcontent_decode
      IMPORTING
        !it_postdata      TYPE cnht_post_data_tab
      RETURNING
        VALUE(rs_content) TYPE zif_abapgit_persistence=>ty_content .

    METHODS render_content
        REDEFINITION .