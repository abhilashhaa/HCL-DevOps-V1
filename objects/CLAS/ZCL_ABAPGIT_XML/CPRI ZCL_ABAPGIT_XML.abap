  PRIVATE SECTION.

    METHODS error
      IMPORTING ii_parser TYPE REF TO if_ixml_parser
      RAISING   zcx_abapgit_exception.
    METHODS display_version_mismatch
      RAISING zcx_abapgit_exception.
    METHODS show_parser_errors
      IMPORTING ii_parser TYPE REF TO if_ixml_parser.
    METHODS raise_exception_for
      IMPORTING
        ii_error TYPE REF TO if_ixml_parse_error
      RAISING
        zcx_abapgit_exception.
