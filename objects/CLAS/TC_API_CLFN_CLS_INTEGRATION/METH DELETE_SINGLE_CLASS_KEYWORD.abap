  METHOD delete_single_class_keyword.

    DATA(ls_class) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-s_class(
      class            = me->cs_class_single-class
      classtype        = me->cs_class_single-classtype ).

*--------------------------------------------------------------------*
* Check prerequisites (delete & create class)
*--------------------------------------------------------------------*
    SELECT SINGLE @abap_true FROM i_clfnclassforkeydatetp( p_keydate = @sy-datum ) INTO @DATA(lv_class_exists)
      WHERE class     = @ls_class-class
      AND   classtype = @ls_class-classtype ##WARN_OK.
    IF lv_class_exists EQ abap_true.
      me->mo_cls_bapi_util->delete_class_api(
        EXPORTING
          iv_class     = ls_class-class
          iv_classtype = ls_class-classtype
      ).
      COMMIT WORK AND WAIT.
    ENDIF.

    me->mo_cls_bapi_util->create_class_api(
      EXPORTING
        iv_class           = ls_class-class
        iv_classtype       = ls_class-classtype
        is_classbasic      = VALUE #( )
        it_classkeyword    = VALUE #( ( langu = 'E' catchword = 'Created from unit test (EN)' )
                                      ( langu = 'E' catchword = 'unit' )
                                      ( langu = 'E' catchword = 'test' )
                                      ( langu = 'E' catchword = 'execution' )
                                    )
    ).
    COMMIT WORK AND WAIT.

    SELECT SINGLE * FROM i_clfnclassforkeydatetp( p_keydate = @sy-datum ) INTO @DATA(ls_class_created)
      WHERE class     = @ls_class-class
      AND   classtype = @ls_class-classtype ##WARN_OK.
    SELECT * FROM i_clfnclasskeywordforkeydatetp( p_keydate = @sy-datum ) INTO TABLE @DATA(lt_classkeyword_delete)
      WHERE classinternalid = @ls_class_created-classinternalid
      and   language  = 'E'
      AND   classkeywordtext = 'unit'. "get keyword unit for deletion

*--------------------------------------------------------------------*
* Test create single class keyword entry
*--------------------------------------------------------------------*
    me->delete_class_keyword( is_classkeyword = value #( lt_classkeyword_delete[ 1 ] ) ).

*--------------------------------------------------------------------*
* Check result from DB
*--------------------------------------------------------------------*
    SELECT * FROM i_clfnclasskeywordforkeydatetp( p_keydate = @sy-datum ) INTO TABLE @DATA(lt_classkeyword)
      WHERE classinternalid = @ls_class_created-classinternalid
      AND   classkeywordtext = 'unit'.

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act              = lines( lt_classkeyword )
        exp              = 0
        msg              = 'Delete of keyword for Class failed' ).

  ENDMETHOD.