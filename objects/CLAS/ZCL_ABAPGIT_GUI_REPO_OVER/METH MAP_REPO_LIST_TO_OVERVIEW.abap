  METHOD map_repo_list_to_overview.

    DATA: ls_overview LIKE LINE OF rt_overview,
          lo_repo_srv TYPE REF TO zcl_abapgit_repo,
          lv_date     TYPE d,
          lv_time     TYPE t.

    FIELD-SYMBOLS: <ls_repo> LIKE LINE OF it_repo_list.


    LOOP AT it_repo_list ASSIGNING <ls_repo>.

      CLEAR: ls_overview.
      lo_repo_srv = zcl_abapgit_repo_srv=>get_instance( )->get( <ls_repo>-key ).

      ls_overview-favorite   = zcl_abapgit_persistence_user=>get_instance(
        )->is_favorite_repo( <ls_repo>-key ).
      ls_overview-type       = <ls_repo>-offline.
      ls_overview-key        = <ls_repo>-key.
      ls_overview-name       = lo_repo_srv->get_name( ).
      ls_overview-url        = <ls_repo>-url.
      ls_overview-package    = <ls_repo>-package.
      ls_overview-branch     = zcl_abapgit_git_branch_list=>get_display_name( <ls_repo>-branch_name ).
      ls_overview-created_by = <ls_repo>-created_by.

      IF <ls_repo>-created_at IS NOT INITIAL.
        CONVERT TIME STAMP <ls_repo>-created_at
                TIME ZONE mv_time_zone
                INTO DATE lv_date
                     TIME lv_time.

        ls_overview-created_at = |{ lv_date DATE = USER } { lv_time TIME = USER }|.
      ENDIF.

      ls_overview-deserialized_by = <ls_repo>-deserialized_by.

      IF <ls_repo>-deserialized_at IS NOT INITIAL.
        CONVERT TIME STAMP <ls_repo>-deserialized_at
                TIME ZONE mv_time_zone
                INTO DATE lv_date
                     TIME lv_time.

        ls_overview-deserialized_at = |{ lv_date DATE = USER } { lv_time TIME = USER }|.
      ENDIF.

      INSERT ls_overview INTO TABLE rt_overview.

    ENDLOOP.

  ENDMETHOD.