  METHOD zif_abapgit_persist_repo~update_metadata.

    DATA:
      lv_blob            TYPE zif_abapgit_persistence=>ty_content-data_str,
      ls_persistent_meta TYPE zif_abapgit_persistence=>ty_repo.

    FIELD-SYMBOLS <lv_field>   LIKE LINE OF mt_meta_fields.
    FIELD-SYMBOLS <lg_dst>     TYPE any.
    FIELD-SYMBOLS <lg_src>     TYPE any.
    FIELD-SYMBOLS <lv_changed> TYPE abap_bool.

    ASSERT NOT iv_key IS INITIAL.

    IF is_change_mask IS INITIAL.
      RETURN.
    ENDIF.

    " Validations
    IF is_change_mask-url = abap_true AND is_meta-url IS INITIAL.
      zcx_abapgit_exception=>raise( 'update, url empty' ).
    ENDIF.

    TRY.
        ls_persistent_meta = read( iv_key ).
      CATCH zcx_abapgit_not_found.
        zcx_abapgit_exception=>raise( 'repo key not found' ).
    ENDTRY.

    " Update
    LOOP AT mt_meta_fields ASSIGNING <lv_field>.
      ASSIGN COMPONENT <lv_field> OF STRUCTURE is_change_mask TO <lv_changed>.
      ASSERT sy-subrc = 0.
      CHECK <lv_changed> = abap_true.
      ASSIGN COMPONENT <lv_field> OF STRUCTURE ls_persistent_meta TO <lg_dst>.
      ASSERT sy-subrc = 0.
      ASSIGN COMPONENT <lv_field> OF STRUCTURE is_meta TO <lg_src>.
      ASSERT sy-subrc = 0.
      <lg_dst> = <lg_src>.
    ENDLOOP.

    lv_blob = to_xml( ls_persistent_meta ).

    mo_db->update( iv_type  = zcl_abapgit_persistence_db=>c_type_repo
                   iv_value = iv_key
                   iv_data  = lv_blob ).

  ENDMETHOD.