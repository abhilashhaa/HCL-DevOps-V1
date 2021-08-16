  METHOD if_ngc_bil_clf_eml~read_obj_objcharc.

    CLEAR: et_result,et_link, es_failed, es_reported.

*   Currently there are no separate cases to get the full result and to get the 'link' table with the source and target keys
*   Retrieving of the 'link' table without providing the full result is not supported by the NGC API

    READ ENTITY i_clfnobjecttp
      BY \_objectcharc
        FROM it_input
          RESULT   et_result
          LINK     et_link
          FAILED   es_failed
          REPORTED es_reported.

  ENDMETHOD.