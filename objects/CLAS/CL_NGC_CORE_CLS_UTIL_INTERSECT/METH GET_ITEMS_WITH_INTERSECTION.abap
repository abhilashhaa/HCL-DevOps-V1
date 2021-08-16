  METHOD get_items_with_intersection.

    rt_intersect_char_values = it_collected_char_values.

    LOOP AT rt_intersect_char_values ASSIGNING FIELD-SYMBOL(<ls_collected_char_value>).
      SORT <ls_collected_char_value>-charc_values BY charcvalue charcfromnumericvalue charctonumericvalue.
    ENDLOOP.

    LOOP AT rt_intersect_char_values INTO DATA(ls_collected_value_1) TO lines( rt_intersect_char_values ) - 1.
      LOOP AT rt_intersect_char_values INTO DATA(ls_collected_value_2) FROM sy-tabix + 1.
        IF ls_collected_value_1-charc_values = ls_collected_value_2-charc_values.
          DELETE rt_intersect_char_values INDEX sy-tabix.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.