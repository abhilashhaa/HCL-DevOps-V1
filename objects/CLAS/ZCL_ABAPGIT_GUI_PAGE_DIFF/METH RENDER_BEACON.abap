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

    render_beacon_begin_of_row(
      ii_html = ri_html
      is_diff = is_diff ).

    IF mv_unified = abap_true.
      ri_html->add( '<th class="num"></th>' ).
      ri_html->add( '<th class="mark"></th>' ).
      ri_html->add( |<th>@@ { is_diff_line-new_num } @@ { lv_beacon }</th>| ).
    ELSE.
      ri_html->add( |<th colspan="6">@@ { is_diff_line-new_num } @@ { lv_beacon }</th>| ).
    ENDIF.

    ri_html->add( '</tr>' ).
    ri_html->add( '</thead>' ).

  ENDMETHOD.