CLASS lcl_ngc_db_access DEFINITION.
  PUBLIC SECTION.
    INTERFACES: if_ngc_rap_cls_bapi_util.
ENDCLASS.

CLASS lcl_ngc_db_access IMPLEMENTATION.

*  METHOD if_ngc_rap_cls_bapi_util~get_characteristic.
*
*    IF iv_charcinternalid NE 0.
*      SELECT SINGLE FROM i_clfncharcforkeydatetp( p_keydate = @sy-datum )
*        FIELDS characteristic
*        WHERE charcinternalid EQ @iv_charcinternalid
*        INTO @rv_characteristic.
*    ELSE.
*      IF iv_charcinternalid CO '0 '.
*        CLEAR rv_characteristic.
*      ELSE.
*        rv_characteristic = iv_charcinternalid.
*      ENDIF.
*    ENDIF.
*
*  ENDMETHOD.

*  METHOD if_ngc_rap_cls_bapi_util~get_charcinternalid.
*
*    CHECK iv_characteristic IS NOT INITIAL.
*
*    DATA(lv_characteristic) = iv_characteristic.
*
*    CONDENSE lv_characteristic NO-GAPS.
*
*    SELECT SINGLE FROM i_clfncharcforkeydatetp( p_keydate = @sy-datum ) "#EC CI_NOORDER
*      FIELDS charcinternalid
*      WHERE characteristic = @lv_characteristic
*      INTO @rv_charcinternalid ##WARN_OK.
*
*    IF sy-subrc IS NOT INITIAL.
*      rv_charcinternalid = iv_characteristic.
*    ENDIF.
*
*  ENDMETHOD.

*  METHOD if_ngc_rap_cls_bapi_util~single_class_by_ext_id.
*    SELECT SINGLE * FROM i_clfnclassforkeydatetp( p_keydate = @iv_keydate )
*      WHERE class     = @iv_class
*      AND   classtype = @iv_classtype
*      INTO @DATA(ls_class).
*
*    IF sy-subrc IS INITIAL.
*      rs_class = ls_class.
*    ENDIF.
*  ENDMETHOD.

*  METHOD if_ngc_rap_cls_bapi_util~single_class_by_int_id.
*    SELECT SINGLE * FROM i_clfnclassforkeydatetp( p_keydate = @iv_keydate )
*      WHERE classinternalid = @iv_classinternalid
*      INTO @rs_class.
*  ENDMETHOD.

*  METHOD if_ngc_rap_cls_bapi_util~check_class_exists_by_id.
*    SELECT SINGLE @abap_true FROM i_clfnclassforkeydatetp( p_keydate = @iv_keydate )
*      WHERE classinternalid = @iv_classinternalid
*      INTO @rv_exists.
*  ENDMETHOD.

*  METHOD if_ngc_rap_cls_bapi_util~classkeyword_by_int_id.
*    SELECT * FROM i_clfnclasskeywordforkeydatetp( p_keydate = @iv_keydate )
*      WHERE classinternalid = @iv_classinternalid
*      ORDER BY
*        language,
*        classkeywordpositionnumber
*      INTO TABLE @rt_classkeyword.
*  ENDMETHOD.

*  METHOD if_ngc_rap_cls_bapi_util~classdesc_by_int_id.
*    SELECT * FROM i_clfnclassdescforkeydatetp( p_keydate = @iv_keydate )
*      WHERE classinternalid = @iv_classinternalid
*      INTO TABLE @rt_classdesc.
*  ENDMETHOD.

*  METHOD if_ngc_rap_cls_bapi_util~classtext_by_int_id.
*    SELECT * FROM i_clfnclasstextforkeydatetp( p_keydate = @iv_keydate )
*      WHERE classinternalid = @iv_classinternalid
*      INTO TABLE @rt_classtext.
*  ENDMETHOD.

*  METHOD if_ngc_rap_cls_bapi_util~classcharc_by_int_id.
*    SELECT * FROM i_clfnclasscharcforkeydatetp( p_keydate = @iv_keydate )
*      WHERE classinternalid = @iv_classinternalid
*      INTO TABLE @rt_classcharc.
*  ENDMETHOD.

*  METHOD if_ngc_rap_cls_bapi_util~charc_by_int_id.
*
*    DATA:
*      lt_charc_range TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-t_charc_range,
*      ls_charc_range TYPE LINE OF cl_ngc_bil_cls=>lty_clfn_class_cds-t_charc_range.
*
*    ls_charc_range-sign   = if_ngc_core_c=>gc_range_sign-include.
*    ls_charc_range-option = if_ngc_core_c=>gc_range_option-equals.
*    LOOP AT it_charc_id ASSIGNING FIELD-SYMBOL(<ls_charc_id>).
*      ls_charc_range-low = <ls_charc_id>-charcinternalid.
*      APPEND ls_charc_range TO lt_charc_range.
*    ENDLOOP.
*
*    SELECT * FROM i_clfncharcforkeydatetp( p_keydate = @<ls_charc_id>-key_date )
*      WHERE charcinternalid IN @lt_charc_range
*      INTO TABLE @rt_charc.
*  ENDMETHOD.

  METHOD if_ngc_rap_cls_bapi_util~delete_class_api.

    CLEAR: rt_return.

    CALL FUNCTION 'BAPI_CLASS_DELETE'
      EXPORTING
        classtype = iv_classtype
        classnum  = iv_class
      TABLES
        return    = rt_return.

  ENDMETHOD.

  METHOD if_ngc_rap_cls_bapi_util~delete_classtext_api.

    DATA:
      lt_classtext_bapi TYPE STANDARD TABLE OF klklat,
      lv_error          TYPE syst_binpt.

    LOOP AT it_classtext ASSIGNING FIELD-SYMBOL(<ls_classtext>).
      APPEND INITIAL LINE TO lt_classtext_bapi ASSIGNING FIELD-SYMBOL(<ls_classtext_bapi>).
      <ls_classtext_bapi>-spras = <ls_classtext>-langu.
      <ls_classtext_bapi>-txtid = |00{ <ls_classtext>-text_type }|.
      <ls_classtext_bapi>-txtbz = <ls_classtext>-text_descr.
    ENDLOOP.

    CALL FUNCTION 'CLCM_CLASS_TEXT_DELETE'
      EXPORTING
        classname            = iv_class
        classtype            = iv_classtype
      IMPORTING
        error                = lv_error
      TABLES
        tklat                = lt_classtext_bapi
      EXCEPTIONS
        class_invalid_change = 1.

    IF sy-subrc = 1.
      " Class text cannot be removed
      MESSAGE e048(ngc_rap) INTO DATA(lv_message) ##NEEDED.
      APPEND VALUE bapiret2( id = 'NGC_RAP' number = 048 type = 'E' ) TO rt_return.
    ENDIF.

    IF lv_error IS NOT INITIAL.
      APPEND VALUE bapiret2(
        id = sy-msgid number = sy-msgno type = sy-msgty message_v1 = sy-msgv1 message_v2 = sy-msgv2 message_v3 = sy-msgv3 message_v4 = sy-msgv4 )
        TO rt_return.
    ENDIF.

  ENDMETHOD.

  METHOD if_ngc_rap_cls_bapi_util~create_class_api.

    DATA(lt_classcharc)   = it_classcharc.
    DATA(lt_classtext)    = it_classtext.
    DATA(lt_classkeyword) = it_classkeyword.
    DATA(ls_classbasic)   = is_classbasic.

    CALL FUNCTION 'BAPI_CLASS_CREATE'
      EXPORTING
        classnumnew          = iv_class
        classtypenew         = iv_classtype
        classbasicdata       = ls_classbasic
*       CLASSDOCUMENT        = is_classdocument
*       CLASSADDITIONAL      = is_classadditional
*       CLASSSTANDARD        = is_classstandard
      TABLES
        return               = rt_return
        classdescriptions    = lt_classkeyword
        classlongtexts       = lt_classtext
        classcharacteristics = lt_classcharc.

  ENDMETHOD.

  METHOD if_ngc_rap_cls_bapi_util~change_class_api.

    CLEAR rt_return.

    DATA(lt_classcharc_new)   = it_classcharc_new.
    DATA(lt_classtext_new)    = it_classtext_new.
    DATA(lt_classkeyword_new) = it_classkeyword_new.

    CALL FUNCTION 'BAPI_CLASS_CHANGE'
      EXPORTING
        classnum                = iv_class
        classtype               = iv_classtype
*       CHANGENUMBER            = iv_changenumber
*       KEYDATE                 = SY-DATUM
        classbasicdata          = is_classbasic
        classbasicdatanew       = is_classbasic_new
*       CLASSDOCUMENT           =
*       CLASSDOCUMENTNEW        =
*       CLASSADDITIONAL         =
*       CLASSADDITIONALNEW      =
*       CLASSSTANDARD           =
*       CLASSSTANDARDNEW        =
      TABLES
        return                  = rt_return
        classdescriptions       = it_classkeyword
        classlongtexts          = it_classtext
        classcharacteristics    = it_classcharc
        classdescriptionsnew    = lt_classkeyword_new
        classlongtextsnew       = lt_classtext_new
        classcharacteristicsnew = lt_classcharc_new.

  ENDMETHOD.

  METHOD if_ngc_rap_cls_bapi_util~clear_bapi_buffer.

    CALL FUNCTION 'CLCM_INIT_BUFFER'.

  ENDMETHOD.

  METHOD if_ngc_rap_cls_bapi_util~get_classintid_from_buffer.

    DATA:
      lt_klah TYPE STANDARD TABLE OF klah.

    APPEND VALUE #( klart = iv_classtype
                    class = iv_class ) TO lt_klah.

    CALL FUNCTION 'CLSE_SELECT_KLAH'
      TABLES
        imp_exp_klah   = lt_klah
      EXCEPTIONS
        no_entry_found = 1
        OTHERS         = 2.

    IF sy-subrc = 0.
      DATA(ls_class) = VALUE #( lt_klah[ klart = iv_classtype
                                         class = iv_class ] OPTIONAL ).
      IF ls_class IS NOT INITIAL.
        rs_classinternalid = ls_class-clint.
      ENDIF.
    ENDIF.

  ENDMETHOD.

  METHOD if_ngc_rap_cls_bapi_util~get_classkeyword_from_buffer.

    DATA:
      lt_swor TYPE STANDARD TABLE OF swor.

    APPEND VALUE #( clint = is_classkeyword-classinternalid ) TO lt_swor.

    CALL FUNCTION 'CLSE_SELECT_SWOR'
      TABLES
        imp_exp_swor   = lt_swor
      EXCEPTIONS
        no_entry_found = 1
        OTHERS         = 2.

    IF sy-subrc = 0.
      DATA(ls_swor) = VALUE #( lt_swor[ spras = is_classkeyword-language
                                        kschl = is_classkeyword-classkeywordtext ] OPTIONAL ).
      IF ls_swor IS NOT INITIAL.
        rs_classkeyword-classinternalid            = ls_swor-clint.
        rs_classkeyword-language                   = ls_swor-spras.
        rs_classkeyword-classkeywordtext           = ls_swor-kschl.
        rs_classkeyword-classkeywordpositionnumber = ls_swor-klpos.
      ENDIF.
    ENDIF.
  ENDMETHOD.

*  METHOD if_ngc_rap_cls_bapi_util~get_classtext_from_buffer.
*
*    DATA:
*      lt_klat TYPE STANDARD TABLE OF klat,
*      ls_klat TYPE klat.
*
*    ls_klat-clint = is_classtext-classinternalid.
*    APPEND ls_klat TO lt_klat.
*
*    CALL FUNCTION 'CLSE_SELECT_KLAT'
*      TABLES
*        imp_exp_klat   = lt_klat
*      EXCEPTIONS
*        no_entry_found = 1
*        OTHERS         = 2.
*
*    IF sy-subrc = 0.
*      READ TABLE lt_klat ASSIGNING FIELD-SYMBOL(<ls_klat>)
*      WITH KEY spras = is_classtext-language txtid = is_classtext-longtextid.
*      IF sy-subrc = 0.
*        rs_classtext-classinternalid  = <ls_klat>-clint.
*        rs_classtext-language         = <ls_klat>-spras.
*        rs_classtext-classtext        = <ls_klat>-txtbz.
*        rs_classtext-longtextid       = <ls_klat>-txtid.
*      ENDIF.
*    ENDIF.
*  ENDMETHOD.

*  METHOD if_ngc_rap_cls_bapi_util~get_classcharc_from_buffer.
*
*    DATA:
*      lt_ksml TYPE STANDARD TABLE OF ksml,
*      ls_ksml TYPE ksml.
*
*    ls_ksml-clint = is_classcharc-classinternalid.
*    APPEND ls_ksml TO lt_ksml.
*
*    CALL FUNCTION 'CLSE_SELECT_KSML'
*      TABLES
*        imp_exp_ksml   = lt_ksml
*      EXCEPTIONS
*        no_entry_found = 1
*        OTHERS         = 2.
*
*    IF sy-subrc = 0.
*      READ TABLE lt_ksml ASSIGNING FIELD-SYMBOL(<ls_ksml>)
*      WITH KEY imerk = is_classcharc-charcinternalid.
*      IF sy-subrc = 0.
*        rs_classcharc-classinternalid         = <ls_ksml>-clint.
*        rs_classcharc-charcinternalid         = <ls_ksml>-imerk.
*        rs_classcharc-charcpositionnumber     = <ls_ksml>-posnr.
**       rs_classcharc-clfnorganizationalarea  = <ls_ksml>-abtei.
**       rs_classcharc-charccodeletter         = <ls_ksml>-dinkb.
**       rs_classcharc-charcorigin             = <ls_ksml>-herku.
*        rs_classcharc-originalcharcinternalid = <ls_ksml>-omerk.
*        rs_classcharc-validitystartdate       = <ls_ksml>-datuv.
*        rs_classcharc-validityenddate         = <ls_ksml>-datub.
*        rs_classcharc-changenumber            = <ls_ksml>-aennr.
*      ENDIF.
*    ENDIF.
*  ENDMETHOD.

*  METHOD if_ngc_rap_cls_bapi_util~classtext_id.
*    SELECT * FROM tclx
*      WHERE klart = @iv_classtype
*      INTO TABLE @rt_classtext_id.
*  ENDMETHOD.

ENDCLASS.