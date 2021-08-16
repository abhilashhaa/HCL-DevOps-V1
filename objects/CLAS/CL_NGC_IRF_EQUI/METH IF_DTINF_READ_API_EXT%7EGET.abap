  METHOD IF_DTINF_READ_API_EXT~GET.

    " The followings need to be defined here:
    " - function module to retrieve classification data
    " - table relation between the main object and the characteristic values
    " Equipment table as the main object has the key field EQUI-EQUNR.
    " This value can be used as starting point for Table Cluster CA_CL_CLS with database field AUSP-OBJEK.

    APPEND VALUE #( sec_tc_id       = 'CA_CL_CLS'
                    function_module = 'NGC_IRF_EQUI'
                    prim_tab        = 'EQUI'
                    sec_tab         = 'AUSP'
                    prim_field      = 'EQUNR'
                    sec_field       = 'OBJEK' ) TO ct_read_api_ext.

  ENDMETHOD.