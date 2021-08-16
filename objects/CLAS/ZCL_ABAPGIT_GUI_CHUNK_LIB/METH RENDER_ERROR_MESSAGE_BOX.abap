  METHOD render_error_message_box.

    DATA:
      lv_error_text   TYPE string,
      lv_longtext     TYPE string,
      lv_program_name TYPE sy-repid,
      lv_title        TYPE string,
      lv_text         TYPE string.


    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    lv_error_text = ix_error->get_text( ).
    lv_longtext = ix_error->if_message~get_longtext( abap_true ).

    REPLACE FIRST OCCURRENCE OF REGEX
      |({ zcl_abapgit_message_helper=>gc_section_text-cause }{ cl_abap_char_utilities=>newline })|
      IN lv_longtext WITH |<h3>$1</h3>|.

    REPLACE FIRST OCCURRENCE OF REGEX
      |({ zcl_abapgit_message_helper=>gc_section_text-system_response }{ cl_abap_char_utilities=>newline })|
      IN lv_longtext WITH |<h3>$1</h3>|.

    REPLACE FIRST OCCURRENCE OF REGEX
      |({ zcl_abapgit_message_helper=>gc_section_text-what_to_do }{ cl_abap_char_utilities=>newline })|
      IN lv_longtext WITH |<h3>$1</h3>|.

    REPLACE FIRST OCCURRENCE OF REGEX
      |({ zcl_abapgit_message_helper=>gc_section_text-sys_admin }{ cl_abap_char_utilities=>newline })|
      IN lv_longtext WITH |<h3>$1</h3>|.

    ri_html->add( |<div id="message" class="message-panel">| ).
    ri_html->add( |{ ri_html->icon( 'exclamation-circle/red' ) } { lv_error_text }| ).
    ri_html->add( |<div class="float-right">| ).

    ri_html->add_a(
        iv_txt   = `&#x274c;`
        iv_act   = `toggleDisplay('message')`
        iv_class = `close-btn`
        iv_typ   = zif_abapgit_html=>c_action_type-onclick ).

    ri_html->add( |</div>| ).

    ri_html->add( |<div class="float-right message-panel-commands">| ).

    IF ix_error->if_t100_message~t100key-msgid IS NOT INITIAL.

      lv_title = get_t100_text(
                    iv_msgid = ix_error->if_t100_message~t100key-msgid
                    iv_msgno = ix_error->if_t100_message~t100key-msgno ).

      lv_text = |Message ({ ix_error->if_t100_message~t100key-msgid }/{ ix_error->if_t100_message~t100key-msgno })|.

      ri_html->add_a(
          iv_txt   = lv_text
          iv_typ   = zif_abapgit_html=>c_action_type-sapevent
          iv_act   = zif_abapgit_definitions=>c_action-goto_message
          iv_title = lv_title
          iv_id    = `a_goto_message` ).

    ENDIF.

    ix_error->get_source_position( IMPORTING program_name = lv_program_name ).

    lv_title = normalize_program_name( lv_program_name ).

    ri_html->add_a(
        iv_txt   = `Goto source`
        iv_act   = zif_abapgit_definitions=>c_action-goto_source
        iv_typ   = zif_abapgit_html=>c_action_type-sapevent
        iv_title = lv_title
        iv_id    = `a_goto_source` ).

    ri_html->add_a(
        iv_txt = `Callstack`
        iv_act = zif_abapgit_definitions=>c_action-show_callstack
        iv_typ = zif_abapgit_html=>c_action_type-sapevent
        iv_id  = `a_callstack` ).

    ri_html->add( |</div>| ).
    ri_html->add( |<div class="message-panel-commands">| ).
    ri_html->add( |{ lv_longtext }| ).
    ri_html->add( |</div>| ).
    ri_html->add( |</div>| ).

  ENDMETHOD.