interface IF_NGC_CORE_CLF_BTE
  public .


  methods BF_FUNCTIONS_FIND
    importing
      !I_EVENT type BUS_EVENT
      !I_INTCA type INTCA optional
      !I_APPLK type APPLK_BF optional
    exporting
      !T_FMRFC type STANDARD TABLE .
  methods OPEN_FI_PERFORM_00004002_E
    importing
      !I_ECM_NO type AENNR optional
      !I_DELOB_TAB type TT_RMCLDOB
      !I_ALLOCATION_TAB type RMCLKSSK_TAB
      !I_VALUE_TAB type RMCLAUSP_TAB .
endinterface.