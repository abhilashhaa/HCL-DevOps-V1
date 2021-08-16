  PRIVATE SECTION.
    TYPES:
      BEGIN OF ty_extension_index,
        dd12v   TYPE dd12v,
        t_dd17v TYPE STANDARD TABLE OF dd17v
                   WITH NON-UNIQUE DEFAULT KEY,
      END OF ty_extension_index.

    CONSTANTS:
      c_objtype_extension_index   TYPE trobjtype VALUE 'XINX'.

    DATA:
      mv_name TYPE ddobjname,
      mv_id   TYPE ddobjectid.

    METHODS:
      xinx_delete_docu
        IMPORTING
          iv_objname TYPE ddobjname
          iv_id      TYPE ddobjectid.
