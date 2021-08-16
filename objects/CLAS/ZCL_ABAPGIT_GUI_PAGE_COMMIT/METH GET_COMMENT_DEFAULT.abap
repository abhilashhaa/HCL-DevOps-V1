  METHOD get_comment_default.

    DATA: lo_settings TYPE REF TO zcl_abapgit_settings,
          lt_stage    TYPE zif_abapgit_definitions=>ty_stage_tt.

    " Get setting for default comment text
    lo_settings = zcl_abapgit_persist_settings=>get_instance( )->read( ).

    rv_text = lo_settings->get_commitmsg_comment_default( ).

    IF rv_text IS INITIAL.
      RETURN.
    ENDIF.

    " Determine texts for scope of commit
    lt_stage = mo_stage->get_all( ).

    REPLACE '$FILE'   IN rv_text WITH get_comment_file( lt_stage ).

    REPLACE '$OBJECT' IN rv_text WITH get_comment_object( lt_stage ).

  ENDMETHOD.