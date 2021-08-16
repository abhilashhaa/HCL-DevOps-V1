  PRIVATE SECTION.
    TYPES: BEGIN OF ty_s_settings,
             proxy_url                TYPE string,
             proxy_port               TYPE string,
             proxy_auth               TYPE string,
             proxy_bypass             TYPE zif_abapgit_definitions=>ty_range_proxy_bypass_url,
             run_critical_tests       TYPE abap_bool,
             experimental_features    TYPE abap_bool,
             commitmsg_comment_length TYPE i,
             commitmsg_comment_deflt  TYPE string,
             commitmsg_body_size      TYPE i,
           END OF ty_s_settings.

    DATA: ms_settings      TYPE ty_s_settings,
          ms_user_settings TYPE zif_abapgit_definitions=>ty_s_user_settings.

    METHODS:
      set_default_link_hint_key.
