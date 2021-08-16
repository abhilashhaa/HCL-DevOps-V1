  METHOD build_dir_jump_link.

    DATA lv_path   TYPE string.
    DATA lv_encode TYPE string.
    DATA li_html TYPE REF TO zif_abapgit_html.

    CREATE OBJECT li_html TYPE zcl_abapgit_html.

    lv_path = iv_path.
    REPLACE FIRST OCCURRENCE OF mv_cur_dir IN lv_path WITH ''.
    lv_encode = zcl_abapgit_html_action_utils=>dir_encode( lv_path ).

    rv_html = li_html->a(
      iv_txt = lv_path
      iv_act = |{ c_actions-change_dir }?{ lv_encode }| ).

  ENDMETHOD.