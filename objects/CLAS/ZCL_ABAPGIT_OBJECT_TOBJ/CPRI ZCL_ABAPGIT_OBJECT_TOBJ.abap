  PRIVATE SECTION.
    TYPES: BEGIN OF ty_tobj,
             tddat TYPE tddat,
             tvdir TYPE tvdir,
             tvimf TYPE STANDARD TABLE OF tvimf WITH DEFAULT KEY,
           END OF ty_tobj.

    METHODS:
      read_extra IMPORTING iv_tabname     TYPE vim_name
                 RETURNING VALUE(rs_tobj) TYPE ty_tobj,
      update_extra IMPORTING is_tobj TYPE ty_tobj,
      delete_extra IMPORTING iv_tabname TYPE vim_name.
