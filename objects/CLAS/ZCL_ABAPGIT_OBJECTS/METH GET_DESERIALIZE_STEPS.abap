  METHOD get_deserialize_steps.
    FIELD-SYMBOLS: <ls_step>    TYPE LINE OF zif_abapgit_definitions=>ty_step_data_tt.

    APPEND INITIAL LINE TO rt_steps ASSIGNING <ls_step>.
    <ls_step>-step_id      = zif_abapgit_object=>gc_step_id-ddic.
    <ls_step>-descr        = 'Import DDIC objects'.
    <ls_step>-is_ddic      = abap_true.
    <ls_step>-syntax_check = abap_false.
    <ls_step>-order        = 1.

    APPEND INITIAL LINE TO rt_steps ASSIGNING <ls_step>.
    <ls_step>-step_id      = zif_abapgit_object=>gc_step_id-abap.
    <ls_step>-descr        = 'Import objects main'.
    <ls_step>-is_ddic      = abap_false.
    <ls_step>-syntax_check = abap_false.
    <ls_step>-order        = 2.

    APPEND INITIAL LINE TO rt_steps ASSIGNING <ls_step>.
    <ls_step>-step_id      = zif_abapgit_object=>gc_step_id-late.
    <ls_step>-descr        = 'Import late objects'.
    <ls_step>-is_ddic      = abap_false.
    <ls_step>-syntax_check = abap_true.
    <ls_step>-order        = 3.
  ENDMETHOD.