  METHOD collect_all_objects.

    DATA:
      lt_objects     TYPE scts_tadir,
      lt_objects_all LIKE lt_objects,
      ls_e071        LIKE LINE OF rt_objects,
      lo_repo        TYPE REF TO zcl_abapgit_repo,
      lv_package     TYPE zif_abapgit_persistence=>ty_repo-package,
      lt_packages    TYPE zif_abapgit_sap_package=>ty_devclass_tt.

    FIELD-SYMBOLS:
      <lv_package> TYPE devclass,
      <ls_object>  TYPE tadir.

    lo_repo     = zcl_abapgit_repo_srv=>get_instance( )->get( iv_key ).
    lv_package  = lo_repo->get_package( ).
    lt_packages = zcl_abapgit_factory=>get_sap_package( lv_package )->list_subpackages( ).
    INSERT lv_package INTO TABLE lt_packages.

    LOOP AT lt_packages ASSIGNING <lv_package>.

      CLEAR: lt_objects.

      CALL FUNCTION 'TRINT_SELECT_OBJECTS'
        EXPORTING
          iv_devclass       = <lv_package>
          iv_via_selscreen  = abap_false
        IMPORTING
          et_objects_tadir  = lt_objects
        EXCEPTIONS
          cancelled_by_user = 1
          invalid_input     = 2
          OTHERS            = 3.

      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise( |FM TRINT_SELECT_OBJECTS subrc={ sy-subrc }| ).
      ENDIF.

      INSERT LINES OF lt_objects INTO TABLE lt_objects_all.

    ENDLOOP.

    IF lines( lt_objects_all ) = 0.
      zcx_abapgit_exception=>raise( |No objects found| ).
    ENDIF.

    LOOP AT lt_objects_all ASSIGNING <ls_object>.

      CLEAR: ls_e071.

      MOVE-CORRESPONDING <ls_object> TO ls_e071.
      INSERT ls_e071 INTO TABLE rt_objects.

    ENDLOOP.

  ENDMETHOD.