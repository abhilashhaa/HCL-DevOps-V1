  METHOD open_in_master_language.

    CONSTANTS:
      lc_abapgit_tcode TYPE tcode VALUE `ZABAPGIT`.

    DATA:
      lv_master_language TYPE spras,
      lt_spagpa          TYPE STANDARD TABLE OF rfc_spagpa,
      ls_spagpa          LIKE LINE OF lt_spagpa,
      ls_item            TYPE zif_abapgit_definitions=>ty_item,
      lv_subrc           TYPE syst-subrc,
      lv_save_sy_langu   TYPE sy-langu.

    " https://blogs.sap.com/2017/01/13/logon-language-sy-langu-and-rfc/

    lv_master_language = mo_repo->get_dot_abapgit( )->get_master_language( ).

    IF lv_master_language = sy-langu.
      zcx_abapgit_exception=>raise( |Repo already opened in master language| ).
    ENDIF.

    ls_item-obj_name = lc_abapgit_tcode.
    ls_item-obj_type = |TRAN|.

    IF zcl_abapgit_objects=>exists( ls_item ) = abap_false.
      zcx_abapgit_exception=>raise( |Please install the abapGit repository| ).
    ENDIF.

    lv_save_sy_langu = sy-langu.
    SET LOCALE LANGUAGE lv_master_language.

    ls_spagpa-parid  = zif_abapgit_definitions=>c_spagpa_param_repo_key.
    ls_spagpa-parval = mo_repo->get_key( ).
    INSERT ls_spagpa INTO TABLE lt_spagpa.

    CALL FUNCTION 'ABAP4_CALL_TRANSACTION'
      DESTINATION 'NONE'
      STARTING NEW TASK 'ABAPGIT'
      EXPORTING
        tcode                   = lc_abapgit_tcode
      TABLES
        spagpa_tab              = lt_spagpa
      EXCEPTIONS
        call_transaction_denied = 1
        tcode_invalid           = 2
        communication_failure   = 3
        system_failure          = 4
        OTHERS                  = 5.

    lv_subrc = sy-subrc.

    SET LOCALE LANGUAGE lv_save_sy_langu.

    IF lv_subrc <> 0.
      zcx_abapgit_exception=>raise( |Error from ABAP4_CALL_TRANSACTION. Subrc = { lv_subrc }| ).
    ENDIF.

    MESSAGE 'Repository opened in a new window' TYPE 'S'.

  ENDMETHOD.