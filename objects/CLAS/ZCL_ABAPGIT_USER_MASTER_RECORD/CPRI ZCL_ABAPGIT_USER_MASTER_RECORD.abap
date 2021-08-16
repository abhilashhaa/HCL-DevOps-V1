  PRIVATE SECTION.
    TYPES:
      BEGIN OF ty_user,
        user   TYPE sy-uname,
        o_user TYPE REF TO zcl_abapgit_user_master_record,
      END OF ty_user.

    CLASS-DATA:
      gt_user TYPE HASHED TABLE OF ty_user
                   WITH UNIQUE KEY user.

    DATA:
      ms_user TYPE zif_abapgit_definitions=>ty_git_user.