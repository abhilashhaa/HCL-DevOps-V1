  METHOD on_double_click.

    FIELD-SYMBOLS: <ls_tag> TYPE ty_tag_out.

    READ TABLE mt_tags ASSIGNING <ls_tag>
                       INDEX row.
    IF sy-subrc <> 0 OR <ls_tag>-body IS INITIAL.
      RETURN.
    ENDIF.

    show_docking_container_with( <ls_tag>-body ).

  ENDMETHOD.