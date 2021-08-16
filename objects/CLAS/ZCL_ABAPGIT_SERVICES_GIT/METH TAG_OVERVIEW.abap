  METHOD tag_overview.

    DATA: lo_repo TYPE REF TO zcl_abapgit_repo_online.

    lo_repo ?= zcl_abapgit_repo_srv=>get_instance( )->get( iv_key ).

    zcl_abapgit_ui_factory=>get_tag_popups( )->tag_list_popup( lo_repo ).

  ENDMETHOD.