  METHOD form_select.

    DATA: lv_name     TYPE string,
          lt_branches TYPE zif_abapgit_definitions=>ty_git_branch_list_tt.

    FIELD-SYMBOLS: <ls_branch> LIKE LINE OF lt_branches.


    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    lt_branches = mi_branch_overview->get_branches( ).

    ri_html->add( |<select name="{ iv_name }">| ).
    LOOP AT lt_branches ASSIGNING <ls_branch>.
      lv_name = <ls_branch>-name+11.
      ri_html->add( |<option value="{ lv_name }">{ lv_name }</option>| ).
    ENDLOOP.
    ri_html->add( '</select>' ).

  ENDMETHOD.