  METHOD save_dot_abap.

    DATA: lo_dot          TYPE REF TO zcl_abapgit_dot_abapgit,
          ls_post_field   LIKE LINE OF it_post_fields,
          lv_ignore       TYPE string,
          lt_ignore       TYPE STANDARD TABLE OF string WITH DEFAULT KEY,
          lo_requirements TYPE REF TO lcl_requirements.

    lo_dot = mo_repo->get_dot_abapgit( ).

    READ TABLE it_post_fields INTO ls_post_field WITH KEY name = 'folder_logic'.
    ASSERT sy-subrc = 0.
    lo_dot->set_folder_logic( ls_post_field-value ).

    READ TABLE it_post_fields INTO ls_post_field WITH KEY name = 'starting_folder'.
    ASSERT sy-subrc = 0.
    lo_dot->set_starting_folder( ls_post_field-value ).

    READ TABLE it_post_fields INTO ls_post_field WITH KEY name = 'ignore_files'.
    ASSERT sy-subrc = 0.

    " Remove everything
    lt_ignore = lo_dot->get_data( )-ignore.
    LOOP AT lt_ignore INTO lv_ignore.
      lo_dot->remove_ignore( iv_path = ''
                             iv_filename = lv_ignore ).
    ENDLOOP.

    " Add newly entered files
    CLEAR lt_ignore.
    REPLACE ALL OCCURRENCES OF zif_abapgit_definitions=>c_crlf IN ls_post_field-value
      WITH zif_abapgit_definitions=>c_newline.
    SPLIT ls_post_field-value AT zif_abapgit_definitions=>c_newline INTO TABLE lt_ignore.
    DELETE lt_ignore WHERE table_line IS INITIAL.
    LOOP AT lt_ignore INTO lv_ignore.
      lo_dot->add_ignore( iv_path = ''
                          iv_filename = lv_ignore ).
    ENDLOOP.

    lo_requirements = lcl_requirements=>new( ).
    LOOP AT it_post_fields INTO ls_post_field WHERE name CP 'req_*'.
      CASE ls_post_field-name+4(3).
        WHEN 'com'.
          lo_requirements->set_component( ls_post_field-value ).
        WHEN 'rel'.
          lo_requirements->set_min_release( ls_post_field-value ).
        WHEN 'pat'.
          lo_requirements->set_min_patch( ls_post_field-value ).
      ENDCASE.
    ENDLOOP.

    lo_dot->set_requirements( lo_requirements->get_as_table( ) ).

    mo_repo->set_dot_abapgit( lo_dot ).

  ENDMETHOD.