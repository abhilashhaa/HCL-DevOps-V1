  METHOD get_config_owners.

    CONSTANTS:
      lc_section_size TYPE i VALUE 1000.

    DATA:
      lv_valuation_size TYPE i,
      lv_from_index     TYPE i VALUE 0,
      lv_to_index       TYPE i VALUE 0,
      lt_valuation_temp TYPE ty_t_valuation,
      lt_config_owners  TYPE ty_t_config_owners.

    IF it_valuation IS INITIAL.
      RETURN.
    ENDIF.

    lv_valuation_size = lines( it_valuation ).

    DO.
      CLEAR: lt_valuation_temp.
      lv_from_index = lv_to_index.
      lv_to_index = lv_to_index + lc_section_size.

      IF lv_from_index <= lv_valuation_size.
        LOOP AT it_valuation FROM lv_from_index TO lv_to_index REFERENCE INTO DATA(lr_valuation).
          APPEND lr_valuation->* TO lt_valuation_temp.
        ENDLOOP.
      ELSE.
        EXIT.
      ENDIF.

      IF lt_valuation_temp IS NOT INITIAL.
        SELECT
          FROM ibsymbol
            INNER JOIN ibinvalues ON ibinvalues~symbol_id = ibsymbol~symbol_id
                                 AND ibinvalues~ataut = '3'
            INNER JOIN ibin ON ibin~in_recno = ibinvalues~in_recno
            INNER JOIN ibst ON ibst~instance = ibin~instance
            INNER JOIN ibinown ON ibinown~instance = ibst~root
          FIELDS
            ibinown~instance,
            ibinown~inttyp,
            ibinown~objkey,
            ibsymbol~atinn,
            ibsymbol~atwrt,
            ibsymbol~atflv,
            ibsymbol~atflb,
            ibsymbol~atcod
            FOR ALL ENTRIES IN @lt_valuation_temp
          WHERE ibin~objnr     = @lt_valuation_temp-objnr
            AND ibsymbol~atinn = @lt_valuation_temp-atinn
            AND ibsymbol~atwrt = @lt_valuation_temp-atwrt
            AND ibsymbol~atflv = @lt_valuation_temp-atflv
            AND ibsymbol~atflb = @lt_valuation_temp-atflb
            AND ibsymbol~atcod = @lt_valuation_temp-atcod
          APPENDING CORRESPONDING FIELDS OF TABLE @rt_config_owners.
      ELSE.
        EXIT.
      ENDIF.
    ENDDO.

    SORT rt_config_owners BY inttyp objkey.

  ENDMETHOD.