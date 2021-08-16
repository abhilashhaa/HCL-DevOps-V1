  METHOD update_single_class_charc.
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

    SELECT SINGLE @abap_true FROM i_clfncharcforkeydatetp( p_keydate = @sy-datum ) INTO @DATA(lv_charc_exists)
      WHERE characteristic = @ls_charc-characteristic ##WARN_OK.
    IF lv_charc_exists NE abap_true.
      me->create_charc(
        is_charc = ls_charc ).
      COMMIT WORK AND WAIT.
    ENDIF.

    me->mo_cls_bapi_util->create_class_api(
      EXPORTING
        iv_class           = ls_class-class
        iv_classtype       = ls_class-classtype
        is_classbasic      = VALUE #( )
        it_classkeyword    = VALUE #( ( langu = 'E' catchword = 'Created from unit test (EN)' ) )
        it_classcharc      = VALUE #( ( name_char = ls_charc-characteristic ) )
    ).
    COMMIT WORK AND WAIT.

    SELECT SINGLE classinternalid FROM i_clfnclassforkeydatetp( p_keydate = @sy-datum ) INTO @DATA(lv_classinternalid)
      WHERE class     = @ls_class-class
      AND   classtype = @ls_class-classtype ##WARN_OK.
    SELECT SINGLE charcinternalid FROM i_clfncharcforkeydatetp( p_keydate = @sy-datum ) INTO @DATA(lv_charcinternalid)
      WHERE characteristic = @ls_charc-characteristic ##WARN_OK.

*--------------------------------------------------------------------*
* Test update single characteristic assignment entry
*--------------------------------------------------------------------*
    DATA(ls_classcharc_update) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-s_classcharc(
      classinternalid       = lv_classinternalid
      charcinternalid       = lv_charcinternalid
      charcissearchrelevant = abap_true
    ).
    me->update_class_charc( is_classcharc = ls_classcharc_update ).

*--------------------------------------------------------------------*
* Check result from DB
*--------------------------------------------------------------------*
    SELECT * FROM i_clfnclasscharcforkeydatetp( p_keydate = @sy-datum ) INTO TABLE @DATA(lt_classcharc)
      WHERE classinternalid = @lv_classinternalid
      AND   charcinternalid = @lv_charcinternalid.
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act              = lt_classcharc[ 1 ]-charcissearchrelevant
        exp              = ls_classcharc_update-charcissearchrelevant
        msg              = 'Update of Class Characteristic assignment description failed' ).

  ENDMETHOD.