  METHOD get_instance.

* max one progress indicator at a time is supported

    IF gi_progress IS INITIAL.
      CREATE OBJECT gi_progress TYPE zcl_abapgit_progress.
    ENDIF.

    gi_progress->set_total( iv_total ).

    ri_progress = gi_progress.

  ENDMETHOD.