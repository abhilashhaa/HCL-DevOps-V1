  METHOD get_pulls.

    IF mi_enum_provider IS NOT BOUND.
      RETURN.
    ENDIF.

    rt_pulls = mi_enum_provider->list_pull_requests( ).

    " TODO caching ?

  ENDMETHOD.