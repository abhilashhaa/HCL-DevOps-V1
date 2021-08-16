  METHOD set_default_package.

    " In certain cases we need to set the package package via ABAP memory
    " because we can't supply it via the APIs.
    "
    " Set default package, see function module RS_CORR_INSERT FORM get_current_devclass.
    "
    " We use ABAP memory instead the SET parameter because it is
    " more reliable. SET parameter doesn't work when multiple objects
    " are deserialized which uses the ABAP memory mechanism.
    " We don't need to reset the memory as it is done in above mentioned form routine.

    EXPORT current_devclass FROM iv_package TO MEMORY ID 'EUK'.

  ENDMETHOD.