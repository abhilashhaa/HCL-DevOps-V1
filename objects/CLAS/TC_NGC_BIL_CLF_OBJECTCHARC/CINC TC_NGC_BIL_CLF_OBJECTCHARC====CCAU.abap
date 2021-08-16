CLASS ltc_ngc_bil_clf_objectcharc DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS
  FINAL
  INHERITING FROM tc_ngc_bil_clf_objectcharc.
ENDCLASS.

CLASS ltd_ngc_api DEFINITION FOR TESTING FINAL.
  PUBLIC SECTION.
    INTERFACES if_ngc_api.
ENDCLASS.

CLASS ltd_ngc_api IMPLEMENTATION.
  METHOD if_ngc_clf_api_read~read.
    DATA:
      lo_clf_api_result TYPE REF TO cl_ngc_clf_api_result,
      lt_message        TYPE ngct_classification_msg.

    lo_clf_api_result = NEW #( ).
    LOOP AT it_classification_key ASSIGNING FIELD-SYMBOL(<ls_classification_key>).
      IF    <ls_classification_key>-object_key IS INITIAL
        OR  <ls_classification_key>-technical_object IS INITIAL.
        APPEND INITIAL LINE TO lt_message ASSIGNING FIELD-SYMBOL(<ls_message>).
          <ls_message>-object_key       = <ls_classification_key>-object_key.
          <ls_message>-technical_object = <ls_classification_key>-technical_object.
          <ls_message>-key_date         = <ls_classification_key>-key_date.
          <ls_message>-msgty            = 'E'.
      ENDIF.
    ENDLOOP.
    lo_clf_api_result->add_messages( it_message = lt_message ).
    eo_clf_api_result = lo_clf_api_result.
  ENDMETHOD.

ENDCLASS.