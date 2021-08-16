  method IF_SADL_GW_MODEL_EXPOSURE_DATA~GET_MODEL_EXPOSURE.
    CONSTANTS: co_gen_timestamp TYPE timestamp VALUE '20170830123801'.
    DATA(lv_sadl_xml) =
               |<?xml version="1.0" encoding="utf-16"?>|  &
               |<sadl:definition xmlns:sadl="http://sap.com/sap.nw.f.sadl" syntaxVersion="" >|  &
               | <sadl:dataSource type="CDS" name="A_CLFNCLASSFORKEYDATE" binding="A_CLFNCLASSFORKEYDATE" />|  &
               | <sadl:dataSource type="CDS" name="A_PRODUCTCLASSCHARC" binding="A_PRODUCTCLASSCHARC" />|  &
               | <sadl:dataSource type="CDS" name="A_PRODUCTDESCRIPTION" binding="A_PRODUCTDESCRIPTION" />|  &
               | <sadl:dataSource type="CDS" name="A_PRODUCTPLANT" binding="A_PRODUCTPLANT" />|  &
               | <sadl:dataSource type="CDS" name="A_CLFNPRODUCT" binding="A_CLFNPRODUCT" />|  &
               | <sadl:dataSource type="CDS" name="A_PRODUCTCHARC" binding="A_PRODUCTCHARC" />|  &
               | <sadl:dataSource type="CDS" name="A_PRODUCTPLANTPROCUREMENT" binding="A_PRODUCTPLANTPROCUREMENT" />|  &
               | <sadl:dataSource type="CDS" name="A_PRODUCTSALESDELIVERY" binding="A_PRODUCTSALESDELIVERY" />|  &
               | <sadl:dataSource type="CDS" name="A_PRODUCTSALESTAX" binding="A_PRODUCTSALESTAX" />|  &
               | <sadl:dataSource type="CDS" name="A_PRODUCTSTORAGELOCATION" binding="A_PRODUCTSTORAGELOCATION" />|  &
               | <sadl:dataSource type="CDS" name="A_PRODUCTSUPPLYPLANNING" binding="A_PRODUCTSUPPLYPLANNING" />|  &
               | <sadl:dataSource type="CDS" name="A_PRODUCTWORKSCHEDULING" binding="A_PRODUCTWORKSCHEDULING" />|  &
               | <sadl:dataSource type="CDS" name="A_PRODUCTCHARCVALUE" binding="A_PRODUCTCHARCVALUE" />|  &
               | <sadl:dataSource type="CDS" name="A_PRODUCTCLASS" binding="A_PRODUCTCLASS" />|  &
               |<sadl:resultSet>|  &
               |<sadl:structure name="A_ClfnClassForKeyDate" dataSource="A_CLFNCLASSFORKEYDATE" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="A_ProductClassCharc" dataSource="A_PRODUCTCLASSCHARC" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               | <sadl:association name="TO_VALUATION" binding="_VALUATION" target="A_ProductCharcValue" cardinality="zeroToMany" />|  &
               |</sadl:structure>|  &
               |<sadl:structure name="A_ProductDescription" dataSource="A_PRODUCTDESCRIPTION" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="A_ProductPlant" dataSource="A_PRODUCTPLANT" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               | <sadl:association name="TO_PRODUCTPLANTPROCUREMENT" binding="_PRODUCTPLANTPROCUREMENT" target="A_ProductPlantProcurement" cardinality="zeroToOne" />|  &
               | <sadl:association name="TO_PRODUCTSUPPLYPLANNING" binding="_PRODUCTSUPPLYPLANNING" target="A_ProductSupplyPlanning" cardinality="zeroToOne" />|  &
               | <sadl:association name="TO_PRODUCTWORKSCHEDULING" binding="_PRODUCTWORKSCHEDULING" target="A_ProductWorkScheduling" cardinality="zeroToOne" />|  &
               | <sadl:association name="TO_STORAGELOCATION" binding="_STORAGELOCATION" target="A_ProductStorageLocation" cardinality="zeroToMany" />|  &
               |</sadl:structure>|  &
               |<sadl:structure name="A_ClfnProduct" dataSource="A_CLFNPRODUCT" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               | <sadl:association name="TO_SALESDELIVERY" binding="_SALESDELIVERY" target="A_ProductSalesDelivery" cardinality="zeroToMany" />|  &
               | <sadl:association name="TO_DESCRIPTION" binding="_DESCRIPTION" target="A_ProductDescription" cardinality="zeroToMany" />|  &
               | <sadl:association name="TO_PLANT" binding="_PLANT" target="A_ProductPlant" cardinality="zeroToMany" />|  &
               | <sadl:association name="TO_PRODUCTCHARC" binding="_PRODUCTCHARC" target="A_ProductCharc" cardinality="zeroToMany" />|  &
               | <sadl:association name="TO_PRODUCTCLASS" binding="_PRODUCTCLASS" target="A_ProductClass" cardinality="zeroToMany" />|  &
               | <sadl:association name="TO_PRODUCTSALESTAX" binding="_PRODUCTSALESTAX" target="A_ProductSalesTax" cardinality="zeroToMany" />|  &
               |</sadl:structure>|  &
               |<sadl:structure name="A_ProductCharc" dataSource="A_PRODUCTCHARC" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">| .
      lv_sadl_xml = |{ lv_sadl_xml }| &
               | </sadl:query>|  &
               | <sadl:association name="TO_VALUATION" binding="_VALUATION" target="A_ProductCharcValue" cardinality="zeroToMany" />|  &
               |</sadl:structure>|  &
               |<sadl:structure name="A_ProductPlantProcurement" dataSource="A_PRODUCTPLANTPROCUREMENT" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="A_ProductSalesDelivery" dataSource="A_PRODUCTSALESDELIVERY" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="A_ProductSalesTax" dataSource="A_PRODUCTSALESTAX" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="A_ProductStorageLocation" dataSource="A_PRODUCTSTORAGELOCATION" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="A_ProductSupplyPlanning" dataSource="A_PRODUCTSUPPLYPLANNING" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="A_ProductWorkScheduling" dataSource="A_PRODUCTWORKSCHEDULING" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="A_ProductCharcValue" dataSource="A_PRODUCTCHARCVALUE" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="A_ProductClass" dataSource="A_PRODUCTCLASS" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               | <sadl:association name="TO_CHARACTERISTICS" binding="_CHARACTERISTICS" target="A_ProductClassCharc" cardinality="zeroToMany" />|  &
               | <sadl:association name="TO_CLASSDETAILS" binding="_CLASSDETAILS" target="A_ClfnClassForKeyDate" cardinality="one" />|  &
               |</sadl:structure>|  &
               |</sadl:resultSet>|  &
               |</sadl:definition>| .

   ro_model_exposure = cl_sadl_gw_model_exposure=>get_exposure_xml( iv_uuid      = CONV #( 'API_CLFN_PRODUCT' )
                                                                    iv_timestamp = co_gen_timestamp
                                                                    iv_sadl_xml  = lv_sadl_xml ).
  endmethod.