  METHOD get_comment_file.

    DATA: lv_count TYPE i,
          lv_value TYPE c LENGTH 10.

    FIELD-SYMBOLS: <ls_stage> LIKE LINE OF it_stage.

    lv_count = lines( it_stage ).

    IF lv_count = 1.
      " Just one file so we use the file name
      READ TABLE it_stage ASSIGNING <ls_stage> INDEX 1.
      ASSERT sy-subrc = 0.

      rv_text = <ls_stage>-file-filename.
    ELSE.
      " For multiple file we use the count instead
      WRITE lv_count TO lv_value LEFT-JUSTIFIED.
      CONCATENATE lv_value 'files' INTO rv_text SEPARATED BY space.
    ENDIF.

  ENDMETHOD.