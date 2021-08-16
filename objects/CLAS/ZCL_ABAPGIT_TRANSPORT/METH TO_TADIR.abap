  METHOD to_tadir.
    DATA: lt_requests TYPE trwbo_requests.


    IF lines( it_transport_headers ) = 0.
      RETURN.
    ENDIF.

    lt_requests = read_requests( it_transport_headers ).
    rt_tadir = resolve( lt_requests ).
  ENDMETHOD.