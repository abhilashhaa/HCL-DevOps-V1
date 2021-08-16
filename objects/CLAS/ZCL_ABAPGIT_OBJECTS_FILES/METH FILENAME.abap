  METHOD filename.

    DATA: lv_obj_name TYPE string.


    lv_obj_name = ms_item-obj_name.

    " The counter part to this logic must be maintained in ZCL_ABAPGIT_FILE_STATUS->IDENTIFY_OBJECT
    IF ms_item-obj_type = 'DEVC'.
      " Packages have a fixed filename so that the repository can be installed to a different
      " package(-hierarchy) on the client and not show up as a different package in the repo.
      lv_obj_name = 'package'.
    ELSE.
      " Some characters in object names cause problems when identifying the object later
      " -> we escape these characters here
      " cl_http_utility=>escape_url doesn't do dots but escapes slash which we use for namespaces
      " -> we escape just some selected characters
      REPLACE ALL OCCURRENCES OF `%` IN lv_obj_name WITH '%25'.
      REPLACE ALL OCCURRENCES OF `#` IN lv_obj_name WITH '%23'.
      REPLACE ALL OCCURRENCES OF `.` IN lv_obj_name WITH '%2e'.
      REPLACE ALL OCCURRENCES OF `=` IN lv_obj_name WITH '%3d'.
      REPLACE ALL OCCURRENCES OF `?` IN lv_obj_name WITH '%3f'.
      REPLACE ALL OCCURRENCES OF `<` IN lv_obj_name WITH '%3c'.
      REPLACE ALL OCCURRENCES OF `>` IN lv_obj_name WITH '%3e'.
    ENDIF.

    IF iv_extra IS INITIAL.
      CONCATENATE lv_obj_name '.' ms_item-obj_type
        INTO rv_filename.
    ELSE.
      CONCATENATE lv_obj_name '.' ms_item-obj_type '.' iv_extra
        INTO rv_filename.
    ENDIF.

    IF iv_ext IS NOT INITIAL.
      CONCATENATE rv_filename '.' iv_ext
        INTO rv_filename.
    ENDIF.

    " handle namespaces
    REPLACE ALL OCCURRENCES OF '/' IN rv_filename WITH '#'.
    TRANSLATE rv_filename TO LOWER CASE.

  ENDMETHOD.