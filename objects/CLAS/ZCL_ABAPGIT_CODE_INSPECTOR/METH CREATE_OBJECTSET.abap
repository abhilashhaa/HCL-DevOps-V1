  METHOD create_objectset.

    DATA: lt_objs       TYPE scit_objs,
          ls_obj        TYPE scir_objs,
          lt_objs_check TYPE scit_objs,
          ls_item       TYPE zif_abapgit_definitions=>ty_item,
          lt_packages   TYPE zif_abapgit_sap_package=>ty_devclass_tt.

    lt_packages = zcl_abapgit_factory=>get_sap_package( mv_package )->list_subpackages( ).
    INSERT mv_package INTO TABLE lt_packages.

    SELECT object AS objtype obj_name AS objname
      FROM tadir
      INTO CORRESPONDING FIELDS OF TABLE lt_objs
      FOR ALL ENTRIES IN lt_packages
      WHERE devclass = lt_packages-table_line
      AND delflag = abap_false
      AND pgmid = 'R3TR'.                               "#EC CI_GENBUFF

    LOOP AT lt_objs INTO ls_obj.

      IF skip_object( ls_obj ) = abap_true.
        CONTINUE.
      ENDIF.

      ls_item-obj_type = ls_obj-objtype.
      ls_item-obj_name = ls_obj-objname.

      IF zcl_abapgit_objects=>exists( ls_item ) = abap_false.
        CONTINUE.
      ENDIF.

      INSERT ls_obj INTO TABLE lt_objs_check.

    ENDLOOP.

    ro_set = cl_ci_objectset=>save_from_list(
      p_name    = mv_name
      p_objects = lt_objs_check ).

  ENDMETHOD.