  METHOD if_ngc_bil_clf_eml~create_obj_objclass.

    CLEAR: es_mapped, es_failed, es_reported.

    MODIFY ENTITY i_clfnobjecttp
      CREATE BY \_objectclass
        FROM it_input
          MAPPED   es_mapped
          FAILED   es_failed
          REPORTED es_reported.

  ENDMETHOD.