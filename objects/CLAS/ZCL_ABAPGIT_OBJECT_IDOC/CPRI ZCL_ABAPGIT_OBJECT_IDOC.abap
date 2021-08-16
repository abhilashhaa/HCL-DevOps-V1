  PRIVATE SECTION.
    TYPES:
      BEGIN OF ty_idoc,
        attributes TYPE edi_iapi01,
        t_syntax   TYPE STANDARD TABLE OF edi_iapi02 WITH NON-UNIQUE DEFAULT KEY,
      END OF ty_idoc.

    DATA: mv_idoctyp TYPE edi_iapi00-idoctyp.

    CLASS-METHODS clear_idoc_segement_field  IMPORTING iv_fieldname TYPE csequence CHANGING cg_structure TYPE any.
