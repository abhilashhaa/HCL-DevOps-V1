CLASS cl_api_clfn_product_mpc DEFINITION
  PUBLIC
  INHERITING FROM /iwbep/cl_mgw_push_abs_model
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_sadl_gw_model_exposure_data .

    TYPES:
     ts_a_clfnclassforkeydatetype TYPE a_clfnclassforkeydate.
    TYPES:
     tt_a_clfnclassforkeydatetype TYPE STANDARD TABLE OF ts_a_clfnclassforkeydatetype .
    TYPES:
     ts_a_clfnproducttype TYPE a_clfnproduct.
    TYPES:
     tt_a_clfnproducttype TYPE STANDARD TABLE OF ts_a_clfnproducttype .
    TYPES:
     ts_a_productcharctype TYPE a_productcharc.
    TYPES:
     tt_a_productcharctype TYPE STANDARD TABLE OF ts_a_productcharctype .
    TYPES:
     ts_a_productcharcvaluetype TYPE a_productcharcvalue.
    TYPES:
     tt_a_productcharcvaluetype TYPE STANDARD TABLE OF ts_a_productcharcvaluetype .
    TYPES:
     ts_a_productclasstype TYPE a_productclass.
    TYPES:
     tt_a_productclasstype TYPE STANDARD TABLE OF ts_a_productclasstype .
    TYPES:
     ts_a_productclasscharctype TYPE a_productclasscharc.
    TYPES:
     tt_a_productclasscharctype TYPE STANDARD TABLE OF ts_a_productclasscharctype .
    TYPES:
     ts_a_productdescriptiontype TYPE a_productdescription.
    TYPES:
     tt_a_productdescriptiontype TYPE STANDARD TABLE OF ts_a_productdescriptiontype .
    TYPES:
      BEGIN OF ts_a_productplanttype.
        INCLUDE TYPE a_productplant.
        INCLUDE TYPE plnt_incl_eew_tr.
      TYPES:
      END OF ts_a_productplanttype .
    TYPES:
     tt_a_productplanttype TYPE STANDARD TABLE OF ts_a_productplanttype .
    TYPES:
     ts_a_productplantprocurementty TYPE a_productplantprocurement.
    TYPES:
     tt_a_productplantprocurementty TYPE STANDARD TABLE OF ts_a_productplantprocurementty .
    TYPES:
      BEGIN OF ts_a_productsalesdeliverytype.
        INCLUDE TYPE a_productsalesdelivery.
        INCLUDE TYPE sald_incl_eew_tr.
      TYPES:
      END OF ts_a_productsalesdeliverytype .
    TYPES:
     tt_a_productsalesdeliverytype TYPE STANDARD TABLE OF ts_a_productsalesdeliverytype .
    TYPES:
     ts_a_productsalestaxtype TYPE a_productsalestax.
    TYPES:
     tt_a_productsalestaxtype TYPE STANDARD TABLE OF ts_a_productsalestaxtype .
    TYPES:
      BEGIN OF ts_a_productstoragelocationtyp.
        INCLUDE TYPE a_productstoragelocation.
        INCLUDE TYPE stl_incl_eew_tr.
      TYPES:
      END OF ts_a_productstoragelocationtyp .
    TYPES:
     tt_a_productstoragelocationtyp TYPE STANDARD TABLE OF ts_a_productstoragelocationtyp .
    TYPES:
     ts_a_productsupplyplanningtype TYPE a_productsupplyplanning.
    TYPES:
     tt_a_productsupplyplanningtype TYPE STANDARD TABLE OF ts_a_productsupplyplanningtype .
    TYPES:
     ts_a_productworkschedulingtype TYPE a_productworkscheduling.
    TYPES:
     tt_a_productworkschedulingtype TYPE STANDARD TABLE OF ts_a_productworkschedulingtype .

    CONSTANTS gc_a_clfnclassforkeydatetype TYPE /iwbep/if_mgw_med_odata_types=>ty_e_med_entity_name VALUE 'A_ClfnClassForKeyDateType' ##NO_TEXT.
    CONSTANTS gc_a_clfnproducttype TYPE /iwbep/if_mgw_med_odata_types=>ty_e_med_entity_name VALUE 'A_ClfnProductType' ##NO_TEXT.
    CONSTANTS gc_a_productcharctype TYPE /iwbep/if_mgw_med_odata_types=>ty_e_med_entity_name VALUE 'A_ProductCharcType' ##NO_TEXT.
    CONSTANTS gc_a_productcharcvaluetype TYPE /iwbep/if_mgw_med_odata_types=>ty_e_med_entity_name VALUE 'A_ProductCharcValueType' ##NO_TEXT.
    CONSTANTS gc_a_productclasscharctype TYPE /iwbep/if_mgw_med_odata_types=>ty_e_med_entity_name VALUE 'A_ProductClassCharcType' ##NO_TEXT.
    CONSTANTS gc_a_productclasstype TYPE /iwbep/if_mgw_med_odata_types=>ty_e_med_entity_name VALUE 'A_ProductClassType' ##NO_TEXT.
    CONSTANTS gc_a_productdescriptiontype TYPE /iwbep/if_mgw_med_odata_types=>ty_e_med_entity_name VALUE 'A_ProductDescriptionType' ##NO_TEXT.
    CONSTANTS gc_a_productplantprocurementty TYPE /iwbep/if_mgw_med_odata_types=>ty_e_med_entity_name VALUE 'A_ProductPlantProcurementType' ##NO_TEXT.
    CONSTANTS gc_a_productplanttype TYPE /iwbep/if_mgw_med_odata_types=>ty_e_med_entity_name VALUE 'A_ProductPlantType' ##NO_TEXT.
    CONSTANTS gc_a_productsalesdeliverytype TYPE /iwbep/if_mgw_med_odata_types=>ty_e_med_entity_name VALUE 'A_ProductSalesDeliveryType' ##NO_TEXT.
    CONSTANTS gc_a_productsalestaxtype TYPE /iwbep/if_mgw_med_odata_types=>ty_e_med_entity_name VALUE 'A_ProductSalesTaxType' ##NO_TEXT.
    CONSTANTS gc_a_productstoragelocationtyp TYPE /iwbep/if_mgw_med_odata_types=>ty_e_med_entity_name VALUE 'A_ProductStorageLocationType' ##NO_TEXT.
    CONSTANTS gc_a_productsupplyplanningtype TYPE /iwbep/if_mgw_med_odata_types=>ty_e_med_entity_name VALUE 'A_ProductSupplyPlanningType' ##NO_TEXT.
    CONSTANTS gc_a_productworkschedulingtype TYPE /iwbep/if_mgw_med_odata_types=>ty_e_med_entity_name VALUE 'A_ProductWorkSchedulingType' ##NO_TEXT.

    METHODS define
        REDEFINITION .
    METHODS get_last_modified
        REDEFINITION .