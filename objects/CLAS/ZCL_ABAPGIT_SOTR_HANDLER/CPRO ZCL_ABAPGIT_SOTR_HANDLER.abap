  PROTECTED SECTION.
    CLASS-METHODS get_sotr_usage
      IMPORTING
        !iv_pgmid          TYPE pgmid
        !iv_object         TYPE trobjtype
        !iv_obj_name       TYPE csequence
      RETURNING
        VALUE(rt_sotr_use) TYPE ty_sotr_use_tt.

    CLASS-METHODS get_sotr_4_concept
      IMPORTING
        !iv_concept    TYPE sotr_conc
      RETURNING
        VALUE(rs_sotr) TYPE zif_abapgit_definitions=>ty_sotr .