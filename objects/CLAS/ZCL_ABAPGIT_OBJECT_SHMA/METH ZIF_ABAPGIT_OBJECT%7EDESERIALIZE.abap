  METHOD zif_abapgit_object~deserialize.

    DATA: lv_area_name       TYPE shm_area_name,
          ls_area_attributes TYPE shma_attributes.

    lv_area_name = ms_item-obj_name.

    io_xml->read(
      EXPORTING
        iv_name = 'AREA_ATTRIBUTES'
      CHANGING
        cg_data = ls_area_attributes ).

    tadir_insert( iv_package ).

    TRY.
        CALL METHOD ('\PROGRAM=SAPLSHMA\CLASS=LCL_SHMA_HELPER')=>('INSERT_AREA')
          EXPORTING
            area_name           = lv_area_name
            attributes          = ls_area_attributes
            force_overwrite     = abap_true
            no_class_generation = abap_true
            silent_mode         = abap_true.

      CATCH cx_root.
        zcx_abapgit_exception=>raise( |Error serializing SHMA { ms_item-obj_name }| ).
    ENDTRY.

  ENDMETHOD.