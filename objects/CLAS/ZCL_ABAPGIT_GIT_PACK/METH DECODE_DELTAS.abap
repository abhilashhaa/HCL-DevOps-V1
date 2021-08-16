  METHOD decode_deltas.

    DATA: ls_object   LIKE LINE OF ct_objects,
          li_progress TYPE REF TO zif_abapgit_progress,
          lt_deltas   LIKE ct_objects.


    LOOP AT ct_objects INTO ls_object
        USING KEY type
        WHERE type = zif_abapgit_definitions=>c_type-ref_d.
      INSERT ls_object INTO TABLE lt_deltas.
    ENDLOOP.

    DELETE ct_objects
      USING KEY type
      WHERE type = zif_abapgit_definitions=>c_type-ref_d.

    "Restore correct Delta Order
    SORT lt_deltas BY index.

    li_progress = zcl_abapgit_progress=>get_instance( lines( lt_deltas ) ).

    LOOP AT lt_deltas INTO ls_object.
      li_progress->show( iv_current = sy-tabix
                         iv_text    = 'Decode deltas' ).

      delta( EXPORTING is_object = ls_object
             CHANGING ct_objects = ct_objects ).
    ENDLOOP.

  ENDMETHOD.