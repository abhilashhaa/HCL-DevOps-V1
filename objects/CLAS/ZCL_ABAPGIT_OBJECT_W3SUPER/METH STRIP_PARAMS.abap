  METHOD strip_params.

    FIELD-SYMBOLS <ls_param> LIKE LINE OF ct_params.

    " Remove path from filename
    find_param( it_params = ct_params
                iv_name = c_param_names-filename ). " Check exists
    READ TABLE ct_params ASSIGNING <ls_param> WITH KEY name = c_param_names-filename.
    <ls_param>-value = zcl_abapgit_path=>get_filename_from_syspath( |{ <ls_param>-value }| ).

    " Clear version & filesize
    DELETE ct_params WHERE name = c_param_names-version.
    DELETE ct_params WHERE name = c_param_names-filesize.

  ENDMETHOD.