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