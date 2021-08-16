  METHOD create_batch_class_charc.
    DATA(ls_class) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-s_class(
      class            = me->cs_class_single-class
      classtype        = me->cs_class_single-classtype ).
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

    me->mo_cls_bapi_util->create_class_api(
      EXPORTING
        iv_class           = ls_class-class
        iv_classtype       = ls_class-classtype
        is_classbasic      = VALUE #( )
        it_classkeyword    = VALUE #( ( langu = 'E' catchword = 'Created from unit test (EN)' ) )
    ).
    COMMIT WORK AND WAIT.

    "check characteristic_0
    DATA(ls_charc) = VALUE i_clfncharcforkeydatetp(
       characteristic   = me->cs_charc-characteristic_0
       charcdatatype    = me->cs_charc-charcdatatype
       charclength      = me->cs_charc-charclength ).
    SELECT SINGLE @abap_true FROM i_clfncharcforkeydatetp( p_keydate = @sy-datum ) INTO @DATA(lv_charc_exists)
      WHERE characteristic = @ls_charc-characteristic ##WARN_OK.
    IF lv_charc_exists NE abap_true.
      me->create_charc(
        is_charc = ls_charc ).
      COMMIT WORK AND WAIT.
    ENDIF.

    "check characteristic_1
    ls_charc-characteristic   = me->cs_charc-characteristic_1.
    CLEAR lv_charc_exists.
    SELECT SINGLE @abap_true FROM i_clfncharcforkeydatetp( p_keydate = @sy-datum ) INTO @lv_charc_exists
      WHERE characteristic = @ls_charc-characteristic ##WARN_OK.
    IF lv_charc_exists NE abap_true.
      me->create_charc(
        is_charc = ls_charc ).
      COMMIT WORK AND WAIT.
    ENDIF.

    SELECT SINGLE * FROM i_clfnclassforkeydatetp( p_keydate = @sy-datum ) INTO @DATA(ls_class_created)
      WHERE class     = @ls_class-class
      AND   classtype = @ls_class-classtype ##WARN_OK.
    SELECT SINGLE charcinternalid FROM i_clfncharcforkeydatetp( p_keydate = @sy-datum ) INTO @DATA(lv_charcinternalid)
      WHERE characteristic = @me->cs_charc-characteristic_1 ##WARN_OK.

*--------------------------------------------------------------------*
* Test create characteristic assignment in batch
*--------------------------------------------------------------------*
    me->create_class_charc_in_batch(
        is_class     = ls_class_created
        it_classcharc = VALUE #(
          ( characteristic = me->cs_charc-characteristic_0 )
          ( charcinternalid = lv_charcinternalid ) "characteristic_1
    ) ).

*--------------------------------------------------------------------*
* Check result from DB
*--------------------------------------------------------------------*
    SELECT * FROM i_clfnclasscharcforkeydatetp( p_keydate = @sy-datum ) INTO TABLE @DATA(lt_classcharc)
      WHERE classinternalid = @ls_class_created-classinternalid.
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act              = lines( lt_classcharc )
        exp              = 2
        msg              = 'Creation of Class Characteristic n batch failed' ).

  ENDMETHOD.