CLASS zcl_abapgit_object_fugr DEFINITION PUBLIC INHERITING FROM zcl_abapgit_objects_program FINAL.

  PUBLIC SECTION.
    INTERFACES zif_abapgit_object.
    ALIASES mo_files FOR zif_abapgit_object~mo_files.
