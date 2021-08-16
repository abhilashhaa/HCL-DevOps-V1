  METHOD read_org_area.

    DATA lt_classtype_range TYPE tt_classtype_range.
    LOOP AT it_classtype_range ASSIGNING FIELD-SYMBOL(<ls_classtype>).
      READ TABLE mt_classtype TRANSPORTING NO FIELDS
      WITH KEY classtype =  <ls_classtype>-low.
      IF sy-subrc IS NOT INITIAL.
        APPEND <ls_classtype> TO lt_classtype_range.
        APPEND <ls_classtype>-low TO mt_classtype.
      ENDIF.
    ENDLOOP.

    CHECK lt_classtype_range IS NOT INITIAL.

    TEST-SEAM sel_cds_org_area.
      SELECT
        classtype,
        clfnorganizationalareacode,
        \_organizationalareatext[ language = @sy-langu ]-clfnorganizationalareaname AS clfnorganizationalareaname    ##ASSOC_TO_N_OK[_ORGANIZATIONALAREATEXT]
        FROM i_clfnorganizationalarea
        WHERE classtype IN @it_classtype_range
        INTO TABLE @DATA(lt_org_area).

      LOOP AT lt_org_area INTO DATA(ls_org_area).

        AUTHORITY-CHECK OBJECT 'C_TCLS_MNT'
          ID 'ACTVT' FIELD '23'
          ID 'KLART' FIELD ls_org_area-classtype
          ID 'SICHT' FIELD ls_org_area-clfnorganizationalareacode.
        IF sy-subrc EQ 0.
          APPEND ls_org_area TO mt_org_area_w_auth.
        ENDIF.

        AUTHORITY-CHECK OBJECT 'C_TCLS_BER'
          ID 'KLART' FIELD ls_org_area-classtype
          ID 'SICHT' FIELD ls_org_area-clfnorganizationalareacode.
        IF sy-subrc EQ 0.
          APPEND ls_org_area TO mt_org_area_w_disp_auth.
        ENDIF.

      ENDLOOP.
    END-TEST-SEAM.

  ENDMETHOD.