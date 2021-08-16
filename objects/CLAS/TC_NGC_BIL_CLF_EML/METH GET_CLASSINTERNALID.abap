  METHOD get_classinternalid.

    SELECT SINGLE classinternalid FROM i_clfnclass
      INTO @rv_classinternalid
      WHERE
        class     = @iv_class AND
        classtype = @iv_classtype.

    cl_abap_unit_assert=>assert_subrc(
      act = sy-subrc
      exp = 0
      msg = |Class { iv_class } should exist| ).

  ENDMETHOD.