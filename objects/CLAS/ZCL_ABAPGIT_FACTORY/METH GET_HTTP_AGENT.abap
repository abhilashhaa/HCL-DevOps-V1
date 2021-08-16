  METHOD get_http_agent.

    IF gi_http_agent IS BOUND.
      ri_http_agent = gi_http_agent.
    ELSE.
      ri_http_agent = zcl_abapgit_http_agent=>create( ).
    ENDIF.

  ENDMETHOD.