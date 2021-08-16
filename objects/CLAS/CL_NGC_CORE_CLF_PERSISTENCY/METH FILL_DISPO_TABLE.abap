  METHOD fill_dispo_table.

    " This implementation was adapted from
    " Include: LCLFMF2Q
    " Form: create_dispo_records

    " KLAH-vwstl = x means that class usable in BOM

    DATA:
      lv_objek        TYPE cuobn,
      ls_clmdcp       TYPE clmdcp,
      lv_matnr_length TYPE i,
      lt_ghcl         TYPE tt_ghcl.

    CLEAR: et_clmdcp.

    " if there is no class which is usable in BOM, return
    READ TABLE it_kssk_insert_fm TRANSPORTING NO FIELDS WITH KEY vwstl = abap_true.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    " extract materials for BOM
    LOOP AT it_ausp_fm ASSIGNING FIELD-SYMBOL(<ls_ausp_fm>)
      WHERE statu <> space.

      IF <ls_ausp_fm>-objek <> lv_objek.
        lv_objek = <ls_ausp_fm>-objek.
      ELSE.
        CONTINUE.
      ENDIF.

      LOOP AT it_kssk_insert_fm ASSIGNING FIELD-SYMBOL(<ls_kssk_fm>)
        WHERE objek = <ls_ausp_fm>-objek
          AND klart = <ls_ausp_fm>-klart
          AND mafid = <ls_ausp_fm>-mafid
          AND vwstl = abap_true.

        CLEAR ls_clmdcp.
        ls_clmdcp-class = <ls_kssk_fm>-class.
        ls_clmdcp-klart = <ls_kssk_fm>-klart.
        IF <ls_kssk_fm>-mafid = if_ngc_core_c=>gc_clf_object_class_indicator-object.
          ls_clmdcp-matnr = <ls_kssk_fm>-objek.
          IF <ls_kssk_fm>-obtab = gc_obtab_marc.
            DESCRIBE FIELD ls_clmdcp-matnr LENGTH lv_matnr_length IN CHARACTER MODE.
            ls_clmdcp-werks = <ls_kssk_fm>-objek+lv_matnr_length.
          ENDIF.
        ENDIF.

        APPEND ls_clmdcp TO et_clmdcp.

        mo_util->get_class_hierarchy(
          EXPORTING
            iv_classtype = <ls_kssk_fm>-klart
            iv_class     = <ls_kssk_fm>-class
          IMPORTING
            et_ghcl      = lt_ghcl
        ).

        CLEAR: ls_clmdcp.
        LOOP AT lt_ghcl ASSIGNING FIELD-SYMBOL(<ls_ghcl>)
          WHERE clas1 <> <ls_kssk_fm>-class.
          ls_clmdcp-class = <ls_ghcl>-clas1.
          ls_clmdcp-klart = <ls_kssk_fm>-klart.
          APPEND ls_clmdcp TO et_clmdcp.
        ENDLOOP.
      ENDLOOP.
    ENDLOOP.

    SORT et_clmdcp ASCENDING BY class klart matnr werks.
    DELETE ADJACENT DUPLICATES FROM et_clmdcp.

  ENDMETHOD.