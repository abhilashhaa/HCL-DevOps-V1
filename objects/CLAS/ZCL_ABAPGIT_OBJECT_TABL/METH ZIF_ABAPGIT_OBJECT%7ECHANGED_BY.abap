  METHOD zif_abapgit_object~changed_by.

    TYPES: BEGIN OF ty_data,
             as4user TYPE dd02l-as4user,
             as4date TYPE dd02l-as4date,
             as4time TYPE dd02l-as4time,
           END OF ty_data.

    DATA: lt_data TYPE STANDARD TABLE OF ty_data WITH DEFAULT KEY,
          ls_data LIKE LINE OF lt_data.


    SELECT as4user as4date as4time
      FROM dd02l INTO TABLE lt_data
      WHERE tabname = ms_item-obj_name
      AND as4local = 'A'
      AND as4vers = '0000'.

    SELECT as4user as4date as4time
      APPENDING TABLE lt_data
      FROM dd09l
      WHERE tabname = ms_item-obj_name
      AND as4local = 'A'
      AND as4vers = '0000'.

    SELECT as4user as4date as4time
      APPENDING TABLE lt_data
      FROM dd12l
      WHERE sqltab = ms_item-obj_name
      AND as4local = 'A'
      AND as4vers = '0000'.

    SORT lt_data BY as4date DESCENDING as4time DESCENDING.

    READ TABLE lt_data INDEX 1 INTO ls_data.
    IF sy-subrc = 0.
      rv_user = ls_data-as4user.
    ELSE.
      rv_user = c_user_unknown.
    ENDIF.

  ENDMETHOD.