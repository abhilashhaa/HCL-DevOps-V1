  METHOD create_sotr.

    DATA:
      lt_objects  TYPE sotr_objects,
      ls_paket    TYPE sotr_pack,
      lv_object   LIKE LINE OF lt_objects,
      lt_sotr     TYPE zif_abapgit_definitions=>ty_sotr_tt,
      lt_sotr_use TYPE zif_abapgit_definitions=>ty_sotr_use_tt.

    FIELD-SYMBOLS: <ls_sotr> LIKE LINE OF lt_sotr.

    io_xml->read( EXPORTING iv_name = 'SOTR'
                  CHANGING cg_data = lt_sotr ).
    io_xml->read( EXPORTING iv_name = 'SOTR_USE'
                  CHANGING cg_data = lt_sotr_use ).

    LOOP AT lt_sotr ASSIGNING <ls_sotr>.
      CALL FUNCTION 'SOTR_OBJECT_GET_OBJECTS'
        EXPORTING
          object_vector    = <ls_sotr>-header-objid_vec
        IMPORTING
          objects          = lt_objects
        EXCEPTIONS
          object_not_found = 1
          OTHERS           = 2.
      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise( |error from SOTR_OBJECT_GET_OBJECTS. Subrc = { sy-subrc }| ).
      ENDIF.

      READ TABLE lt_objects INDEX 1 INTO lv_object.
      ASSERT sy-subrc = 0.

      ls_paket-paket = iv_package.

      CALL FUNCTION 'SOTR_CREATE_CONCEPT'
        EXPORTING
          paket                         = ls_paket
          crea_lan                      = <ls_sotr>-header-crea_lan
          alias_name                    = <ls_sotr>-header-alias_name
          object                        = lv_object
          entries                       = <ls_sotr>-entries
          concept_default               = <ls_sotr>-header-concept
        EXCEPTIONS
          package_missing               = 1
          crea_lan_missing              = 2
          object_missing                = 3
          paket_does_not_exist          = 4
          alias_already_exist           = 5
          object_type_not_found         = 6
          langu_missing                 = 7
          identical_context_not_allowed = 8
          text_too_long                 = 9
          error_in_update               = 10
          no_master_langu               = 11
          error_in_concept_id           = 12
          alias_not_allowed             = 13
          tadir_entry_creation_failed   = 14
          internal_error                = 15
          error_in_correction           = 16
          user_cancelled                = 17
          no_entry_found                = 18
          OTHERS                        = 19.
      IF sy-subrc <> 0 AND sy-subrc <> 5.
        zcx_abapgit_exception=>raise( |Error from SOTR_CREATE_CONCEPT. Subrc = { sy-subrc }| ).
      ENDIF.
    ENDLOOP.

    CALL FUNCTION 'SOTR_USAGE_MODIFY'
      EXPORTING
        sotr_usage = lt_sotr_use.

  ENDMETHOD.