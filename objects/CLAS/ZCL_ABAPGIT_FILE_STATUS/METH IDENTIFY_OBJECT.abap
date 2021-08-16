  METHOD identify_object.

    DATA: lv_name TYPE string,
          lv_type TYPE string,
          lv_ext  TYPE string.

    " Guess object type and name
    SPLIT to_upper( iv_filename ) AT '.' INTO lv_name lv_type lv_ext.

    " Handle namespaces
    REPLACE ALL OCCURRENCES OF '#' IN lv_name WITH '/'.
    REPLACE ALL OCCURRENCES OF '#' IN lv_type WITH '/'.
    REPLACE ALL OCCURRENCES OF '#' IN lv_ext WITH '/'.

    " The counter part to this logic must be maintained in ZCL_ABAPGIT_OBJECTS_FILES->FILENAME
    IF lv_type = 'DEVC'.
      " Try to get a unique package name for DEVC by using the path
      ASSERT lv_name = 'PACKAGE'.
      lv_name = zcl_abapgit_folder_logic=>get_instance( )->path_to_package(
        iv_top                  = iv_devclass
        io_dot                  = io_dot
        iv_create_if_not_exists = abap_false
        iv_path                 = iv_path ).
    ELSE.
      " Get original object name
      lv_name = cl_http_utility=>unescape_url( lv_name ).
    ENDIF.

    CLEAR es_item.
    es_item-obj_type = lv_type.
    es_item-obj_name = lv_name.
    ev_is_xml        = boolc( lv_ext = 'XML' AND strlen( lv_type ) = 4 ).

  ENDMETHOD.