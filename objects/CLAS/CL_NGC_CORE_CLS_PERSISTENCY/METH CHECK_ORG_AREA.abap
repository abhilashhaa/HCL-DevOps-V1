  METHOD check_org_area.

*--------------------------------------------------------------------*
* This logic is partially adapted from
*   - /PLMI/CL_CLF_BO_VALUE-->CONVERT_CHARACT
*   - SAPLCTMS: CHECK_INPUT_AUTHORIZATION
*   - SAPLCTMS: CHECK_DISPLAY_AUTHORIZATION
*--------------------------------------------------------------------*

    FIELD-SYMBOLS: <lv_org_area_id> TYPE c.
    DATA: lv_check_ok TYPE boole_d.

    LOOP AT ct_class_characteristic ASSIGNING FIELD-SYMBOL(<ls_class_hier_charc>)
    WHERE clfnorganizationalarea IS NOT INITIAL.
      ASSIGN <ls_class_hier_charc>-clfnorganizationalarea(1) TO <lv_org_area_id>.
      lv_check_ok = abap_false.
      DO 10 TIMES.
        IF <lv_org_area_id> NE space.
          READ TABLE mt_org_area_w_auth TRANSPORTING NO FIELDS
          WITH KEY classtype                = <ls_class_hier_charc>-classtype
                   clfnorganizationalareacode = <lv_org_area_id>.
          IF sy-subrc EQ 0.
            lv_check_ok = abap_true.
            EXIT.
          ELSE.
            ASSIGN <lv_org_area_id>+1(1) TO <lv_org_area_id>.
          ENDIF.
        ELSE.
          EXIT.
        ENDIF.
      ENDDO.
      IF lv_check_ok EQ abap_false.
        <ls_class_hier_charc>-charcishidden = abap_true.
      ENDIF.
      ASSIGN <ls_class_hier_charc>-clfnorganizationalarea(1) TO <lv_org_area_id>.
      lv_check_ok = abap_false.
      DO 10 TIMES.
        IF <lv_org_area_id> NE space.
          READ TABLE mt_org_area_w_disp_auth TRANSPORTING NO FIELDS
          WITH KEY classtype                = <ls_class_hier_charc>-classtype
                   clfnorganizationalareacode = <lv_org_area_id>.
          IF sy-subrc EQ 0.
            lv_check_ok = abap_true.
            EXIT.
          ELSE.
            ASSIGN <lv_org_area_id>+1(1) TO <lv_org_area_id>.
          ENDIF.
        ELSE.
          EXIT.
        ENDIF.
      ENDDO.
      IF lv_check_ok EQ abap_false.
        <ls_class_hier_charc>-charcisreadonly = abap_true.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.