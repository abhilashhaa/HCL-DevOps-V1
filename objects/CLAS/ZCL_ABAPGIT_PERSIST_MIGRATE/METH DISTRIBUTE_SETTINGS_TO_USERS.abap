  METHOD distribute_settings_to_users.

    TYPES: ty_char12 TYPE c LENGTH 12.

    DATA: lt_abapgit_users    TYPE STANDARD TABLE OF ty_char12
                                   WITH NON-UNIQUE DEFAULT KEY,
          ls_user_settings    TYPE zif_abapgit_definitions=>ty_s_user_settings,
          li_user_persistence TYPE REF TO zif_abapgit_persist_user.

    FIELD-SYMBOLS: <lv_user>                      LIKE LINE OF lt_abapgit_users,
                   <ls_setting_to_migrate>        TYPE ty_settings_to_migrate,
                   <lg_user_specific_setting_val> TYPE data.

    " distribute settings to all abapGit users
    SELECT value FROM (zcl_abapgit_persistence_db=>c_tabname)
                 INTO TABLE lt_abapgit_users
                 WHERE type = zcl_abapgit_persistence_db=>c_type_user.

    LOOP AT lt_abapgit_users ASSIGNING <lv_user>.

      li_user_persistence = zcl_abapgit_persistence_user=>get_instance( <lv_user> ).

      ls_user_settings = li_user_persistence->get_settings( ).

      LOOP AT it_settings_to_migrate ASSIGNING <ls_setting_to_migrate>.

        ASSIGN COMPONENT <ls_setting_to_migrate>-name
               OF STRUCTURE ls_user_settings
               TO <lg_user_specific_setting_val>.
        ASSERT sy-subrc = 0.

        <lg_user_specific_setting_val> = <ls_setting_to_migrate>-value.

      ENDLOOP.

      li_user_persistence->set_settings( ls_user_settings ).

    ENDLOOP.

  ENDMETHOD.