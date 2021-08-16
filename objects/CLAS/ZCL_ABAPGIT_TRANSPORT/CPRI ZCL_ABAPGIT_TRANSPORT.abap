  PRIVATE SECTION.
    CLASS-METHODS collect_all_objects
      IMPORTING
        iv_key            TYPE zif_abapgit_persistence=>ty_value
      RETURNING
        VALUE(rt_objects) TYPE tr_objects
      RAISING
        zcx_abapgit_exception.