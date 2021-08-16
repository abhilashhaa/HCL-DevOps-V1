  PRIVATE SECTION.
    TYPES:
      BEGIN OF ty_devclass_info,
        devclass  TYPE devclass,
        namespace TYPE namespace,
        parentcl  TYPE parentcl,
      END OF ty_devclass_info .
    TYPES:
      ty_devclass_info_tt TYPE SORTED TABLE OF ty_devclass_info
        WITH UNIQUE KEY devclass .
    DATA mt_parent TYPE ty_devclass_info_tt .