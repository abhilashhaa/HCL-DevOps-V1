  METHOD zif_abapgit_html_viewer~load_data.

    mo_html_viewer->load_data(
      EXPORTING
        url           = iv_url
        type          = iv_type
        subtype       = iv_subtype
        size          = iv_size
      IMPORTING
        assigned_url  = ev_assigned_url
      CHANGING
        data_table    = ct_data_table ).

  ENDMETHOD.