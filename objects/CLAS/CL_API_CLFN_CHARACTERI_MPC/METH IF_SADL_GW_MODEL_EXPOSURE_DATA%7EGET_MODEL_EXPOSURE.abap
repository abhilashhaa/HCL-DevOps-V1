  method IF_SADL_GW_MODEL_EXPOSURE_DATA~GET_MODEL_EXPOSURE.
    CONSTANTS: co_gen_timestamp TYPE timestamp VALUE '20190607132419'.
    DATA(lv_sadl_xml) =
               |<?xml version="1.0" encoding="utf-16"?>|  &
               |<sadl:definition xmlns:sadl="http://sap.com/sap.nw.f.sadl" syntaxVersion="" >|  &
               | <sadl:dataSource type="CDS" name="A_CLFNCHARACTERISTICFORKEYDATE" binding="A_CLFNCHARACTERISTICFORKEYDATE" />|  &
               | <sadl:dataSource type="CDS" name="A_CLFNCHARCDESCFORKEYDATE" binding="A_CLFNCHARCDESCFORKEYDATE" />|  &
               | <sadl:dataSource type="CDS" name="A_CLFNCHARCREFFORKEYDATE" binding="A_CLFNCHARCREFFORKEYDATE" />|  &
               | <sadl:dataSource type="CDS" name="A_CLFNCHARCRSTRCNFORKEYDATE" binding="A_CLFNCHARCRSTRCNFORKEYDATE" />|  &
               | <sadl:dataSource type="CDS" name="A_CLFNCHARCVALUEDESCFORKEYDATE" binding="A_CLFNCHARCVALUEDESCFORKEYDATE" />|  &
               | <sadl:dataSource type="CDS" name="A_CLFNCHARCVALUEFORKEYDATE" binding="A_CLFNCHARCVALUEFORKEYDATE" />|  &
               |<sadl:resultSet>|  &
               |<sadl:structure name="A_ClfnCharacteristicForKeyDate" dataSource="A_CLFNCHARACTERISTICFORKEYDATE" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               | <sadl:association name="TO_CHARACTERISTICDESC" binding="_CHARACTERISTICDESC" target="A_ClfnCharcDescForKeyDate" cardinality="oneToMany" />|  &
               | <sadl:association name="TO_CHARACTERISTICREFERENCE" binding="_CHARACTERISTICREFERENCE" target="A_ClfnCharcRefForKeyDate" cardinality="zeroToMany" />|  &
               | <sadl:association name="TO_CHARACTERISTICRESTRICTION" binding="_CHARACTERISTICRESTRICTION" target="A_ClfnCharcRstrcnForKeyDate" cardinality="zeroToMany" />|  &
               | <sadl:association name="TO_CHARACTERISTICVALUE" binding="_CHARACTERISTICVALUE" target="A_ClfnCharcValueForKeyDate" cardinality="zeroToMany" />|  &
               |</sadl:structure>|  &
               |<sadl:structure name="A_ClfnCharcDescForKeyDate" dataSource="A_CLFNCHARCDESCFORKEYDATE" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="A_ClfnCharcRefForKeyDate" dataSource="A_CLFNCHARCREFFORKEYDATE" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="A_ClfnCharcRstrcnForKeyDate" dataSource="A_CLFNCHARCRSTRCNFORKEYDATE" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="A_ClfnCharcValueDescForKeyDate" dataSource="A_CLFNCHARCVALUEDESCFORKEYDATE" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="A_ClfnCharcValueForKeyDate" dataSource="A_CLFNCHARCVALUEFORKEYDATE" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               | <sadl:association name="TO_CHARCVALUEDESC" binding="_CHARCVALUEDESC" target="A_ClfnCharcValueDescForKeyDate" cardinality="zeroToMany" />|  &
               |</sadl:structure>|  &
               |</sadl:resultSet>|  &
               |</sadl:definition>| .

   ro_model_exposure = cl_sadl_gw_model_exposure=>get_exposure_xml( iv_uuid      = CONV #( 'API_CLFN_CHARACTERISTIC' )
                                                                    iv_timestamp = co_gen_timestamp
                                                                    iv_sadl_xml  = lv_sadl_xml ).
  endmethod.