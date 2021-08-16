  METHOD clean_url.
    rv_url = replace(
      val = iv_url
      regex = '\{.*\}$'
      with = '' ).
  ENDMETHOD.