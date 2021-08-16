  METHOD setup_class.
    " Call
    rv_classinternalid = create_class( is_class = is_class it_classdesc = it_classdesc ).
    " Get data from DB
    SELECT SINGLE * FROM i_clfnclassforkeydatetp( p_keydate = @sy-datum ) INTO @DATA(ls_class)
      WHERE class     = @is_class-class
      AND   classtype = @is_class-classtype ##WARN_OK.
    cl_abap_unit_assert=>assert_not_initial(
      EXPORTING
        act              = ls_class
        msg              = 'Class creation failed' ).
  ENDMETHOD.