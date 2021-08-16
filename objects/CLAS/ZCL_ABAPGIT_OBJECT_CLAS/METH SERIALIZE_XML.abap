  METHOD serialize_xml.

    DATA: ls_vseoclass        TYPE vseoclass,
          ls_clskey           TYPE seoclskey,
          lt_langu_additional TYPE zif_abapgit_lang_definitions=>tt_langu.

    ls_clskey-clsname = ms_item-obj_name.

    "If class was deserialized with a previous versions of abapGit and current language was different
    "from master language at this time, this call would return SY-LANGU as master language. To fix
    "these objects, set SY-LANGU to master language temporarily.
    zcl_abapgit_language=>set_current_language( mv_language ).

    TRY.
        ls_vseoclass = mi_object_oriented_object_fct->get_class_properties( ls_clskey ).

      CLEANUP.
        zcl_abapgit_language=>restore_login_language( ).

    ENDTRY.

    zcl_abapgit_language=>restore_login_language( ).

    CLEAR: ls_vseoclass-uuid,
           ls_vseoclass-author,
           ls_vseoclass-createdon,
           ls_vseoclass-changedby,
           ls_vseoclass-changedon,
           ls_vseoclass-r3release,
           ls_vseoclass-chgdanyby,
           ls_vseoclass-chgdanyon,
           ls_vseoclass-clsfinal,
           ls_vseoclass-clsabstrct,
           ls_vseoclass-exposure,
           ls_vseoclass-version.

    IF mv_skip_testclass = abap_true.
      CLEAR ls_vseoclass-with_unit_tests.
    ENDIF.

    " Table d010tinf stores info. on languages in which program is maintained
    " Select all active translations of program texts
    " Skip master language - it was already serialized
    SELECT DISTINCT language
      INTO TABLE lt_langu_additional
      FROM d010tinf
      WHERE r3state  = 'A'
        AND prog     = mv_classpool_name
        AND language <> mv_language.

    ii_xml->add( iv_name = 'VSEOCLASS'
                 ig_data = ls_vseoclass ).

    serialize_tpool( ii_xml              = ii_xml
                     iv_clsname          = ls_clskey-clsname
                     it_langu_additional = lt_langu_additional ).

    IF ls_vseoclass-category = seoc_category_exception.
      serialize_sotr( ii_xml ).
    ENDIF.

    serialize_docu( ii_xml              = ii_xml
                    iv_clsname          = ls_clskey-clsname
                    it_langu_additional = lt_langu_additional ).

    serialize_descr( ii_xml     = ii_xml
                     iv_clsname = ls_clskey-clsname ).

    serialize_attr( ii_xml     = ii_xml
                    iv_clsname = ls_clskey-clsname ).

  ENDMETHOD.