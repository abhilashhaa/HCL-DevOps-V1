  METHOD zif_abapgit_object~exists.

    "  See Function Module SDU_MODEL_EXISTS

    SELECT COUNT( * ) FROM  dm40l
           WHERE  dmoid     = me->mv_data_model
           AND    as4local  = me->mv_activation_state.

    rv_bool = boolc( sy-subrc = 0 ).



  ENDMETHOD.