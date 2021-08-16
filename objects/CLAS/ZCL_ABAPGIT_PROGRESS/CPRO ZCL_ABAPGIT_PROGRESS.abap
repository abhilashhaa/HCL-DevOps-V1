  PROTECTED SECTION.

    DATA mv_total TYPE i .
    CLASS-DATA gi_progress TYPE REF TO zif_abapgit_progress .

    METHODS calc_pct
      IMPORTING
        !iv_current   TYPE i
      RETURNING
        VALUE(rv_pct) TYPE i .