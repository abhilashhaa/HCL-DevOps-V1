  METHOD zif_abapgit_object~serialize.

* see SAP note 1025291, run report DELETE_TADIR_FOR_EIMP_INCLUDE to clean bad TADIR entries
    ASSERT NOT ms_item-obj_name CP '*=E'.

    serialize_program( io_xml   = io_xml
                       is_item  = ms_item
                       io_files = mo_files ).

    " Texts serializing (translations)
    serialize_texts( io_xml ).

    serialize_longtexts( ii_xml         = io_xml
                         iv_longtext_id = c_longtext_id_prog ).

  ENDMETHOD.