  METHOD DELETE_SINGLE_CLASS_CHARC.
    DATA(ls_class) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-s_class(
      class            = me->cs_class_single-class
      classtype        = me->cs_class_single-classtype ).
    DATA(ls_charc) = VALUE i_clfncharcforkeydatetp(
      characteristic   = me->cs_charc-characteristic_0
      charcdatatype    = me->cs_charc-charcdatatype
      charclength      = me->cs_charc-charclength ).
*--------------------------------------------------------------------*
* Check prerequisites (delete & create class, characteristic)
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

    SELECT SINGLE * FROM i_clfncharcforkeydatetp( p_keydate = @sy-datum ) INTO @DATA(ls_charc_created)
      WHERE characteristic = @ls_charc-characteristic ##WARN_OK.
    IF sy-subrc NE 0.
      me->create_charc(
        is_charc = ls_charc ).
    ENDIF.
    COMMIT WORK AND WAIT.

    me->mo_cls_bapi_util->create_class_api(
      EXPORTING
        iv_class           = ls_class-class
        iv_classtype       = ls_class-classtype
        is_classbasic      = VALUE #( )
        it_classkeyword    = VALUE #( ( langu = 'E' catchword = 'Created from unit test (EN)' ) )
        it_classcharc      = VALUE #( ( name_char = ls_charc-characteristic ) )
    ).
    COMMIT WORK AND WAIT.

    SELECT SINGLE * FROM i_clfnclassforkeydatetp( p_keydate = @sy-datum ) INTO @DATA(ls_class_created)
      WHERE class     = @ls_class-class
      AND   classtype = @ls_class-classtype ##WARN_OK.
    SELECT SINGLE * FROM i_clfncharcforkeydatetp( p_keydate = @sy-datum ) INTO @ls_charc_created
      WHERE characteristic = @ls_charc-characteristic ##WARN_OK.

*--------------------------------------------------------------------*
* Test create single characteristic assignment entry
*--------------------------------------------------------------------*
    DATA(ls_classcharc_delete) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-s_classcharc(
      classinternalid = ls_class_created-classinternalid
      charcinternalid = ls_charc_created-charcinternalid
    ).
    me->delete_class_charc( is_classcharc = ls_classcharc_delete ).

*--------------------------------------------------------------------*
* Check result from DB
*--------------------------------------------------------------------*
    SELECT * FROM i_clfnclasscharcforkeydatetp( p_keydate = @sy-datum ) INTO TABLE @DATA(lt_classcharc)
      WHERE classinternalid = @ls_class_created-classinternalid.
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act              = lines( lt_classcharc )
        exp              = 0
        msg              = 'Delete of Class Characteristic assignment description failed' ).

  ENDMETHOD.