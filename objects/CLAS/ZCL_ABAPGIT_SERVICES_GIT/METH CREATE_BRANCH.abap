  METHOD create_branch.

    DATA: lv_name   TYPE string,
          lv_cancel TYPE abap_bool,
          lo_repo   TYPE REF TO zcl_abapgit_repo_online,
          lv_msg    TYPE string,
          li_popups TYPE REF TO zif_abapgit_popups,
          lv_source_branch_name TYPE string.


    lo_repo ?= zcl_abapgit_repo_srv=>get_instance( )->get( iv_key ).
    lv_source_branch_name = lo_repo->get_branch_name( ).

    li_popups = zcl_abapgit_ui_factory=>get_popups( ).
    li_popups->create_branch_popup(
      EXPORTING
        iv_source_branch_name = lv_source_branch_name
      IMPORTING
        ev_name   = lv_name
        ev_cancel = lv_cancel ).

    IF lv_cancel = abap_true.
      RAISE EXCEPTION TYPE zcx_abapgit_cancel.
    ENDIF.

    lo_repo->create_branch( lv_name ).

    lv_msg = |Branch switched from { zcl_abapgit_git_branch_list=>get_display_name( lv_source_branch_name )
      } to new branch { zcl_abapgit_git_branch_list=>get_display_name( lv_name ) }|.
    MESSAGE lv_msg TYPE 'S'.

  ENDMETHOD.