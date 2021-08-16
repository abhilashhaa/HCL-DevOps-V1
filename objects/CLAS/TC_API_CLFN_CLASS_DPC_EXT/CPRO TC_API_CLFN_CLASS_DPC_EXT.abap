  PROTECTED SECTION.
    DATA:
      mo_cut                  TYPE REF TO cl_api_clfn_class_dpc_ext.

    METHODS:
      a_clfnclasscharc_get_entity FOR TESTING
        RAISING /iwbep/cx_mgw_tech_exception
                /iwbep/cx_mgw_busi_exception,
      a_clfnclasscharc_get_entityset FOR TESTING
        RAISING /iwbep/cx_mgw_tech_exception
                cx_lo_vchclf_sim_cabn.

*      enforce_rt_factory_exception ABSTRACT
*        RETURNING VALUE(rv_not_possible) TYPE string.