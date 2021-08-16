  METHOD render_beacon.

    DATA: lv_beacon  TYPE string,
          lt_beacons TYPE zif_abapgit_definitions=>ty_string_tt.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    IF is_diff_line-beacon > 0.
      lt_beacons = is_diff-o_diff->get_beacons( ).
      READ TABLE lt_beacons INTO lv_beacon INDEX is_diff_line-beacon.
    ELSE.
      lv_beacon = '---'.
    ENDIF.


    ri_html->add( '<thead class="nav_line">' ).
    ri_html->add( '<tr>' ).

    ri_html->add( '<th class="num"></th>' ).
    ri_html->add( |<th colspan="3">@@ { is_diff_line-new_num } @@ { lv_beacon }</th>| ).

    ri_html->add( '</tr>' ).
    ri_html->add( '</thead>' ).

  ENDMETHOD.