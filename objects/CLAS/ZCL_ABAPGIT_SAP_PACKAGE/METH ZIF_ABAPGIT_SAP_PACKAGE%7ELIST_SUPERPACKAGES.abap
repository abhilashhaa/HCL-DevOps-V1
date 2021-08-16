  METHOD zif_abapgit_sap_package~list_superpackages.

    DATA: lt_list   LIKE rt_list,
          lv_parent TYPE tdevc-parentcl.


    APPEND mv_package TO rt_list.

    lv_parent = zif_abapgit_sap_package~read_parent( ).

    IF sy-subrc = 0 AND NOT lv_parent IS INITIAL.
      lt_list = zcl_abapgit_factory=>get_sap_package( lv_parent )->list_superpackages( ).
      APPEND LINES OF lt_list TO rt_list.
    ENDIF.

  ENDMETHOD.