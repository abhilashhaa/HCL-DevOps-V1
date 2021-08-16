  PROTECTED SECTION.
    METHODS:
      get_object_type ABSTRACT
        RETURNING VALUE(rv_object_type) TYPE etobj_type,

      get_upload ABSTRACT
        RETURNING
          VALUE(ro_upload) TYPE REF TO cl_apl_ecatt_upload,

      get_download ABSTRACT
        RETURNING
          VALUE(ro_download) TYPE REF TO cl_apl_ecatt_download,

      get_lock_object ABSTRACT
        RETURNING
          VALUE(rv_lock_object) TYPE eqeobj.
