  METHOD after_conversion.

    " Delete our temporary views.
    me->delete_views( ).

    " Close log (and display in dialog mode).
    mo_conv_logger->close( ).

  ENDMETHOD.