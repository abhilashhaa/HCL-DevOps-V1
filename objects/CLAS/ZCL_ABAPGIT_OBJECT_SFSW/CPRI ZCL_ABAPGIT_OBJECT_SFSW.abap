  PRIVATE SECTION.
    METHODS:
      get
        RETURNING VALUE(ro_switch) TYPE REF TO cl_sfw_sw
        RAISING   zcx_abapgit_exception,
      wait_for_background_job,
      wait_for_deletion
        RAISING
          zcx_abapgit_exception.
