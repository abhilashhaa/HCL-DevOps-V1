  PRIVATE SECTION.
    DATA:
      mv_objectname TYPE tobj-objct.

    METHODS:
      delete_documentation
        RAISING
          zcx_abapgit_exception,

      pre_check
        RAISING
          zcx_abapgit_exception.
