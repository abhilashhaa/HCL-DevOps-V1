  METHOD UPDATE_SINGLE_CLASS_KEYWORD.

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

    SELECT SINGLE classinternalid FROM i_clfnclassforkeydatetp( p_keydate = @sy-datum ) INTO @DATA(lv_classinternalid)
      WHERE class     = @ls_class-class
      AND   classtype = @ls_class-classtype ##WARN_OK.


*--------------------------------------------------------------------*
* Test create single class keyword entry
*--------------------------------------------------------------------*
    DATA(ls_classkeyword_update) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-s_classkeyword(
      classinternalid             = lv_classinternalid
      language                    = 'E'
      classkeywordpositionnumber  = 2
      classkeywordtext            = 'updated keyword EN'
    ).
    me->update_class_keyword( is_classkeyword = ls_classkeyword_update ).

*--------------------------------------------------------------------*
* Check result from DB
*--------------------------------------------------------------------*
    SELECT * FROM i_clfnclasskeywordforkeydatetp( p_keydate = @sy-datum ) INTO TABLE @DATA(lt_classkeyword)
      WHERE classinternalid            = @lv_classinternalid
      AND   classkeywordpositionnumber = @ls_classkeyword_update-classkeywordpositionnumber.

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act              = lt_classkeyword[ 1 ]-classkeywordtext
        exp              = ls_classkeyword_update-classkeywordtext
        msg              = 'Update of keyword for Class failed' ).

  ENDMETHOD.