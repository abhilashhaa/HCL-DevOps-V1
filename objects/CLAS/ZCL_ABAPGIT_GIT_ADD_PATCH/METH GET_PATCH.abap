  METHOD get_patch.

    IF mt_patch IS INITIAL.
      mt_patch = calculate_patch( ).
    ENDIF.

    rt_patch = mt_patch.

  ENDMETHOD.