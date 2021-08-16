  PRIVATE SECTION.

    CONSTANTS mc_package_size TYPE i VALUE 100000 ##NO_TEXT.
    CONSTANTS mc_selective_field TYPE fieldname VALUE 'OBJEK' ##NO_TEXT.
    CONSTANTS mc_status_field TYPE fieldname VALUE 'SDM_STATUS' ##NO_TEXT.
    CONSTANTS:
      BEGIN OF mc_sdm_status,
        BEGIN OF clf_hdr_exist_objekp_unfilled,
          single TYPE sdm_status_value_done VALUE '1' ##NO_TEXT,
          multi  TYPE sdm_status_value_done VALUE '2' ##NO_TEXT,
        END OF clf_hdr_exist_objekp_unfilled ,
        BEGIN OF clf_hdr_non_exist,
          single TYPE sdm_status_value_done VALUE '3' ##NO_TEXT,
          multi  TYPE sdm_status_value_done VALUE '4' ##NO_TEXT,
          class  TYPE sdm_status_value_done VALUE '5' ##NO_TEXT,
        END OF clf_hdr_non_exist ,
        done TYPE sdm_status_value_done VALUE '9' ##NO_TEXT,
      END OF mc_sdm_status .
    DATA mc_view_name TYPE tabname VALUE 'PSDMCH' ##NO_TEXT.

    METHODS inob_inconsistency
      CHANGING
        !ct_clf_hdr TYPE tt_clf_hdr .