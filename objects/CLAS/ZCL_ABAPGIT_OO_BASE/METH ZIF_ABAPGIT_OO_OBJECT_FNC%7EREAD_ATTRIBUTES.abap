  METHOD zif_abapgit_oo_object_fnc~read_attributes.
    SELECT cmpname attbusobj attkeyfld
      FROM seocompodf
      INTO CORRESPONDING FIELDS OF TABLE rt_attributes
      WHERE clsname = iv_object_name
        AND ( attbusobj <> space OR attkeyfld <> space )
        AND version = '1'
      ORDER BY PRIMARY KEY.
  ENDMETHOD.