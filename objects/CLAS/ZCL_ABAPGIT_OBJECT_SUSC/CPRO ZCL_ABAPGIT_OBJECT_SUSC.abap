  PROTECTED SECTION.

    CONSTANTS transobjecttype_class TYPE c LENGTH 1 VALUE 'C' ##NO_TEXT.

    METHODS has_authorization
      IMPORTING
        !iv_class    TYPE tobc-oclss
        !iv_activity TYPE activ_auth
      RAISING
        zcx_abapgit_exception .
    METHODS is_used
      IMPORTING
        !iv_auth_object_class TYPE tobc-oclss
      RAISING
        zcx_abapgit_exception .