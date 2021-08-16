  METHOD update_single_class.
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

    me->mo_cls_bapi_util->create_class_api(
      EXPORTING
        iv_class           = ls_class-class
        iv_classtype       = ls_class-classtype
        is_classbasic      = VALUE #( )
        it_classkeyword    = VALUE #( ( langu = 'E' catchword = 'description EN' ) )
    ).
    COMMIT WORK AND WAIT.

    SELECT SINGLE * FROM i_clfnclassforkeydatetp( p_keydate = @sy-datum ) INTO @DATA(ls_class_update)
      WHERE class     = @ls_class-class
      AND   classtype = @ls_class-classtype ##WARN_OK.

*--------------------------------------------------------------------*
* Test delete class with classinternalid
*--------------------------------------------------------------------*
    ls_class_update-classmaintauthgrp     = 'ABC'.
    ls_class_update-sameclassfctnreaction = 'W'.
    me->update_class( is_class =  ls_class_update ).

*--------------------------------------------------------------------*
* Check result from DB
*--------------------------------------------------------------------*
    SELECT SINGLE * FROM i_clfnclassforkeydatetp( p_keydate = @sy-datum ) INTO @DATA(ls_class_db)
      WHERE classinternalid = @ls_class_update-classinternalid.
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act = ls_class_db-classmaintauthgrp
        exp = ls_class_update-classmaintauthgrp
        msg = 'Class is not updated: classmaintauthgrp' ).
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act = ls_class_db-sameclassfctnreaction
        exp = ls_class_update-sameclassfctnreaction
        msg = 'Class is not updated: sameclassfctnreaction' ).

  ENDMETHOD.