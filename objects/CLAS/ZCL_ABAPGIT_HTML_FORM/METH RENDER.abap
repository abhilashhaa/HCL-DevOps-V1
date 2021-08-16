  METHOD render.

    FIELD-SYMBOLS <ls_field> LIKE LINE OF mt_fields.
    FIELD-SYMBOLS <ls_cmd> LIKE LINE OF mt_commands.
    DATA ls_form_id TYPE string.
    DATA lv_cur_group TYPE string.

    IF mv_form_id IS NOT INITIAL.
      ls_form_id = | id="{ mv_form_id }"|.
    ENDIF.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( |<div class="{ iv_form_class }">| ).
    ri_html->add( |<form method="post"{ ls_form_id }>| ).
    ri_html->add( |<ul>| ).

    LOOP AT mt_fields ASSIGNING <ls_field>.

      IF <ls_field>-type = c_field_type-field_group.
        IF lv_cur_group IS NOT INITIAL AND lv_cur_group <> <ls_field>-name.
          ri_html->add( '</fieldset>' ).
        ENDIF.
        lv_cur_group = <ls_field>-name.
        ri_html->add( |<fieldset name="{ <ls_field>-name }">| ).
        ri_html->add( |<legend{ <ls_field>-hint }>{ <ls_field>-label }</legend>| ).
        CONTINUE.
      ENDIF.

      render_field(
        ii_html           = ri_html
        io_values         = io_values
        io_validation_log = io_validation_log
        is_field          = <ls_field> ).

      AT LAST.
        IF lv_cur_group IS NOT INITIAL.
          ri_html->add( '</fieldset>' ).
        ENDIF.
      ENDAT.
    ENDLOOP.

    ri_html->add( |<li class="dialog-commands">| ).

    LOOP AT mt_commands ASSIGNING <ls_cmd>.
      render_command(
        ii_html = ri_html
        is_cmd  = <ls_cmd> ).
    ENDLOOP.

    ri_html->add( |</li>| ).

    ri_html->add( |</ul>| ).
    ri_html->add( |</form>| ).
    ri_html->add( |</div>| ).

  ENDMETHOD.