  METHOD convert_attrib_to_vseoattrib.
    FIELD-SYMBOLS: <ls_attribute>  LIKE LINE OF it_attributes,
                   <ls_vseoattrib> LIKE LINE OF rt_vseoattrib.

    LOOP AT it_attributes ASSIGNING <ls_attribute>.
      INSERT INITIAL LINE INTO TABLE rt_vseoattrib ASSIGNING <ls_vseoattrib>.
      MOVE-CORRESPONDING <ls_attribute> TO <ls_vseoattrib>.
      <ls_vseoattrib>-clsname = iv_clsname.
      UNASSIGN <ls_vseoattrib>.
    ENDLOOP.
    UNASSIGN <ls_attribute>.
  ENDMETHOD.