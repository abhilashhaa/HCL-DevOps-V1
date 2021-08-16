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