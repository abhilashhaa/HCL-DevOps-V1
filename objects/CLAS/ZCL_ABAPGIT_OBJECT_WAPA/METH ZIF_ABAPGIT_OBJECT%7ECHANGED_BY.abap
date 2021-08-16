  METHOD zif_abapgit_object~changed_by.

    DATA: lv_name   TYPE o2applname,
          lt_pages  TYPE STANDARD TABLE OF o2pagdir WITH DEFAULT KEY,
          ls_latest LIKE LINE OF lt_pages.


    lv_name = ms_item-obj_name.

    SELECT * FROM o2pagdir INTO TABLE lt_pages WHERE applname = lv_name.
    IF sy-subrc <> 0.
      rv_user = c_user_unknown.
      RETURN.
    ENDIF.

    SORT lt_pages BY changedon DESCENDING changetime DESCENDING.

    READ TABLE lt_pages INDEX 1 INTO ls_latest.
    ASSERT sy-subrc = 0.

    rv_user = ls_latest-changedby.

  ENDMETHOD.