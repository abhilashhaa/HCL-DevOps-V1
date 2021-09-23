  method MATNR_WERKS.
        DATA: lv_matnr TYPE matnr VALUE 'RM02',
          lv_werks TYPE werks_d VALUE '1110'.
    SELECT matnr,
      werks FROM marc
      WHERE matnr = @lv_matnr
      AND werks = @lv_werks
      INTO TABLE @li_mat.

 "#EC CI_VALPAR
 endmethod .