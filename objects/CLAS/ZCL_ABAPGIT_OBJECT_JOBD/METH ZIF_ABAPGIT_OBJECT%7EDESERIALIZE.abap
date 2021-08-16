  METHOD zif_abapgit_object~deserialize.

    DATA: lr_job_definition TYPE REF TO data,
          lo_job_definition TYPE REF TO object,
          lv_name           TYPE ty_jd_name.

    FIELD-SYMBOLS: <lg_job_definition> TYPE any,
                   <lg_field>          TYPE any.


    lv_name = ms_item-obj_name.

    TRY.
        CREATE DATA lr_job_definition TYPE ('CL_JR_JOB_DEFINITION=>TY_JOB_DEFINITION').
        ASSIGN lr_job_definition->* TO <lg_job_definition>.
        ASSERT sy-subrc = 0.

        io_xml->read(
          EXPORTING
            iv_name = 'JOBD'
          CHANGING
            cg_data = <lg_job_definition> ).

        CREATE OBJECT lo_job_definition TYPE ('CL_JR_JOB_DEFINITION')
          EXPORTING
            im_jd_name = lv_name.

        ASSIGN COMPONENT 'JDPACKAGE' OF STRUCTURE <lg_job_definition> TO <lg_field>.

        <lg_field> = iv_package.

        CALL METHOD lo_job_definition->('CREATE_JD')
          EXPORTING
            im_jd_attributes = <lg_job_definition>.

      CATCH cx_root.
        zcx_abapgit_exception=>raise( |Error deserializing JOBD| ).
    ENDTRY.

    zcl_abapgit_objects_activation=>add_item( ms_item ).

  ENDMETHOD.