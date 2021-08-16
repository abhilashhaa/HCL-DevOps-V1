  METHOD if_ngc_chd_util~get_clf_object.

    DATA:
      lt_inob             TYPE STANDARD TABLE OF inob,
      lt_class_type       TYPE STANDARD TABLE OF rmclklart,
      lt_class_type_range TYPE RANGE OF klassenart.

    " get internal object IDs
    SELECT cuobj, objek
      FROM inob
      WHERE objek IN @it_object_id        AND
            obtab EQ @iv_object_table
      INTO CORRESPONDING FIELDS OF TABLE @lt_inob.

    " prepare Classification change document object ID
    LOOP AT lt_inob ASSIGNING FIELD-SYMBOL(<ls_inob>).
      APPEND INITIAL LINE TO ct_clf_object ASSIGNING FIELD-SYMBOL(<ls_clf_object>).
      <ls_clf_object>-object_class    = if_ngc_chd_util=>gc_clf_object_class.
      <ls_clf_object>-object_id       = <ls_inob>-cuobj && 'O'.
      <ls_clf_object>-parent_key      = <ls_inob>-objek.
      <ls_clf_object>-condense_lines  = abap_true.
    ENDLOOP.

  ENDMETHOD.