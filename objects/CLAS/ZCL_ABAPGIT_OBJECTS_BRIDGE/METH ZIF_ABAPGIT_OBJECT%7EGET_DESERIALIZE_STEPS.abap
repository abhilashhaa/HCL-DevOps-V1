  METHOD zif_abapgit_object~get_deserialize_steps.

    DATA: ls_meta TYPE zif_abapgit_definitions=>ty_metadata.

    ls_meta = zif_abapgit_object~get_metadata( ).

    IF ls_meta-late_deser = abap_true.
      APPEND zif_abapgit_object=>gc_step_id-late TO rt_steps.
    ELSEIF ls_meta-ddic = abap_true.
      APPEND zif_abapgit_object=>gc_step_id-ddic TO rt_steps.
    ELSE.
      APPEND zif_abapgit_object=>gc_step_id-abap TO rt_steps.
    ENDIF.

  ENDMETHOD.