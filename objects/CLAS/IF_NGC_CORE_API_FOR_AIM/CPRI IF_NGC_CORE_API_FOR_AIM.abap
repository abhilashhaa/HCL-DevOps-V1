PRIVATE SECTION.

  CONSTANTS:
    BEGIN OF gc_s_api,
      class_create          TYPE slapi_id VALUE 'CLFN_CLASS_CREATE',
      class_read            TYPE slapi_id VALUE 'CLFN_CLASS_READ',
      characteristic_create TYPE slapi_id VALUE 'CLFN_CHARACTERISTIC_CREATE',
      characteristic_read   TYPE slapi_id VALUE 'CLFN_CHARACTERISTIC_READ',
    END OF gc_s_api.