  PRIVATE SECTION.

    METHODS:
      factory
        IMPORTING
          iv_tool        TYPE enhtooltype
        RETURNING
          VALUE(ri_enho) TYPE REF TO zif_abapgit_object_enho
        RAISING
          zcx_abapgit_exception.
