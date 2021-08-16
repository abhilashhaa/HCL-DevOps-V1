  METHOD if_ngc_bil_clf_eml~create_objcharc_objcharcval.

    CLEAR: es_mapped, es_failed, es_reported.

    MODIFY ENTITY i_clfnobjectcharctp
      CREATE BY \_objectcharcvalue
        FROM it_input
          MAPPED   es_mapped
          FAILED   es_failed
          REPORTED es_reported.

  ENDMETHOD.