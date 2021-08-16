  METHOD zif_abapgit_object~serialize.

    DATA: ls_change_object TYPE ty_change_document,
          lt_tcdrp         TYPE STANDARD TABLE OF tcdrp,
          lt_tcdob         TYPE STANDARD TABLE OF tcdob,
          lt_tcdobt        TYPE STANDARD TABLE OF tcdobt,
          BEGIN OF ls_nulldatetime, " hack ro reset fields when they exist without syntax errors when they don't
            udate TYPE sy-datum,
            utime TYPE sy-uzeit,
          END OF ls_nulldatetime.

    FIELD-SYMBOLS: <ls_reports_generated> LIKE LINE OF ls_change_object-reports_generated,
                   <ls_objects>           LIKE LINE OF ls_change_object-objects,
                   <ls_objects_text>      LIKE LINE OF ls_change_object-objects_text.

    CALL FUNCTION 'CDNAMES_GET'
      EXPORTING
        iv_object        = mv_object
      TABLES
        it_tcdrp         = lt_tcdrp
        it_tcdob         = lt_tcdob
        it_tcdobt        = lt_tcdobt
      EXCEPTIONS
        object_space     = 1
        object_not_found = 2
        OTHERS           = 3.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

    ls_change_object-reports_generated = lt_tcdrp.
    ls_change_object-objects           = lt_tcdob.
    ls_change_object-objects_text      = lt_tcdobt.

    " At import, when CHDO is generated date & time change, so always detects changes for this fields
    LOOP AT ls_change_object-reports_generated ASSIGNING <ls_reports_generated>.
      CLEAR: <ls_reports_generated>-datum, <ls_reports_generated>-uzeit,
             <ls_reports_generated>-author, <ls_reports_generated>-updname,
             <ls_reports_generated>-devclass.
    ENDLOOP.

    LOOP AT ls_change_object-objects ASSIGNING <ls_objects>.
      MOVE-CORRESPONDING ls_nulldatetime TO <ls_objects>. " reset date and time
    ENDLOOP.

    LOOP AT ls_change_object-objects_text ASSIGNING <ls_objects_text>.
      MOVE-CORRESPONDING ls_nulldatetime TO <ls_objects_text>. " reset date and time
    ENDLOOP.

    io_xml->add( iv_name = 'CHDO'
                 ig_data = ls_change_object ).

  ENDMETHOD.