  METHOD build_obj_jump_link.

    DATA lv_encode TYPE string.
    DATA li_html TYPE REF TO zif_abapgit_html.

    CREATE OBJECT li_html TYPE zcl_abapgit_html.

    lv_encode = zcl_abapgit_html_action_utils=>jump_encode(
      iv_obj_type = is_item-obj_type
      iv_obj_name = is_item-obj_name ).

    rv_html = li_html->a(
      iv_txt = |{ is_item-obj_name }|
      iv_act = |{ zif_abapgit_definitions=>c_action-jump }?{ lv_encode }| ).

  ENDMETHOD.