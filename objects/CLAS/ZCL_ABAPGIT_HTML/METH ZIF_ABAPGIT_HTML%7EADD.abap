  METHOD zif_abapgit_html~add.

    DATA: lv_type TYPE c,
          lo_html TYPE REF TO zcl_abapgit_html.

    FIELD-SYMBOLS: <lt_tab> TYPE string_table.

    DESCRIBE FIELD ig_chunk TYPE lv_type. " Describe is faster than RTTI classes

    CASE lv_type.
      WHEN 'C' OR 'g'.  " Char or string
        APPEND ig_chunk TO mt_buffer.
      WHEN 'h'.         " Table
        ASSIGN ig_chunk TO <lt_tab>. " Assuming table of strings ! Will dump otherwise
        APPEND LINES OF <lt_tab> TO mt_buffer.
      WHEN 'r'.         " Object ref
        ASSERT ig_chunk IS BOUND. " Dev mistake
        TRY.
            lo_html ?= ig_chunk.
          CATCH cx_sy_move_cast_error.
            ASSERT 1 = 0. " Dev mistake
        ENDTRY.
        APPEND LINES OF lo_html->mt_buffer TO mt_buffer.
      WHEN OTHERS.
        ASSERT 1 = 0. " Dev mistake
    ENDCASE.

  ENDMETHOD.