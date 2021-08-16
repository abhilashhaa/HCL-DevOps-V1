  METHOD zif_abapgit_object~serialize.

    DATA: lv_area_name       TYPE shm_area_name,
          ls_area_attributes TYPE shma_attributes.

    lv_area_name = ms_item-obj_name.

    TRY.
        CALL METHOD ('\PROGRAM=SAPLSHMA\CLASS=LCL_SHMA_HELPER')=>('READ_AREA_ATTRIBUTES_ALL')
          EXPORTING
            area_name       = lv_area_name
          IMPORTING
            area_attributes = ls_area_attributes.

        CLEAR: ls_area_attributes-chg_user,
               ls_area_attributes-chg_date,
               ls_area_attributes-chg_time,
               ls_area_attributes-cls_gen_user,
               ls_area_attributes-cls_gen_date,
               ls_area_attributes-cls_gen_time.

        io_xml->add( iv_name = 'AREA_ATTRIBUTES'
                     ig_data = ls_area_attributes ).

      CATCH cx_root.
        zcx_abapgit_exception=>raise( |Error serializing SHMA { ms_item-obj_name }| ).
    ENDTRY.

  ENDMETHOD.