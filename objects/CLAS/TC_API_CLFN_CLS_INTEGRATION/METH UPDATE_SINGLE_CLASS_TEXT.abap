  METHOD update_single_class_text.

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
        it_classkeyword    = VALUE #( ( langu = 'E' catchword = 'Created from unit test (EN)' ) )
        it_classtext       = VALUE #(
                              ( langu = 'E' text_type = '00'  text_descr = 'Longtext for unit test (EN)' )
                              ( langu = 'E' text_type = '01'  text_descr = 'Industry standard desc. for test (EN)' )
                             )
    ).
    COMMIT WORK AND WAIT.

    SELECT SINGLE classinternalid FROM i_clfnclassforkeydatetp( p_keydate = @sy-datum ) INTO @DATA(lv_classinternalid)
      WHERE class     = @ls_class-class
      AND   classtype = @ls_class-classtype ##WARN_OK.

*--------------------------------------------------------------------*
* Test update single class text
*--------------------------------------------------------------------*
    DATA(ls_classtext_update) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-s_classtext(
      classinternalid = lv_classinternalid
      language        = 'E'
      longtextid      = '0001'
      classtext       = 'updated longtext EN'
    ).
    me->update_class_text( is_classtext = ls_classtext_update ).
*--------------------------------------------------------------------*
* Check result from DB
*--------------------------------------------------------------------*
    SELECT * FROM i_clfnclasstextforkeydatetp( p_keydate = @sy-datum ) INTO TABLE @DATA(lt_classtext)
      WHERE classinternalid = @lv_classinternalid
      AND   longtextid      = @ls_classtext_update-longtextid
      AND   language        = @ls_classtext_update-language.
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act              = lt_classtext[ 1 ]-classtext
        exp              = ls_classtext_update-classtext
        msg              = 'Update of Class Texts failed' ).

  ENDMETHOD.