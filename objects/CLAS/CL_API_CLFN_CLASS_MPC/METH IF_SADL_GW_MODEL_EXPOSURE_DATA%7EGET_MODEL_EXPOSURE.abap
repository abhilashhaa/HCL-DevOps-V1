  method IF_SADL_GW_MODEL_EXPOSURE_DATA~GET_MODEL_EXPOSURE.
    CONSTANTS: co_gen_timestamp TYPE timestamp VALUE '20180811221542'.
    DATA(lv_sadl_xml) =
               |<?xml version="1.0" encoding="utf-16"?>|  &
               |<sadl:definition xmlns:sadl="http://sap.com/sap.nw.f.sadl" syntaxVersion="" >|  &
               | <sadl:dataSource type="CDS" name="A_CLFNCLASSCHARCFORKEYDATE" binding="A_CLFNCLASSCHARCFORKEYDATE" />|  &
               | <sadl:dataSource type="CDS" name="A_CLFNCLASSKEYWORDFORKEYDATE" binding="A_CLFNCLASSKEYWORDFORKEYDATE" />|  &
               | <sadl:dataSource type="CDS" name="A_CLFNCLASSTEXTFORKEYDATE" binding="A_CLFNCLASSTEXTFORKEYDATE" />|  &
               | <sadl:dataSource type="CDS" name="A_CLFNCLASSDESCFORKEYDATE" binding="A_CLFNCLASSDESCFORKEYDATE" />|  &
               | <sadl:dataSource type="CDS" name="A_CLFNCLASSFORKEYDATE" binding="A_CLFNCLASSFORKEYDATE" />|  &
               |<sadl:resultSet>|  &
               |<sadl:structure name="A_ClfnClassCharcForKeyDate" dataSource="A_CLFNCLASSCHARCFORKEYDATE" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="A_ClfnClassKeywordForKeyDate" dataSource="A_CLFNCLASSKEYWORDFORKEYDATE" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="A_ClfnClassTextForKeyDate" dataSource="A_CLFNCLASSTEXTFORKEYDATE" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="A_ClfnClassDescForKeyDate" dataSource="A_CLFNCLASSDESCFORKEYDATE" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="A_ClfnClassForKeyDate" dataSource="A_CLFNCLASSFORKEYDATE" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               | <sadl:association name="TO_CLASSTEXT" binding="_CLASSTEXT" target="A_ClfnClassTextForKeyDate" cardinality="zeroToMany" />|  &
               | <sadl:association name="TO_CLASSCHARACTERISTIC" binding="_CLASSCHARACTERISTIC" target="A_ClfnClassCharcForKeyDate" cardinality="zeroToMany" />|  &
               | <sadl:association name="TO_CLASSDESCRIPTION" binding="_CLASSDESCRIPTION" target="A_ClfnClassDescForKeyDate" cardinality="zeroToMany" />|  &
               | <sadl:association name="TO_CLASSKEYWORD" binding="_CLASSKEYWORD" target="A_ClfnClassKeywordForKeyDate" cardinality="zeroToMany" />|  &
               |</sadl:structure>|  &
               |</sadl:resultSet>|  &
               |</sadl:definition>| .

   ro_model_exposure = cl_sadl_gw_model_exposure=>get_exposure_xml( iv_uuid      = CONV #( 'API_CLFN_CLASS' )
                                                                    iv_timestamp = co_gen_timestamp
                                                                    iv_sadl_xml  = lv_sadl_xml ).
  endmethod.