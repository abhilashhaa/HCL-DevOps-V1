  METHOD delete_single_class.
*--------------------------------------------------------------------*
* Scenario: create a class with deep insert and delete a keyword, a
* characterisitc and a text from this class. Finally, delete the whole
* class.
*--------------------------------------------------------------------*
* Prerequistie (create & check)
*--------------------------------------------------------------------*
    DATA(ls_class) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-s_class(
      class            = me->cs_class_del-class
      classtype        = me->cs_class_del-classtype ).
    DATA(ls_charc) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-s_charc(
      characteristic   = me->cs_charc-characteristic_0
      charcdatatype    = me->cs_charc-charcdatatype
      charclength      = me->cs_charc-charclength ).

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

    SELECT SINGLE @abap_true FROM i_clfncharcforkeydatetp( p_keydate = @sy-datum ) INTO @data(lv_charc_exists)
      WHERE characteristic = @ls_charc-characteristic ##WARN_OK.
    IF lv_charc_exists EQ abap_false.
      me->create_charc(
        is_charc = ls_charc ).
      COMMIT WORK AND WAIT.
    ENDIF.

    me->mo_cls_bapi_util->create_class_api(
      EXPORTING
        iv_class           = ls_class-class
        iv_classtype       = ls_class-classtype
        is_classbasic      = VALUE #( )
        it_classkeyword    = VALUE #( ( langu = 'E' catchword = 'unit' )
                                      ( langu = 'E' catchword = 'test' )
                                      ( langu = 'E' catchword = 'execution' )
                                    )
        it_classtext       = VALUE #(
                              ( langu = 'E' text_type = '00'  text_descr = 'Longtext for unit test (EN)' )
                              ( langu = 'E' text_type = '01'  text_descr = 'Industry standard desc. for test (EN)' )
                             )
        it_classcharc      = VALUE #( ( name_char = ls_charc-characteristic ) )
    ).
    COMMIT WORK AND WAIT.

    SELECT SINGLE classinternalid FROM i_clfnclassforkeydatetp( p_keydate = @sy-datum ) INTO @DATA(lv_classinternalid)
      WHERE class     = @ls_class-class
      AND   classtype = @ls_class-classtype ##WARN_OK.

*--------------------------------------------------------------------*
* Test delete class with classinternalid
*--------------------------------------------------------------------*
    me->delete_class( iv_classinternalid = lv_classinternalid ).

*--------------------------------------------------------------------*
* Check result from DB
*--------------------------------------------------------------------*
    SELECT SINGLE @abap_true FROM i_clfnclassforkeydatetp( p_keydate = @sy-datum ) INTO @data(lv_class_deleted)
      WHERE classinternalid = @lv_classinternalid.
    cl_abap_unit_assert=>assert_initial(
      EXPORTING
        act = lv_class_deleted
        msg = 'Class is not deleted from the system' ).
    SELECT * FROM i_clfnclasstextforkeydatetp( p_keydate = @sy-datum ) INTO table @data(lt_classtext)
      WHERE classinternalid = @lv_classinternalid.
    cl_abap_unit_assert=>assert_initial(
      EXPORTING
        act = lt_classtext
        msg = 'Class text is not deleted from the system' ).
    SELECT * FROM i_clfnclassdescforkeydatetp( p_keydate = @sy-datum ) INTO TABLE @data(lt_classdesc)
      WHERE classinternalid = @lv_classinternalid.
    cl_abap_unit_assert=>assert_initial(
      EXPORTING
        act = lt_classdesc
        msg = 'Class desc is not deleted from the system' ).
    SELECT * FROM i_clfnclasskeywordforkeydatetp( p_keydate = @sy-datum ) INTO TABLE @data(lt_classkeyword)
      WHERE classinternalid = @lv_classinternalid.
    cl_abap_unit_assert=>assert_initial(
      EXPORTING
        act = lt_classkeyword
        msg = 'Class keyword is not deleted from the system' ).
    SELECT * FROM i_clfnclasstextforkeydatetp( p_keydate = @sy-datum ) INTO TABLE @data(lt_classcharc)
      WHERE classinternalid = @lv_classinternalid.
    cl_abap_unit_assert=>assert_initial(
      EXPORTING
        act = lt_classcharc
        msg = 'Class charc is not deleted from the system' ).

  ENDMETHOD.