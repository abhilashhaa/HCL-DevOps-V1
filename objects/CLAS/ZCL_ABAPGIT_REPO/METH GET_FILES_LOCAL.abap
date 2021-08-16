  METHOD get_files_local.

    DATA: lo_filter     TYPE REF TO zcl_abapgit_repo_filter,
          lt_tadir      TYPE zif_abapgit_definitions=>ty_tadir_tt,
          lo_serialize  TYPE REF TO zcl_abapgit_serialize,
          lt_found      LIKE rt_files,
          lv_force      TYPE abap_bool,
          ls_apack_file TYPE zif_abapgit_definitions=>ty_file.

    FIELD-SYMBOLS: <ls_return> LIKE LINE OF rt_files.


    " Serialization happened before and no refresh request
    IF lines( mt_local ) > 0 AND mv_request_local_refresh = abap_false.
      rt_files = mt_local.
      RETURN.
    ENDIF.

    APPEND INITIAL LINE TO rt_files ASSIGNING <ls_return>.
    <ls_return>-file = build_dotabapgit_file( ).

    ls_apack_file = build_apack_manifest_file( ).
    IF ls_apack_file IS NOT INITIAL.
      APPEND INITIAL LINE TO rt_files ASSIGNING <ls_return>.
      <ls_return>-file = ls_apack_file.
    ENDIF.

    lt_tadir = zcl_abapgit_factory=>get_tadir( )->read(
      iv_package            = get_package( )
      iv_ignore_subpackages = get_local_settings( )-ignore_subpackages
      iv_only_local_objects = get_local_settings( )-only_local_objects
      io_dot                = get_dot_abapgit( )
      ii_log                = ii_log ).

    CREATE OBJECT lo_filter
      EXPORTING
        iv_package = get_package( ).

    lo_filter->apply( EXPORTING it_filter = it_filter
                      CHANGING  ct_tadir  = lt_tadir ).

    CREATE OBJECT lo_serialize
      EXPORTING
        iv_serialize_master_lang_only = ms_data-local_settings-serialize_master_lang_only.

* if there are less than 10 objects run in single thread
* this helps a lot when debugging, plus performance gain
* with low number of objects does not matter much
    lv_force = boolc( lines( lt_tadir ) < 10 ).

    lt_found = lo_serialize->serialize(
      it_tadir            = lt_tadir
      iv_language         = get_dot_abapgit( )->get_master_language( )
      ii_log              = ii_log
      iv_force_sequential = lv_force ).
    APPEND LINES OF lt_found TO rt_files.

    mt_local                 = rt_files.
    mv_request_local_refresh = abap_false. " Fulfill refresh

  ENDMETHOD.