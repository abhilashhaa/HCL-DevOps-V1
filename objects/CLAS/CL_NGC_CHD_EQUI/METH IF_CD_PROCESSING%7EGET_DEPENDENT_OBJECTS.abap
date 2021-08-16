  METHOD if_cd_processing~get_dependent_objects.

    cl_ngc_chd_util=>get_instance( )->get_clf_object(
          EXPORTING
            it_object_id    = it_object_id
            iv_object_table = 'EQUI'
          CHANGING
            ct_clf_object   = rt_additional_object
     ).

  ENDMETHOD.