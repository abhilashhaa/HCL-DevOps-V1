  METHOD get_active_relations.
    DATA: lv_datuv        TYPE datuv,
          lv_datub        TYPE datub,
          lv_aennr        TYPE aennr,
          ls_new_relation TYPE ngc_clhier_idx,
          lv_overlap      TYPE abap_bool.

    FIELD-SYMBOLS <ls_overlapped_relation> TYPE ngc_clhier_idx.

    lv_datuv = iv_datuv.
    lv_datub = iv_datub.
    lv_aennr = iv_aennr.

    " Check if the current location is required and update the validity dates in this case.
    LOOP AT ct_relations ASSIGNING FIELD-SYMBOL(<ls_relation>).
      IF iv_root_node = <ls_relation>-ancestor.
        IF <ls_relation>-datuv = '99991231' AND <ls_relation>-datub = '00000000'.
          lv_overlap = abap_true.
        ELSE.
          lv_overlap = cl_ngc_core_cls_util=>check_overlap(
            iv_valid_from1 = iv_datuv
            iv_valid_to1   = iv_datub
            iv_valid_from2 = <ls_relation>-datuv
            iv_valid_to2   = <ls_relation>-datub ).
        ENDIF.

        IF lv_overlap = abap_true.
          IF <ls_overlapped_relation> IS NOT ASSIGNED.
            IF iv_datuv < <ls_relation>-datuv.
              <ls_relation>-datuv = iv_datuv.
            ENDIF.
            IF iv_datub > <ls_relation>-datub.
              <ls_relation>-datub = iv_datub.
            ENDIF.
            <ls_relation>-aennr = iv_aennr.

            ASSIGN <ls_relation> TO <ls_overlapped_relation>.
          ELSE.
            <ls_overlapped_relation>-datuv = cl_ngc_core_cls_util=>minimum_date(
              iv_date1 = iv_datuv
              iv_date2 = <ls_relation>-datuv
              iv_date3 = <ls_overlapped_relation>-datuv ).
            <ls_overlapped_relation>-datub = cl_ngc_core_cls_util=>maximum_date(
              iv_date1 = iv_datub
              iv_date2 = <ls_relation>-datub
              iv_date3 = <ls_overlapped_relation>-datub ).

            IF <ls_overlapped_relation>-datuv = iv_datuv.
              <ls_overlapped_relation>-aennr = iv_aennr.
            ELSEIF <ls_overlapped_relation>-datuv = <ls_relation>-datuv.
              <ls_overlapped_relation>-aennr = <ls_relation>-aennr.
            ENDIF.

            DELETE ct_relations.
          ENDIF.

          CLEAR ls_new_relation.
        ELSEIF ls_new_relation IS INITIAL AND <ls_overlapped_relation> IS NOT ASSIGNED.
          ls_new_relation          = <ls_relation>.
          ls_new_relation-datuv    = iv_datuv.
          ls_new_relation-datub    = iv_datub.
          ls_new_relation-aennr    = iv_aennr.
        ENDIF.
      ENDIF.
    ENDLOOP.

    IF ls_new_relation IS NOT INITIAL.
      APPEND ls_new_relation TO ct_relations.
    ENDIF.

    DATA(lt_parent_relations) = get_direct_parent_relations( iv_root_node ).

    LOOP AT lt_parent_relations INTO DATA(ls_relation).
      IF ls_relation-datuv > iv_datuv.
        lv_datuv = ls_relation-datuv.
        lv_aennr = ls_relation-aennr.
      ENDIF.
      IF ls_relation-datub < iv_datub.
        lv_datub = ls_relation-datub.
      ENDIF.

      IF lv_datuv < lv_datub.
        get_active_relations(
          EXPORTING
            iv_root_node = ls_relation-ancestor
            iv_datuv     = lv_datuv
            iv_datub     = lv_datub
            iv_aennr     = lv_aennr
          CHANGING
            ct_relations = ct_relations ).
      ENDIF.

      lv_datuv = iv_datuv.
      lv_datub = iv_datub.
      lv_aennr = iv_aennr.
    ENDLOOP.
  ENDMETHOD.