  METHOD zif_abapgit_object~serialize.

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

        CREATE OBJECT lo_job_definition TYPE ('CL_JR_JOB_DEFINITION')
          EXPORTING
            im_jd_name = lv_name.

        CALL METHOD lo_job_definition->('GET_JD_ATTRIBUTES')
          IMPORTING
            ex_jd_attributes = <lg_job_definition>.

        ASSIGN COMPONENT 'JDPACKAGE' OF STRUCTURE <lg_job_definition> TO <lg_field>.
        CLEAR <lg_field>.

        ASSIGN COMPONENT 'BTCJOB_USER' OF STRUCTURE <lg_job_definition> TO <lg_field>.
        CLEAR <lg_field>.

        ASSIGN COMPONENT 'OWNER' OF STRUCTURE <lg_job_definition> TO <lg_field>.
        CLEAR <lg_field>.

        ASSIGN COMPONENT 'CREATED_DATE' OF STRUCTURE <lg_job_definition> TO <lg_field>.
        CLEAR <lg_field>.

        ASSIGN COMPONENT 'CREATED_TIME' OF STRUCTURE <lg_job_definition> TO <lg_field>.
        CLEAR <lg_field>.

        ASSIGN COMPONENT 'CHANGED_DATE' OF STRUCTURE <lg_job_definition> TO <lg_field>.
        CLEAR <lg_field>.

        ASSIGN COMPONENT 'CHANGED_TIME' OF STRUCTURE <lg_job_definition> TO <lg_field>.
        CLEAR <lg_field>.

        io_xml->add( iv_name = 'JOBD'
                     ig_data = <lg_job_definition> ).

      CATCH cx_root.
        zcx_abapgit_exception=>raise( |Error serializing JOBD| ).
    ENDTRY.

  ENDMETHOD.