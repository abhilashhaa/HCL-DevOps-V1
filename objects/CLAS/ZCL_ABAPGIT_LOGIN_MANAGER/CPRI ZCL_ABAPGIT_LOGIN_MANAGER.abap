  PRIVATE SECTION.

    TYPES:
      BEGIN OF ty_auth,
        uri           TYPE string,
        authorization TYPE string,
      END OF ty_auth .

    CLASS-DATA:
      gt_auth TYPE TABLE OF ty_auth WITH DEFAULT KEY .

    CLASS-METHODS append
      IMPORTING
        !iv_uri  TYPE string
        !iv_auth TYPE string
      RAISING
        zcx_abapgit_exception .