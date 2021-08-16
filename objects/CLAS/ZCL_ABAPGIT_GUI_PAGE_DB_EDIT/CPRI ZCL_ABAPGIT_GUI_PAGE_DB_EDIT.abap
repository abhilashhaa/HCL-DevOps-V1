  PRIVATE SECTION.

    CONSTANTS:
      BEGIN OF c_action,
        update TYPE string VALUE 'update',
      END OF c_action .
    DATA ms_key TYPE zif_abapgit_persistence=>ty_content .

    CLASS-METHODS update
      IMPORTING
        !is_content TYPE zif_abapgit_persistence=>ty_content
      RAISING
        zcx_abapgit_exception .