  METHOD build.

    DATA: lv_path         TYPE string,
          lo_skip_objects TYPE REF TO zcl_abapgit_skip_objects,
          lt_excludes     TYPE RANGE OF trobjtype,
          lt_srcsystem    TYPE RANGE OF tadir-srcsystem,
          ls_srcsystem    LIKE LINE OF lt_srcsystem,
          ls_exclude      LIKE LINE OF lt_excludes,
          lo_folder_logic TYPE REF TO zcl_abapgit_folder_logic,
          lv_last_package TYPE devclass VALUE cl_abap_char_utilities=>horizontal_tab,
          lt_packages     TYPE zif_abapgit_sap_package=>ty_devclass_tt.

    FIELD-SYMBOLS: <ls_tadir>   LIKE LINE OF rt_tadir,
                   <lv_package> LIKE LINE OF lt_packages.


    "Determine Packages to Read
    IF iv_ignore_subpackages = abap_false.
      lt_packages = zcl_abapgit_factory=>get_sap_package( iv_package )->list_subpackages( ).
    ENDIF.
    INSERT iv_package INTO lt_packages INDEX 1.

    ls_exclude-sign = 'I'.
    ls_exclude-option = 'EQ'.

    ls_exclude-low = 'SOTR'.
    APPEND ls_exclude TO lt_excludes.
    ls_exclude-low = 'SFB1'.
    APPEND ls_exclude TO lt_excludes.
    ls_exclude-low = 'SFB2'.
    APPEND ls_exclude TO lt_excludes.
    ls_exclude-low = 'STOB'. " auto generated by core data services
    APPEND ls_exclude TO lt_excludes.

    IF iv_only_local_objects = abap_true.
      ls_srcsystem-sign   = 'I'.
      ls_srcsystem-option = 'EQ'.
      ls_srcsystem-low    = sy-sysid.
      APPEND ls_srcsystem TO lt_srcsystem.
    ENDIF.

    IF lt_packages IS NOT INITIAL.
      SELECT * FROM tadir
        INTO CORRESPONDING FIELDS OF TABLE rt_tadir
        FOR ALL ENTRIES IN lt_packages
        WHERE devclass = lt_packages-table_line
        AND pgmid = 'R3TR'
        AND object NOT IN lt_excludes
        AND delflag = abap_false
        AND srcsystem IN lt_srcsystem
        ORDER BY PRIMARY KEY ##TOO_MANY_ITAB_FIELDS. "#EC CI_GENBUFF "#EC CI_SUBRC
    ENDIF.

    SORT rt_tadir BY devclass pgmid object obj_name.

    CREATE OBJECT lo_skip_objects.
    rt_tadir = lo_skip_objects->skip_sadl_generated_objects(
      it_tadir = rt_tadir
      ii_log   = ii_log ).

    LOOP AT lt_packages ASSIGNING <lv_package>.
      " Local packages are not in TADIR, only in TDEVC, act as if they were
      IF <lv_package> CP '$*'. " OR <package> CP 'T*' ).
        APPEND INITIAL LINE TO rt_tadir ASSIGNING <ls_tadir>.
        <ls_tadir>-pgmid    = 'R3TR'.
        <ls_tadir>-object   = 'DEVC'.
        <ls_tadir>-obj_name = <lv_package>.
        <ls_tadir>-devclass = <lv_package>.
      ENDIF.
    ENDLOOP.

    LOOP AT rt_tadir ASSIGNING <ls_tadir>.

      IF lv_last_package <> <ls_tadir>-devclass.
        "Change in Package
        lv_last_package = <ls_tadir>-devclass.

        IF NOT io_dot IS INITIAL.
          "Reuse given Folder Logic Instance
          IF lo_folder_logic IS NOT BOUND.
            "Get Folder Logic Instance
            lo_folder_logic = zcl_abapgit_folder_logic=>get_instance( ).
          ENDIF.

          lv_path = lo_folder_logic->package_to_path(
            iv_top     = iv_top
            io_dot     = io_dot
            iv_package = <ls_tadir>-devclass ).
        ENDIF.
      ENDIF.

      <ls_tadir>-path = lv_path.

      IF <ls_tadir>-object = 'SICF'.
* replace the internal GUID with a hash of the path
        TRY.
            CALL METHOD ('ZCL_ABAPGIT_OBJECT_SICF')=>read_sicf_url
              EXPORTING
                iv_obj_name = <ls_tadir>-obj_name
              RECEIVING
                rv_hash     = <ls_tadir>-obj_name+15.
          CATCH cx_sy_dyn_call_illegal_method ##NO_HANDLER.
* SICF might not be supported in some systems, assume this code is not called
        ENDTRY.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.