  METHOD zif_abapgit_object~deserialize.

    DATA: ls_clskey TYPE seoclskey.

    deserialize_abap( ii_xml     = io_xml
                      iv_package = iv_package ).

    deserialize_tpool( io_xml ).

    deserialize_sotr( ii_ml     = io_xml
                      iv_package = iv_package ).

    deserialize_docu( io_xml ).

    " If a method was moved to an interface, abapGit does not remove the old
    " method include and it's necessary to repair the class (#3833)
    " TODO: Remove 2020-11 or replace with general solution
    IF ms_item-obj_name = 'ZCX_ABAPGIT_EXCEPTION'.
      ls_clskey-clsname = ms_item-obj_name.

      CALL FUNCTION 'SEO_CLASS_REPAIR_CLASSPOOL'
        EXPORTING
          clskey       = ls_clskey
        EXCEPTIONS
          not_existing = 1
          OTHERS       = 2.
      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise( |Error repairing class { ms_item-obj_name }| ).
      ENDIF.
    ENDIF.

  ENDMETHOD.