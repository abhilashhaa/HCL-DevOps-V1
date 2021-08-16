  METHOD run_measurement.
    DATA: li_actual_progress TYPE REF TO zif_abapgit_progress,
          lt_tadir           TYPE zif_abapgit_definitions=>ty_tadir_tt,
          lt_tadir_single    TYPE zif_abapgit_definitions=>ty_tadir_tt,
          lo_serializer      TYPE REF TO zcl_abapgit_serialize,
          lv_start_runtime   TYPE i,
          lv_end_runtime     TYPE i,
          lx_exception       TYPE REF TO zcx_abapgit_exception,
          lo_dummy_progress  TYPE REF TO lcl_dummy_progress.
    FIELD-SYMBOLS: <ls_tadir>  TYPE zif_abapgit_definitions=>ty_tadir,
                   <ls_result> TYPE gty_result.

    CLEAR mt_result.

    li_actual_progress = zcl_abapgit_progress=>get_instance( 1 ).
    CREATE OBJECT lo_dummy_progress.
    zcl_abapgit_progress=>set_instance( lo_dummy_progress ).

    TRY.
        lt_tadir = select_tadir_entries( ).

        CREATE OBJECT lo_serializer
          EXPORTING
            iv_serialize_master_lang_only = mv_serialize_master_lang_only.

        LOOP AT lt_tadir ASSIGNING <ls_tadir>.
          INSERT <ls_tadir> INTO TABLE lt_tadir_single.

          GET RUN TIME FIELD lv_start_runtime.

          lo_serializer->serialize(
            it_tadir            = lt_tadir_single
            iv_force_sequential = abap_true ).

          GET RUN TIME FIELD lv_end_runtime.

          APPEND INITIAL LINE TO mt_result ASSIGNING <ls_result>.
          <ls_result>-pgmid = <ls_tadir>-pgmid.
          <ls_result>-object = <ls_tadir>-object.
          <ls_result>-obj_name = <ls_tadir>-obj_name.
          <ls_result>-devclass = <ls_tadir>-devclass.
          <ls_result>-runtime = lv_end_runtime - lv_start_runtime.
          <ls_result>-seconds = <ls_result>-runtime / 1000000.

          CLEAR lt_tadir_single.
        ENDLOOP.

      CATCH zcx_abapgit_exception INTO lx_exception.
        zcl_abapgit_progress=>set_instance( li_actual_progress ).
        RAISE EXCEPTION lx_exception.
    ENDTRY.
  ENDMETHOD.