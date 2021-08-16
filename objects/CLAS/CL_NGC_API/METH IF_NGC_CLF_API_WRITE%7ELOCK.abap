  METHOD if_ngc_clf_api_write~lock.

*    DATA:
*      lo_clf_api_result          TYPE REF TO cl_ngc_clf_api_result.
*
*    CLEAR: eo_clf_api_result.
*
*    lo_clf_api_result = NEW cl_ngc_clf_api_result( ).
*
*    get_updated_data(
*      EXPORTING
*        it_classification_object   = it_classification_object
*      IMPORTING
*        et_core_classification_upd = DATA(lt_core_classification_upd)
*        et_core_class              = DATA(lt_core_class)
*        et_clf_core_message        = DATA(lt_clf_core_message)
*    ).
*
*    mo_clf_persistency->lock(
*      EXPORTING it_classification = lt_core_classification_upd
*                it_class          = lt_core_class
*      IMPORTING et_message        = lt_clf_core_message ).
*
*    lo_clf_api_result->add_messages_from_core_clf( lt_clf_core_message ).
*
*    eo_clf_api_result = lo_clf_api_result.

  ENDMETHOD.