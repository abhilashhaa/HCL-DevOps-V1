  METHOD zif_abapgit_object~deserialize.
    DATA: li_package      TYPE REF TO if_package,
          ls_package_data TYPE scompkdtln,
          ls_data_sign    TYPE scompksign,
          lt_usage_data   TYPE scomppdata,
          ls_save_sign    TYPE paksavsign.

    FIELD-SYMBOLS: <ls_usage_data> TYPE scomppdtln.


    mv_local_devclass = iv_package.

    io_xml->read(
      EXPORTING
        iv_name = 'DEVC'
      CHANGING
        cg_data = ls_package_data ).

    li_package = get_package( ).

    " Swap out repository package name with the local installation package name
    ls_package_data-devclass = mv_local_devclass.
    ls_package_data-pdevclass = li_package->transport_layer.

    " Parent package is not changed. Assume the folder logic already created the package and set
    " the hierarchy before.
    CLEAR ls_package_data-parentcl.

* Fields not set:
* korrflag
* dlvunit
* parentcl
    ls_data_sign-ctext            = abap_true.
    ls_data_sign-as4user          = abap_true.
    ls_data_sign-pdevclass        = abap_true.
    ls_data_sign-comp_posid       = abap_true.
    ls_data_sign-component        = abap_true.
    ls_data_sign-perminher        = abap_true.
    ls_data_sign-intfprefx        = abap_true.
    ls_data_sign-packtype         = abap_true.
    ls_data_sign-restricted       = abap_true.
    ls_data_sign-mainpack         = abap_true.
    ls_data_sign-srv_check        = abap_true.
    ls_data_sign-cli_check        = abap_true.
    ls_data_sign-ext_alias        = abap_true.
    ls_data_sign-project_guid     = abap_true.
    ls_data_sign-project_id       = abap_true.
    ls_data_sign-project_passdown = abap_true.

    IF ls_package_data-ctext IS INITIAL.
      ls_package_data-ctext = mv_local_devclass.
    ENDIF.
    IF ls_package_data-dlvunit IS INITIAL.
      ls_package_data-dlvunit = 'HOME'.
    ENDIF.

    ls_package_data-as4user = cl_abap_syst=>get_user_name( ).

    IF li_package IS BOUND.
      " Package already exists, change it
      set_lock( ii_package = li_package
                iv_lock = abap_true ).

      li_package->set_all_attributes(
        EXPORTING
          i_package_data             = ls_package_data
          i_data_sign                = ls_data_sign
        EXCEPTIONS
          object_not_changeable      = 1
          object_deleted             = 2
          object_invalid             = 3
          short_text_missing         = 4
          author_not_existing        = 5
          local_package              = 6
          software_component_invalid = 7
          layer_invalid              = 8
          korrflag_invalid           = 9
          component_not_existing     = 10
          component_missing          = 11
          authorize_failure          = 12
          prefix_in_use              = 13
          unexpected_error           = 14
          intern_err                 = 15
*          wrong_mainpack_value       = 16  downport, does not exist in 7.30
*          superpackage_invalid       = 17  downport, does not exist in 7.30
          OTHERS                     = 18 ).
      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise_t100( ).
      ENDIF.

    ELSE.
      " Package does not exist yet, create it
      " This shouldn't really happen, because the folder logic initially creates the packages.
      cl_package_factory=>create_new_package(
        IMPORTING
          e_package                  = li_package
        CHANGING
          c_package_data             = ls_package_data
        EXCEPTIONS
          object_already_existing    = 1
          object_just_created        = 2
          not_authorized             = 3
          wrong_name_prefix          = 4
          undefined_name             = 5
          reserved_local_name        = 6
          invalid_package_name       = 7
          short_text_missing         = 8
          software_component_invalid = 9
          layer_invalid              = 10
          author_not_existing        = 11
          component_not_existing     = 12
          component_missing          = 13
          prefix_in_use              = 14
          unexpected_error           = 15
          intern_err                 = 16
          no_access                  = 17
*          invalid_translation_depth  = 18 downport, does not exist in 7.30
*          wrong_mainpack_value       = 19 downport, does not exist in 7.30
*          superpackage_invalid       = 20 downport, does not exist in 7.30
*          error_in_cts_checks        = 21 downport, does not exist in 7.31
          OTHERS                     = 22 ).
      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise_t100( ).
      ENDIF.
    ENDIF.

    " Load package interface usages
    TRY.
        io_xml->read(
          EXPORTING
            iv_name = 'PERMISSION'
          CHANGING
            cg_data = lt_usage_data ).
      CATCH zcx_abapgit_exception ##NO_HANDLER.
        " No permissions saved
    ENDTRY.

    LOOP AT lt_usage_data ASSIGNING <ls_usage_data>.
      <ls_usage_data>-client_pak = mv_local_devclass.
    ENDLOOP.

    update_pinf_usages( ii_package    = li_package
                        it_usage_data = lt_usage_data ).

    ls_save_sign-pack = ls_save_sign-permis = ls_save_sign-elems = ls_save_sign-interf = abap_true.
    li_package->save_generic(
      EXPORTING
        i_save_sign           = ls_save_sign
      EXCEPTIONS
        cancelled_in_corr     = 1
        permission_failure    = 2
        object_not_changeable = 3
        object_invalid        = 4
        OTHERS                = 5 ).
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

    set_lock( ii_package = li_package
              iv_lock = abap_false ).
  ENDMETHOD.