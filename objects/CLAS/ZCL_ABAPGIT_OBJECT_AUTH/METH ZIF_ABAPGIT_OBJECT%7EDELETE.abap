  METHOD zif_abapgit_object~delete.

    " there is a bug in SAP standard, the TADIR entries are not deleted
    " when the AUTH object is deleted in transaction SU20

    " FM SUSR_AUTF_DELETE_FIELD calls the UI, therefore we reimplement its logic

    DATA:
      lt_objlst TYPE susr_t_xuobject,
      lo_auth   TYPE REF TO cl_auth_tools,
      lv_dummy  TYPE string.

    " authority check
    CREATE OBJECT lo_auth.
    IF lo_auth->authority_check_suso( actvt     = '06'
                                      fieldname = mv_fieldname ) <> 0.
      MESSAGE e463(01) WITH mv_fieldname INTO lv_dummy.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

    " if field is used check
    lt_objlst = lo_auth->suso_where_used_afield( mv_fieldname ).
    IF lt_objlst IS NOT INITIAL.
      MESSAGE i453(01) WITH mv_fieldname INTO lv_dummy.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

    " collect fieldname into a transport task
    IF lo_auth->add_afield_to_trkorr( mv_fieldname ) <> 0.
      "no transport -> no deletion
      MESSAGE e507(0m) INTO lv_dummy.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

    DELETE FROM authx WHERE fieldname = mv_fieldname.
    IF sy-subrc <> 0.
      MESSAGE e507(0m) INTO lv_dummy.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

  ENDMETHOD.