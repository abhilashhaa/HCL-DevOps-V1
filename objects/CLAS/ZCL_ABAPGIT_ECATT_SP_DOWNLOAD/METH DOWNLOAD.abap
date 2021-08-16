  METHOD download.

    " We inherit from CL_APL_ECATT_DOWNLOAD because CL_APL_ECATT_SP_DOWNLOAD
    " doesn't exist in 702

    " Downport

    load_help = im_load_help.
    typ = im_object_type.

    TRY.
        cl_apl_ecatt_object=>show_object(
          EXPORTING
            im_obj_type = im_object_type
            im_name     = im_object_name
            im_version  = im_object_version
          IMPORTING
            re_object   = ecatt_object ).
      CATCH cx_ecatt INTO ex_ecatt.
        RETURN.
    ENDTRY.

    set_attributes_to_template( ).

    set_sp_data_to_template( ).

    download_data( ).

  ENDMETHOD.