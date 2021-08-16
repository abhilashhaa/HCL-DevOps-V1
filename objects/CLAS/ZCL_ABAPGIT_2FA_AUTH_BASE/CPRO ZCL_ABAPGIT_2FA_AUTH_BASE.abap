  PROTECTED SECTION.
    CLASS-METHODS:
      "! Helper method to raise class based exception after traditional exception was raised
      "! <p>
      "! <em>sy-msg...</em> must be set right before calling!
      "! </p>
      raise_comm_error_from_sy RAISING zcx_abapgit_2fa_comm_error.
    METHODS:
      "! @parameter rv_running | Internal session is currently active
      is_session_running RETURNING VALUE(rv_running) TYPE abap_bool,
      "! Returns HTTP client configured with proxy (where required) for the given URL
      get_http_client_for_url
        IMPORTING iv_url           TYPE string
        RETURNING VALUE(ri_client) TYPE REF TO if_http_client
        RAISING   zcx_abapgit_2fa_comm_error.