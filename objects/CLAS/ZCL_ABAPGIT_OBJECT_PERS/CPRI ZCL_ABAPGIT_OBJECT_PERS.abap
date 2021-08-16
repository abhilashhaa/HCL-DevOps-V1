  PRIVATE SECTION.
    TYPES:
      BEGIN OF ty_personalization_object,
        pers_reg      TYPE spers_reg,
        pers_reg_text TYPE spers_regt,
      END OF ty_personalization_object.

    DATA:
      mv_pers_key TYPE spers_key.

    METHODS:
      get_personalization_object
        IMPORTING
          iv_create                        TYPE abap_bool OPTIONAL
          iv_view_only                     TYPE abap_bool OPTIONAL
        RETURNING
          VALUE(ro_personalization_object) TYPE REF TO cl_pers_reg
        RAISING
          zcx_abapgit_exception.
