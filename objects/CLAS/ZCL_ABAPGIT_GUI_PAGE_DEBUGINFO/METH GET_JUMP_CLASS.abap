  METHOD get_jump_class.

    DATA lv_encode TYPE string.
    DATA li_html TYPE REF TO zif_abapgit_html.

    CREATE OBJECT li_html TYPE zcl_abapgit_html.

    lv_encode = zcl_abapgit_html_action_utils=>jump_encode( iv_obj_type = 'CLAS'
                                                            iv_obj_name = |{ iv_class }| ).

    rv_html = li_html->a(
      iv_txt = |{ iv_class }|
      iv_act = |{ zif_abapgit_definitions=>c_action-jump }?{ lv_encode }| ).

  ENDMETHOD.