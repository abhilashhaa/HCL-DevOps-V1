  METHOD calculate_skip_testclass.

    DATA: lv_line1 LIKE LINE OF it_source,
          lv_line2 LIKE LINE OF it_source.

* when creating classes in Eclipse it automatically generates the
* testclass include, but it is not needed, so skip to avoid
* creating an extra file in the repository.
* Also remove it if the content is manually removed, but
* the class still thinks it contains tests

    rv_skip_testclass = abap_false.
    IF lines( it_source ) = 2.
      READ TABLE it_source INDEX 1 INTO lv_line1.
      ASSERT sy-subrc = 0.
      READ TABLE it_source INDEX 2 INTO lv_line2.
      ASSERT sy-subrc = 0.
      IF strlen( lv_line1 ) >= 3 AND lv_line1(3) = '*"*' AND lv_line2 IS INITIAL.
        rv_skip_testclass = abap_true.
      ENDIF.
    ELSEIF lines( it_source ) = 1.
      READ TABLE it_source INDEX 1 INTO lv_line1.
      ASSERT sy-subrc = 0.
      IF lv_line1 IS INITIAL
          OR ( strlen( lv_line1 ) >= 3 AND lv_line1(3) = '*"*' )
          OR ( strlen( lv_line1 ) = 1 AND lv_line1(1) = '*' ).
        rv_skip_testclass = abap_true.
      ENDIF.
    ELSEIF lines( it_source ) = 0.
      rv_skip_testclass = abap_true.
    ENDIF.

  ENDMETHOD.