  METHOD save.

    DATA:
      lt_sproxhdr_old  TYPE sprx_hdr_t,
      lt_sproxdat_old  TYPE sprx_dat_t,
      lt_sproxsvar_old TYPE sprx_svar_t,
      lt_sproxintf_old TYPE sprx_matchintf_t,
      lt_sproxsvar_new TYPE sprx_svar_t,
      lt_sproxintf_new TYPE sprx_matchintf_t.

    cl_proxy_data=>db_save(
        sproxhdr_old  = lt_sproxhdr_old
        sproxdat_old  = lt_sproxdat_old
        sproxsvar_old = lt_sproxsvar_old
        sproxintf_old = lt_sproxintf_old
        sproxhdr_new  = it_sproxhdr_new
        sproxdat_new  = it_sproxdat_new
        sproxsvar_new = lt_sproxsvar_new
        sproxintf_new = lt_sproxintf_new ).

  ENDMETHOD.