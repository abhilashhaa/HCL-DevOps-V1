  METHOD if_dtinf_read_api_ext~get.

    " The followings need to be defined here:
    " - function module to retrieve classification data
    " - table relation between the main object and the characteristic values
    " Cross-Plant Batch table as the main object has the key fields MCH1-MATNR and MCH1-CHARG.
    " This values can be used as starting point for Table Cluster CA_CL_CLS with database field AUSP-OBJEK.

    APPEND VALUE #( sec_tc_id       = 'CA_CL_CLS'
                    function_module = 'NGC_IRF_MCH1'
                    prim_tab        = 'MCH1'
                    sec_tab         = 'AUSP'
                    prim_field      = 'MATNR'
                    sec_field       = 'OBJEK' ) TO ct_read_api_ext.

    APPEND VALUE #( sec_tc_id       = 'CA_CL_CLS'
                    function_module = 'NGC_IRF_MCH1'
                    prim_tab        = 'MCH1'
                    sec_tab         = 'AUSP'
                    prim_field      = 'CHARG'
                    sec_field       = 'OBJEK' ) TO ct_read_api_ext.

  ENDMETHOD.