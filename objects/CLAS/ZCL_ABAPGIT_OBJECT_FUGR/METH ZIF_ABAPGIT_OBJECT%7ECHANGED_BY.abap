  METHOD zif_abapgit_object~changed_by.

    TYPES: BEGIN OF ty_stamps,
             user TYPE xubname,
             date TYPE d,
             time TYPE t,
           END OF ty_stamps.

    DATA: lt_stamps   TYPE STANDARD TABLE OF ty_stamps WITH DEFAULT KEY,
          lv_program  TYPE program,
          lt_includes TYPE ty_sobj_name_tt.

    FIELD-SYMBOLS: <ls_stamp>   LIKE LINE OF lt_stamps,
                   <lv_include> LIKE LINE OF lt_includes.


    lv_program = main_name( ).

    CALL FUNCTION 'RS_GET_ALL_INCLUDES'
      EXPORTING
        program      = lv_program
      TABLES
        includetab   = lt_includes
      EXCEPTIONS
        not_existent = 1
        no_program   = 2
        OTHERS       = 3.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'Error from RS_GET_ALL_INCLUDES' ).
    ENDIF.

    SELECT unam AS user udat AS date utime AS time FROM reposrc
      APPENDING CORRESPONDING FIELDS OF TABLE lt_stamps
      WHERE progname = lv_program
      AND   r3state = 'A'.                                "#EC CI_SUBRC

    LOOP AT lt_includes ASSIGNING <lv_include>.
      SELECT unam AS user udat AS date utime AS time FROM reposrc
        APPENDING CORRESPONDING FIELDS OF TABLE lt_stamps
        WHERE progname = <lv_include>
        AND   r3state = 'A'.                              "#EC CI_SUBRC
    ENDLOOP.

    SELECT unam AS user udat AS date utime AS time FROM repotext " Program text pool
      APPENDING CORRESPONDING FIELDS OF TABLE lt_stamps
      WHERE progname = lv_program
      AND   r3state = 'A'.                                "#EC CI_SUBRC

    SELECT vautor AS user vdatum AS date vzeit AS time FROM eudb         " GUI
      APPENDING CORRESPONDING FIELDS OF TABLE lt_stamps
      WHERE relid = 'CU'
      AND   name  = lv_program
      AND   srtf2 = 0 ##TOO_MANY_ITAB_FIELDS.

* Screens: username not stored in D020S database table

    SORT lt_stamps BY date DESCENDING time DESCENDING.

    READ TABLE lt_stamps INDEX 1 ASSIGNING <ls_stamp>.
    IF sy-subrc = 0.
      rv_user = <ls_stamp>-user.
    ELSE.
      rv_user = c_user_unknown.
    ENDIF.

  ENDMETHOD.