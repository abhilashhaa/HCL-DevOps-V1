CLASS zcl_abapgit_object_w3super DEFINITION PUBLIC INHERITING FROM zcl_abapgit_objects_super ABSTRACT.

  PUBLIC SECTION.
    INTERFACES zif_abapgit_object.

    TYPES ty_wwwparams_tt TYPE STANDARD TABLE OF wwwparams WITH DEFAULT KEY.

    CONSTANTS: BEGIN OF c_param_names,
                 version  TYPE w3_name VALUE 'version',
                 fileext  TYPE w3_name VALUE 'fileextension',
                 filesize TYPE w3_name VALUE 'filesize',
                 filename TYPE w3_name VALUE 'filename',
                 mimetype TYPE w3_name VALUE 'mimetype',
               END OF c_param_names.

    METHODS constructor
      IMPORTING
        is_item     TYPE zif_abapgit_definitions=>ty_item
        iv_language TYPE spras.
