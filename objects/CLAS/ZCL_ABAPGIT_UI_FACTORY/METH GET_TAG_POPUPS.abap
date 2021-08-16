  METHOD get_tag_popups.

    IF gi_tag_popups IS INITIAL.
      CREATE OBJECT gi_tag_popups TYPE zcl_abapgit_tag_popups.
    ENDIF.

    ri_tag_popups = gi_tag_popups.

  ENDMETHOD.