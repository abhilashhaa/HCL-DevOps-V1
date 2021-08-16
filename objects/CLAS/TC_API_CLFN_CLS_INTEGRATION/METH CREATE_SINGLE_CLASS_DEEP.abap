  METHOD CREATE_SINGLE_CLASS_DEEP.
    DATA(ls_class) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-s_class(
      class            = me->cs_class_cre-class
      classtype        = me->cs_class_cre-classtype ).
    DATA(ls_charc) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-s_charc(
      characteristic   = me->cs_charc-characteristic_0
      charcdatatype    = me->cs_charc-charcdatatype
      charclength      = me->cs_charc-charclength ).
*--------------------------------------------------------------------*
* Check prerequisites
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
    " Check characteristic
    SELECT SINGLE @abap_true FROM i_clfncharcforkeydatetp( p_keydate = @sy-datum ) INTO @DATA(lv_charc_exists)
      WHERE characteristic = @ls_charc-characteristic ##WARN_OK.
    IF lv_charc_exists NE abap_true.
      me->create_charc(
        is_charc = ls_charc ).
      COMMIT WORK AND WAIT.
    ENDIF.
*--------------------------------------------------------------------*
* Test create class with description / keywords / text / characteristics
*--------------------------------------------------------------------*
    DATA(lv_classinternalid) = me->create_class(
        is_class     = ls_class
        it_classdesc = VALUE #(
          ( language = 'E' classdescription = 'Created from unit test (EN)' )
          ( language = 'D' classdescription = 'Created from unit test (DE)' )
        )
        it_classkeyword = VALUE #(
          ( language = 'E' classkeywordtext = 'unit' )
          ( language = 'E' classkeywordtext = 'test' )
          ( language = 'E' classkeywordtext = 'execution' )
        )
        it_classtext = VALUE #(
          ( language = 'E' longtextid = '0000'  classtext = 'Longtext for unit test (EN)' )
          ( language = 'E' longtextid = '0001'  classtext = 'Industry standard desc. for test (EN)' )
          ( language = 'E' longtextid = '0002'  classtext = 'Standard title for unit test (EN)' )
        )
         it_classcharc = VALUE #(
           ( characteristic = ls_charc-characteristic )
         )
    ).
*--------------------------------------------------------------------*
* Check result from DB
*--------------------------------------------------------------------*
    SELECT SINGLE * FROM i_clfnclassforkeydatetp( p_keydate = @sy-datum ) INTO @DATA(ls_class_created)
      WHERE class     = @ls_class-class
      AND   classtype = @ls_class-classtype ##WARN_OK.
    cl_abap_unit_assert=>assert_not_initial(
      EXPORTING
        act              = ls_class_created
        msg              = 'Class creation failed (deep)' ).
    SELECT * FROM i_clfnclassdescforkeydatetp( p_keydate = @sy-datum ) INTO TABLE @DATA(lt_classdesc)
      WHERE classinternalid = @lv_classinternalid.
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act              = lines( lt_classdesc )
        exp              = 2
        msg              = 'Creation of Description for Class failed (deep)' ).
    SELECT * FROM i_clfnclasskeywordforkeydatetp( p_keydate = @sy-datum ) INTO TABLE @DATA(lt_classkeyword)
      WHERE classinternalid = @lv_classinternalid.
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act              = lines( lt_classkeyword )
        exp              = 3
        msg              = 'Creation of Keyword for Class failed (deep)' ).
    SELECT * FROM i_clfnclasstextforkeydatetp( p_keydate = @sy-datum ) INTO TABLE @DATA(lt_classtext)
      WHERE classinternalid = @lv_classinternalid.
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act              = lines( lt_classtext )
        exp              = 3
        msg              = 'Creation of Texts for Class failed (deep)' ).
    SELECT * FROM i_clfnclasscharcforkeydatetp( p_keydate = @sy-datum ) INTO TABLE @DATA(lt_classcharc)
      WHERE classinternalid = @lv_classinternalid.
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act              = lines( lt_classcharc )
        exp              = 1
        msg              = 'Creation of Class Characteristic assignment failed (deep)' ).

  ENDMETHOD.