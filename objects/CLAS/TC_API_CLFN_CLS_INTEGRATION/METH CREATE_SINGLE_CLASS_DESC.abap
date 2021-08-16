  METHOD create_single_class_desc.

    DATA(ls_class) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-s_class(
      class            = me->cs_class_single-class
      classtype        = me->cs_class_single-classtype ).

*--------------------------------------------------------------------*
* Prerequisites (delete & create class)
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
        it_classkeyword    = VALUE #( ( langu = 'E' catchword = 'Created from unit test (EN)' ) )
    ).
    COMMIT WORK AND WAIT.

    SELECT SINGLE * FROM i_clfnclassforkeydatetp( p_keydate = @sy-datum ) INTO @DATA(ls_class_created)
      WHERE class     = @ls_class-class
      AND   classtype = @ls_class-classtype ##WARN_OK.

*--------------------------------------------------------------------*
* Test create single class description
*--------------------------------------------------------------------*
    me->create_class_desc(
        is_class     = ls_class_created
        it_classdesc = VALUE #(
          ( language = 'D' classdescription = 'additional (DE)' )
        )
    ).

*--------------------------------------------------------------------*
* Check result from DB
*--------------------------------------------------------------------*
    SELECT * FROM i_clfnclassdescforkeydatetp( p_keydate = @sy-datum ) INTO TABLE @DATA(lt_classdesc)
      WHERE classinternalid = @ls_class_created-classinternalid.
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act              = lines( lt_classdesc )
        exp              = 2
        msg              = 'Creation of Single Class description failed' ).

  ENDMETHOD.