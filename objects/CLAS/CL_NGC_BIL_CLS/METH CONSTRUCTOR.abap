  METHOD constructor.

    mo_sy_message_convert   = io_sy_msg_convert.
    mo_vdm_api_mapper       = io_vdm_api_mapper.
    mo_bapi_message_convert = io_bapi_message_convert.
    mo_exc_message_convert  = io_exc_message_convert. "usage planned in later releases for mapping exceptions
    mo_ngc_db_access        = io_cls_bapi_util.

  ENDMETHOD.