  METHOD if_ngc_drf_util~get_characteristic_data.

    CLEAR: et_charact_tab, et_charact_descr_tab, et_value_tab, et_value_descr_tab, et_restrictions_tab, et_references_tab.

    IF it_bo_keys IS INITIAL.
      IF lines( it_atinn ) > 0.
        SELECT *
          FROM cabn
          FOR ALL ENTRIES IN @it_atinn
          WHERE cabn~atinn = @it_atinn-table_line
          INTO TABLE @et_charact_tab.
        SELECT cabnt~*
          FROM ( cabn INNER JOIN cabnt ON cabn~atinn = cabnt~atinn )
          FOR ALL ENTRIES IN @it_atinn
          WHERE cabn~atinn = @it_atinn-table_line
          INTO CORRESPONDING FIELDS OF TABLE @et_charact_descr_tab.
        SELECT cawn~*
          FROM ( cabn INNER JOIN cawn ON cabn~atinn = cawn~atinn )
          FOR ALL ENTRIES IN @it_atinn
          WHERE cabn~atinn = @it_atinn-table_line
          INTO CORRESPONDING FIELDS OF TABLE @et_value_tab.
        SELECT cawnt~*
          FROM ( cabn INNER JOIN cawnt ON cabn~atinn = cawnt~atinn )
          FOR ALL ENTRIES IN @it_atinn
          WHERE cabn~atinn = @it_atinn-table_line
          INTO CORRESPONDING FIELDS OF TABLE @et_value_descr_tab.
        SELECT cabnz~*
          FROM ( cabn INNER JOIN cabnz ON cabn~atinn = cabnz~atinn )
          FOR ALL ENTRIES IN @it_atinn
          WHERE cabn~atinn = @it_atinn-table_line
          INTO CORRESPONDING FIELDS OF TABLE @et_references_tab.
        SELECT tcme~*
          FROM ( cabn INNER JOIN tcme ON cabn~atinn = tcme~atinn )
          FOR ALL ENTRIES IN @it_atinn
          WHERE cabn~atinn = @it_atinn-table_line
          INTO CORRESPONDING FIELDS OF TABLE @et_restrictions_tab.
      ENDIF.
    ELSE.
      SELECT *
        FROM cabn
        FOR ALL ENTRIES IN @it_bo_keys
        WHERE cabn~atnam = @it_bo_keys-atnam
        INTO TABLE @et_charact_tab.
      SELECT cabnt~*
        FROM ( cabn INNER JOIN cabnt ON cabn~atinn = cabnt~atinn )
        FOR ALL ENTRIES IN @it_bo_keys
        WHERE cabn~atnam = @it_bo_keys-atnam
        INTO CORRESPONDING FIELDS OF TABLE @et_charact_descr_tab.
      SELECT cawn~*
        FROM ( cabn INNER JOIN cawn ON cabn~atinn = cawn~atinn )
        FOR ALL ENTRIES IN @it_bo_keys
        WHERE cabn~atnam = @it_bo_keys-atnam
        INTO CORRESPONDING FIELDS OF TABLE @et_value_tab.
      SELECT cawnt~*
        FROM ( cabn INNER JOIN cawnt ON cabn~atinn = cawnt~atinn )
        FOR ALL ENTRIES IN @it_bo_keys
        WHERE cabn~atnam = @it_bo_keys-atnam
        INTO CORRESPONDING FIELDS OF TABLE @et_value_descr_tab.
      SELECT cabnz~*
        FROM ( cabn INNER JOIN cabnz ON cabn~atinn = cabnz~atinn )
        FOR ALL ENTRIES IN @it_bo_keys
        WHERE cabn~atnam = @it_bo_keys-atnam
        INTO CORRESPONDING FIELDS OF TABLE @et_references_tab.
      SELECT tcme~*
        FROM ( cabn INNER JOIN tcme ON cabn~atinn = tcme~atinn )
        FOR ALL ENTRIES IN @it_bo_keys
        WHERE cabn~atnam = @it_bo_keys-atnam
        INTO CORRESPONDING FIELDS OF TABLE @et_restrictions_tab.
    ENDIF.

  ENDMETHOD.