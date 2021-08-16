  PRIVATE SECTION.
    TYPES: BEGIN OF ty_spaces,
             full_name TYPE string.
    TYPES: spaces TYPE STANDARD TABLE OF i WITH DEFAULT KEY,
           END OF ty_spaces.

    TYPES: ty_spaces_tt TYPE STANDARD TABLE OF ty_spaces WITH DEFAULT KEY.

    DATA: ms_item TYPE zif_abapgit_definitions=>ty_item.
    DATA: mo_files TYPE REF TO zcl_abapgit_objects_files.

    METHODS hook_impl_deserialize
      IMPORTING it_spaces TYPE ty_spaces_tt
      CHANGING  ct_impl   TYPE enh_hook_impl_it
      RAISING   zcx_abapgit_exception.
