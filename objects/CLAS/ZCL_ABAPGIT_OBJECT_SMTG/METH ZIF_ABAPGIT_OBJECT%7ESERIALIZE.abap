  METHOD zif_abapgit_object~serialize.

    DATA:
      lr_template TYPE REF TO data,
      lx_error    TYPE REF TO cx_root,
      lo_template TYPE REF TO object.

    FIELD-SYMBOLS:
      <lg_template> TYPE data,
      <lg_header>   TYPE data,
      <lt_header>   TYPE INDEX TABLE,
      <lt_content>  TYPE INDEX TABLE.

    mo_structdescr = get_structure( ).

    CREATE DATA lr_template TYPE HANDLE mo_structdescr.
    ASSIGN lr_template->* TO <lg_template>.
    ASSERT sy-subrc = 0.

    ASSIGN
      COMPONENT 'HEADER'
      OF STRUCTURE <lg_template>
      TO <lg_header>.
    ASSERT sy-subrc = 0.

    ASSIGN
      COMPONENT 'HEADER_T'
      OF STRUCTURE <lg_template>
      TO <lt_header>.
    ASSERT sy-subrc = 0.

    ASSIGN
      COMPONENT 'CONTENT'
      OF STRUCTURE <lg_template>
      TO <lt_content>.
    ASSERT sy-subrc = 0.

    TRY.
        CALL METHOD ('CL_SMTG_EMAIL_TEMPLATE')=>get
          EXPORTING
            iv_id       = mv_template_id
          RECEIVING
            ro_instance = lo_template.

        CALL METHOD lo_template->('IF_SMTG_EMAIL_TEMPLATE~GET_TMPL_HDR')
          RECEIVING
            rs_tmpl_hdr = <lg_header>.

        CALL METHOD lo_template->('IF_SMTG_EMAIL_TEMPLATE~GET_TMPL_HDR_T_ALL')
          RECEIVING
            rt_tmpl_hdr_t = <lt_header>.

        CALL METHOD lo_template->('IF_SMTG_EMAIL_TEMPLATE~GET_TMPL_CONT_ALL')
          RECEIVING
            rt_tmpl_cont = <lt_content>.

        clear_field( EXPORTING iv_fieldname = 'CREA_DATE_TIME'   CHANGING cg_header = <lg_header> ).
        clear_field( EXPORTING iv_fieldname = 'CREA_USER_ACCT'   CHANGING cg_header = <lg_header> ).
        clear_field( EXPORTING iv_fieldname = 'LST_CH_DATE_TIME' CHANGING cg_header = <lg_header> ).
        clear_field( EXPORTING iv_fieldname = 'LST_CH_USER_ACCT' CHANGING cg_header = <lg_header> ).

        io_xml->add(
            iv_name = 'SMTG'
            ig_data = <lg_template> ).

      CATCH cx_root INTO lx_error.
        zcx_abapgit_exception=>raise(
            iv_text     = lx_error->get_text( )
            ix_previous = lx_error ).
    ENDTRY.

  ENDMETHOD.