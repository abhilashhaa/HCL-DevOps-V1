  method /BOBF/IF_FRW_DETERMINATION~EXECUTE.

*  data lt_data type table of zcr_i_h1.
*
*break-point.
*  io_read->RETRIEVE(
*    exporting
*      IV_NODE                 = is_ctx-NODE_KEY    " Node Name
*      IT_KEY                  = it_key    " Key Table
**      IV_BEFORE_IMAGE         = ABAP_FALSE    " Data Element for Domain BOOLE: TRUE (="X") and FALSE (=" ")
**      IV_FILL_DATA            = ABAP_TRUE    " Data element for domain BOOLE: TRUE (='X') and FALSE (=' ')
**      IT_REQUESTED_ATTRIBUTES =     " List of Names (e.g. Fieldnames)
*    importing
**      EO_MESSAGE              = EO_MESSAGE    " Message Object
*      ET_DATA                 = lt_data    " Data Return Structure
**      ET_FAILED_KEY           = ET_FAILED_KEY    " Key Table
**      ET_NODE_CAT             = et_fail    " Node Category Assignment
*  ).
*
*select MAX( request_id ) from zcr_h1 INTO @data(lv_max_id).
*
*LOOP AT LT_DATA REFERENCE INTO data(lr_data).
*  add 1 to lv_max_id.
*
*  lr_data->REQUEST_ID = lv_max_id.
*
*  IO_MODIFY->UPDATE(
*    exporting
*      IV_NODE           = is_ctx-NODE_KEY    " Node
*      IV_KEY            = is_ctx-DET_KEY    " Key
**      IV_ROOT_KEY       =     " NodeID
*      IS_DATA           = lr_data    " Data
*      IT_CHANGED_FIELDS = VALUE #( ( ZIF_CR_I_H1_C=>SC_NODE_ATTRIBUTE-ZCR_I_H1-REQUEST_ID ) )    " List of Names (e.g. Fieldnames)
*  ).
*
*ENDLOOP.

  endmethod.