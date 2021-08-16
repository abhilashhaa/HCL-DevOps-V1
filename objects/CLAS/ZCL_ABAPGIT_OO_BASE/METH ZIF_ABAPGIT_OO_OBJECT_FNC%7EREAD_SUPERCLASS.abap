  METHOD zif_abapgit_oo_object_fnc~read_superclass.
    SELECT SINGLE refclsname FROM vseoextend INTO rv_superclass
      WHERE clsname = iv_classname.
  ENDMETHOD.