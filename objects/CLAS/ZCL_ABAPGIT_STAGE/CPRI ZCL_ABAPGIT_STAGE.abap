  PRIVATE SECTION.

    DATA mt_stage TYPE zif_abapgit_definitions=>ty_stage_tt .
    DATA mv_merge_source TYPE zif_abapgit_definitions=>ty_sha1 .

    METHODS append
      IMPORTING
        !iv_path     TYPE zif_abapgit_definitions=>ty_file-path
        !iv_filename TYPE zif_abapgit_definitions=>ty_file-filename
        !iv_method   TYPE zif_abapgit_definitions=>ty_method
        !is_status   TYPE zif_abapgit_definitions=>ty_result OPTIONAL
        !iv_data     TYPE xstring OPTIONAL
      RAISING
        zcx_abapgit_exception .