CLASS cl_api_clfn_class_mpc DEFINITION
  PUBLIC
  INHERITING FROM /iwbep/cl_mgw_push_abs_model
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_sadl_gw_model_exposure_data .

    TYPES:
     ts_a_clfnclasscharcforkeydatet TYPE a_clfnclasscharcforkeydate .
    TYPES:
     tt_a_clfnclasscharcforkeydatet TYPE STANDARD TABLE OF ts_a_clfnclasscharcforkeydatet .
    TYPES:
     ts_a_clfnclassdescforkeydatety TYPE a_clfnclassdescforkeydate.
    TYPES:
     tt_a_clfnclassdescforkeydatety TYPE STANDARD TABLE OF ts_a_clfnclassdescforkeydatety .
    TYPES:
     ts_a_clfnclassforkeydatetype TYPE a_clfnclassforkeydate .
    TYPES:
     tt_a_clfnclassforkeydatetype TYPE STANDARD TABLE OF ts_a_clfnclassforkeydatetype .
    TYPES:
     ts_a_clfnclasskeywordforkeydat TYPE a_clfnclasskeywordforkeydate .
    TYPES:
     tt_a_clfnclasskeywordforkeydat TYPE STANDARD TABLE OF ts_a_clfnclasskeywordforkeydat .
    TYPES:
     ts_a_clfnclasstextforkeydatety TYPE a_clfnclasstextforkeydate .
    TYPES:
     tt_a_clfnclasstextforkeydatety TYPE STANDARD TABLE OF ts_a_clfnclasstextforkeydatety .

    CONSTANTS gc_a_clfnclasscharcforkeydatet TYPE /iwbep/if_mgw_med_odata_types=>ty_e_med_entity_name VALUE 'A_ClfnClassCharcForKeyDateType' ##NO_TEXT.
    CONSTANTS gc_a_clfnclassdescforkeydatety TYPE /iwbep/if_mgw_med_odata_types=>ty_e_med_entity_name VALUE 'A_ClfnClassDescForKeyDateType' ##NO_TEXT.
    CONSTANTS gc_a_clfnclassforkeydatetype TYPE /iwbep/if_mgw_med_odata_types=>ty_e_med_entity_name VALUE 'A_ClfnClassForKeyDateType' ##NO_TEXT.
    CONSTANTS gc_a_clfnclasskeywordforkeydat TYPE /iwbep/if_mgw_med_odata_types=>ty_e_med_entity_name VALUE 'A_ClfnClassKeywordForKeyDateType' ##NO_TEXT.
    CONSTANTS gc_a_clfnclasstextforkeydatety TYPE /iwbep/if_mgw_med_odata_types=>ty_e_med_entity_name VALUE 'A_ClfnClassTextForKeyDateType' ##NO_TEXT.

    METHODS define
        REDEFINITION .
    METHODS get_last_modified
        REDEFINITION .