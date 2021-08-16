  method IF_SADL_GW_DPC_UTIL~GET_DPC.
    TYPES ty_a_clfnclassforkeydate_1 TYPE a_clfnclassforkeydate ##NEEDED. " reference for where-used list
    TYPES ty_a_clfnproduct_2 TYPE a_clfnproduct ##NEEDED. " reference for where-used list
    TYPES ty_a_productcharc_3 TYPE a_productcharc ##NEEDED. " reference for where-used list
    TYPES ty_a_productcharcvalue_4 TYPE a_productcharcvalue ##NEEDED. " reference for where-used list
    TYPES ty_a_productclass_5 TYPE a_productclass ##NEEDED. " reference for where-used list
    TYPES ty_a_productclasscharc_6 TYPE a_productclasscharc ##NEEDED. " reference for where-used list
    TYPES ty_a_productdescription_7 TYPE a_productdescription ##NEEDED. " reference for where-used list
    TYPES ty_a_productplant_8 TYPE a_productplant ##NEEDED. " reference for where-used list
    TYPES ty_a_productplantprocureme_9 TYPE a_productplantprocurement ##NEEDED. " reference for where-used list
    TYPES ty_a_productsalesdelivery_10 TYPE a_productsalesdelivery ##NEEDED. " reference for where-used list
    TYPES ty_a_productsalestax_11 TYPE a_productsalestax ##NEEDED. " reference for where-used list
    TYPES ty_a_productstoragelocatio_12 TYPE a_productstoragelocation ##NEEDED. " reference for where-used list
    TYPES ty_a_productsupplyplanning_13 TYPE a_productsupplyplanning ##NEEDED. " reference for where-used list
    TYPES ty_a_productworkscheduling_14 TYPE a_productworkscheduling ##NEEDED. " reference for where-used list

    DATA(lv_sadl_xml) =
               |<?xml version="1.0" encoding="utf-16"?>| &
               |<sadl:definition xmlns:sadl="http://sap.com/sap.nw.f.sadl" syntaxVersion="" >| &
               | <sadl:dataSource type="CDS" name="A_CLFNCLASSFORKEYDATE" binding="A_CLFNCLASSFORKEYDATE" />| &
               | <sadl:dataSource type="CDS" name="A_PRODUCTCLASSCHARC" binding="A_PRODUCTCLASSCHARC" />| &
               | <sadl:dataSource type="CDS" name="A_PRODUCTDESCRIPTION" binding="A_PRODUCTDESCRIPTION" />| &
               | <sadl:dataSource type="CDS" name="A_PRODUCTPLANT" binding="A_PRODUCTPLANT" />| &
               | <sadl:dataSource type="CDS" name="A_CLFNPRODUCT" binding="A_CLFNPRODUCT" />| &
               | <sadl:dataSource type="CDS" name="A_PRODUCTCHARC" binding="A_PRODUCTCHARC" />| &
               | <sadl:dataSource type="CDS" name="A_PRODUCTPLANTPROCUREMENT" binding="A_PRODUCTPLANTPROCUREMENT" />| &
               | <sadl:dataSource type="CDS" name="A_PRODUCTSALESDELIVERY" binding="A_PRODUCTSALESDELIVERY" />| &
               | <sadl:dataSource type="CDS" name="A_PRODUCTSALESTAX" binding="A_PRODUCTSALESTAX" />| &
               | <sadl:dataSource type="CDS" name="A_PRODUCTSTORAGELOCATION" binding="A_PRODUCTSTORAGELOCATION" />| &
               | <sadl:dataSource type="CDS" name="A_PRODUCTSUPPLYPLANNING" binding="A_PRODUCTSUPPLYPLANNING" />| &
               | <sadl:dataSource type="CDS" name="A_PRODUCTWORKSCHEDULING" binding="A_PRODUCTWORKSCHEDULING" />| &
               | <sadl:dataSource type="CDS" name="A_PRODUCTCHARCVALUE" binding="A_PRODUCTCHARCVALUE" />| &
               | <sadl:dataSource type="CDS" name="A_PRODUCTCLASS" binding="A_PRODUCTCLASS" />| &
               |<sadl:resultSet>| &
               |<sadl:structure name="A_ClfnClassForKeyDate" dataSource="A_CLFNCLASSFORKEYDATE" maxEditMode="RO" exposure="TRUE" >| &
               | <sadl:query name="SADL_QUERY">| &
               | </sadl:query>| &
               |</sadl:structure>| &
               |<sadl:structure name="A_ProductClassCharc" dataSource="A_PRODUCTCLASSCHARC" maxEditMode="RO" exposure="TRUE" >| &
               | <sadl:query name="SADL_QUERY">| &
               | </sadl:query>| &
               | <sadl:association name="TO_VALUATION" binding="_VALUATION" target="A_ProductCharcValue" cardinality="zeroToMany" />| &
               |</sadl:structure>| &
               |<sadl:structure name="A_ProductDescription" dataSource="A_PRODUCTDESCRIPTION" maxEditMode="RO" exposure="TRUE" >| &
               | <sadl:query name="SADL_QUERY">| &
               | </sadl:query>| &
               |</sadl:structure>| &
               |<sadl:structure name="A_ProductPlant" dataSource="A_PRODUCTPLANT" maxEditMode="RO" exposure="TRUE" >| &
               | <sadl:query name="SADL_QUERY">| &
               | </sadl:query>| &
               | <sadl:association name="TO_PRODUCTPLANTPROCUREMENT" binding="_PRODUCTPLANTPROCUREMENT" target="A_ProductPlantProcurement" cardinality="zeroToOne" />| &
               | <sadl:association name="TO_PRODUCTSUPPLYPLANNING" binding="_PRODUCTSUPPLYPLANNING" target="A_ProductSupplyPlanning" cardinality="zeroToOne" />| &
               | <sadl:association name="TO_PRODUCTWORKSCHEDULING" binding="_PRODUCTWORKSCHEDULING" target="A_ProductWorkScheduling" cardinality="zeroToOne" />| &
               | <sadl:association name="TO_STORAGELOCATION" binding="_STORAGELOCATION" target="A_ProductStorageLocation" cardinality="zeroToMany" />| &
               |</sadl:structure>| &
               |<sadl:structure name="A_ClfnProduct" dataSource="A_CLFNPRODUCT" maxEditMode="RO" exposure="TRUE" >| &
               | <sadl:query name="SADL_QUERY">| &
               | </sadl:query>| &
               | <sadl:association name="TO_SALESDELIVERY" binding="_SALESDELIVERY" target="A_ProductSalesDelivery" cardinality="zeroToMany" />| &
               | <sadl:association name="TO_DESCRIPTION" binding="_DESCRIPTION" target="A_ProductDescription" cardinality="zeroToMany" />| &
               | <sadl:association name="TO_PLANT" binding="_PLANT" target="A_ProductPlant" cardinality="zeroToMany" />| &
               | <sadl:association name="TO_PRODUCTCHARC" binding="_PRODUCTCHARC" target="A_ProductCharc" cardinality="zeroToMany" />| &
               | <sadl:association name="TO_PRODUCTCLASS" binding="_PRODUCTCLASS" target="A_ProductClass" cardinality="zeroToMany" />| &
               | <sadl:association name="TO_PRODUCTSALESTAX" binding="_PRODUCTSALESTAX" target="A_ProductSalesTax" cardinality="zeroToMany" />| &
               |</sadl:structure>| &
               |<sadl:structure name="A_ProductCharc" dataSource="A_PRODUCTCHARC" maxEditMode="RO" exposure="TRUE" >| &
               | <sadl:query name="SADL_QUERY">| .
    lv_sadl_xml = |{ lv_sadl_xml }| &
             | </sadl:query>| &
             | <sadl:association name="TO_VALUATION" binding="_VALUATION" target="A_ProductCharcValue" cardinality="zeroToMany" />| &
             |</sadl:structure>| &
             |<sadl:structure name="A_ProductPlantProcurement" dataSource="A_PRODUCTPLANTPROCUREMENT" maxEditMode="RO" exposure="TRUE" >| &
             | <sadl:query name="SADL_QUERY">| &
             | </sadl:query>| &
             |</sadl:structure>| &
             |<sadl:structure name="A_ProductSalesDelivery" dataSource="A_PRODUCTSALESDELIVERY" maxEditMode="RO" exposure="TRUE" >| &
             | <sadl:query name="SADL_QUERY">| &
             | </sadl:query>| &
             |</sadl:structure>| &
             |<sadl:structure name="A_ProductSalesTax" dataSource="A_PRODUCTSALESTAX" maxEditMode="RO" exposure="TRUE" >| &
             | <sadl:query name="SADL_QUERY">| &
             | </sadl:query>| &
             |</sadl:structure>| &
             |<sadl:structure name="A_ProductStorageLocation" dataSource="A_PRODUCTSTORAGELOCATION" maxEditMode="RO" exposure="TRUE" >| &
             | <sadl:query name="SADL_QUERY">| &
             | </sadl:query>| &
             |</sadl:structure>| &
             |<sadl:structure name="A_ProductSupplyPlanning" dataSource="A_PRODUCTSUPPLYPLANNING" maxEditMode="RO" exposure="TRUE" >| &
             | <sadl:query name="SADL_QUERY">| &
             | </sadl:query>| &
             |</sadl:structure>| &
             |<sadl:structure name="A_ProductWorkScheduling" dataSource="A_PRODUCTWORKSCHEDULING" maxEditMode="RO" exposure="TRUE" >| &
             | <sadl:query name="SADL_QUERY">| &
             | </sadl:query>| &
             |</sadl:structure>| &
             |<sadl:structure name="A_ProductCharcValue" dataSource="A_PRODUCTCHARCVALUE" maxEditMode="RO" exposure="TRUE" >| &
             | <sadl:query name="SADL_QUERY">| &
             | </sadl:query>| &
             |</sadl:structure>| &
             |<sadl:structure name="A_ProductClass" dataSource="A_PRODUCTCLASS" maxEditMode="RO" exposure="TRUE" >| &
             | <sadl:query name="SADL_QUERY">| &
             | </sadl:query>| &
             | <sadl:association name="TO_CHARACTERISTICS" binding="_CHARACTERISTICS" target="A_ProductClassCharc" cardinality="zeroToMany" />| &
             | <sadl:association name="TO_CLASSDETAILS" binding="_CLASSDETAILS" target="A_ClfnClassForKeyDate" cardinality="one" />| &
             |</sadl:structure>| &
             |</sadl:resultSet>| &
             |</sadl:definition>| .
    ro_dpc = cl_sadl_gw_dpc_factory=>create_for_sadl( iv_sadl_xml   = lv_sadl_xml
               iv_timestamp         = 20170830123801
               iv_uuid              = 'API_CLFN_PRODUCT'
               io_context           = me->mo_context ).
  endmethod.