  PRIVATE SECTION.
    METHODS:
      uncondense_flow
        IMPORTING it_flow        TYPE swydyflow
                  it_spaces      TYPE ty_spaces_tt
        RETURNING VALUE(rt_flow) TYPE swydyflow.

    CLASS-METHODS auto_correct_cua_adm
      IMPORTING
        is_cua TYPE ty_cua
      CHANGING
        cs_adm TYPE rsmpe_adm.

