  PROTECTED SECTION.

    CLASS-DATA gt_keywords TYPE HASHED TABLE OF string WITH UNIQUE KEY table_line.

    CLASS-METHODS init_keywords.
    CLASS-METHODS is_keyword
      IMPORTING iv_chunk      TYPE string
      RETURNING VALUE(rv_yes) TYPE abap_bool.

    METHODS order_matches REDEFINITION.
    METHODS parse_line REDEFINITION.
