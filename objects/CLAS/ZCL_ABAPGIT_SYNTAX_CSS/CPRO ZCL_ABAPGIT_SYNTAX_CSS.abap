  PROTECTED SECTION.

    TYPES: BEGIN OF ty_keyword,
             keyword TYPE string,
             token   TYPE char1,
           END OF ty_keyword.

    CLASS-DATA gt_keywords TYPE HASHED TABLE OF ty_keyword WITH UNIQUE KEY keyword.
    CLASS-DATA gv_comment TYPE abap_bool.

    CLASS-METHODS init_keywords.
    CLASS-METHODS insert_keywords
      IMPORTING
        iv_keywords TYPE string
        iv_token    TYPE char1.
    CLASS-METHODS is_keyword
      IMPORTING iv_chunk      TYPE string
      RETURNING VALUE(rv_yes) TYPE abap_bool.

    METHODS order_matches REDEFINITION.
    METHODS parse_line REDEFINITION.
