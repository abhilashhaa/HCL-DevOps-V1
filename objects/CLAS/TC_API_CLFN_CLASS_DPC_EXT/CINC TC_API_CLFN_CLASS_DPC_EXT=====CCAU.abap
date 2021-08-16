*"* use this source file for your ABAP unit test classes
CLASS ltc_classcharacteristic DEFINITION FOR TESTING RISK LEVEL HARMLESS DURATION SHORT FINAL
  INHERITING FROM tc_api_clfn_class_dpc_ext.
  PROTECTED SECTION.
*    METHODS enforce_rt_factory_exception REDEFINITION.
ENDCLASS.
CLASS ltc_classcharacteristic IMPLEMENTATION.
*  METHOD enforce_rt_factory_exception.
*    "The RT Factory exceptions can only be tested directly in CL_LO_VCHCLF_DPC_EXT
*    rv_not_possible = 'NOT_POSSIBLE'.
*  ENDMETHOD.
ENDCLASS.