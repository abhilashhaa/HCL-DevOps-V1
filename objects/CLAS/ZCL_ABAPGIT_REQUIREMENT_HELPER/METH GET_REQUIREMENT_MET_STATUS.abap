  METHOD get_requirement_met_status.

    DATA: lt_installed TYPE STANDARD TABLE OF cvers_sdu.

    FIELD-SYMBOLS: <ls_requirement>    TYPE zif_abapgit_dot_abapgit=>ty_requirement,
                   <ls_status>         TYPE ty_requirement_status,
                   <ls_installed_comp> TYPE cvers_sdu.


    CALL FUNCTION 'DELIVERY_GET_INSTALLED_COMPS'
      TABLES
        tt_comptab       = lt_installed
      EXCEPTIONS
        no_release_found = 1
        OTHERS           = 2.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error from DELIVERY_GET_INSTALLED_COMPS { sy-subrc }| ).
    ENDIF.

    LOOP AT it_requirements ASSIGNING <ls_requirement>.
      APPEND INITIAL LINE TO rt_status ASSIGNING <ls_status>.
      <ls_status>-component = <ls_requirement>-component.
      <ls_status>-required_release = <ls_requirement>-min_release.
      <ls_status>-required_patch = <ls_requirement>-min_patch.

      READ TABLE lt_installed WITH KEY component = <ls_requirement>-component
                              ASSIGNING <ls_installed_comp>.
      IF sy-subrc = 0.
        " Component is installed, requirement is met if the installed version is greater or equal
        " to the required one.
        <ls_status>-installed_release = <ls_installed_comp>-release.
        <ls_status>-installed_patch = <ls_installed_comp>-extrelease.
        <ls_status>-description = <ls_installed_comp>-desc_text.
        <ls_status>-met = version_greater_or_equal( <ls_status> ).
      ELSE.
        " Component is not installed at all
        <ls_status>-met = abap_false.
      ENDIF.

      UNASSIGN <ls_installed_comp>.
    ENDLOOP.

  ENDMETHOD.