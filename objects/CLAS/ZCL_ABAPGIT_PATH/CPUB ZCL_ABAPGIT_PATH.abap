CLASS zcl_abapgit_path DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS split_file_location
      IMPORTING iv_fullpath TYPE string
      EXPORTING ev_path     TYPE string
                ev_filename TYPE string.

    CLASS-METHODS is_root
      IMPORTING iv_path       TYPE string
      RETURNING VALUE(rv_yes) TYPE abap_bool.

    CLASS-METHODS is_subdir
      IMPORTING iv_path       TYPE string
                iv_parent     TYPE string
      RETURNING VALUE(rv_yes) TYPE abap_bool.

    CLASS-METHODS change_dir
      IMPORTING iv_cur_dir     TYPE string
                iv_cd          TYPE string
      RETURNING VALUE(rv_path) TYPE string.

    CLASS-METHODS get_filename_from_syspath
      IMPORTING iv_path            TYPE string
      RETURNING VALUE(rv_filename) TYPE string.
