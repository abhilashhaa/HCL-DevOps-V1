  METHOD get_ancestor_idx.

    CLEAR: ev_parent_idx, ev_root_idx, ev_different_changenumber.


    IF iv_changenumber IS SUPPLIED.
      IF line_exists( mt_charc_create_data[ charc-cid = iv_cid_ref changenumber = iv_changenumber ] ).
        ev_root_idx   = line_index( mt_charc_create_data[ charc-cid = iv_cid_ref changenumber = iv_changenumber ] ).
        ev_parent_idx = ev_root_idx.
      ENDIF.
    ELSE.
      IF line_exists( mt_charc_create_data[ charc-cid = iv_cid_ref ] ).
        ev_root_idx   = line_index( mt_charc_create_data[ charc-cid = iv_cid_ref ] ).
        ev_parent_idx = ev_root_idx.
      ENDIF.
    ENDIF.

    " Check for charc value in case of charc value desc
    IF ev_root_idx IS INITIAL.
      LOOP AT mt_charc_create_data ASSIGNING FIELD-SYMBOL(<ls_charc_create_data>)
        WHERE changenumber = iv_changenumber.
        DATA(lv_index) = sy-tabix.
        DATA(ls_value) = VALUE #( <ls_charc_create_data>-charcval[ cid = iv_cid_ref ] OPTIONAL ).

        IF ls_value IS NOT INITIAL.
          ev_root_idx   = lv_index.
          ev_parent_idx = line_index( <ls_charc_create_data>-charcval[ cid = iv_cid_ref ] ).

          EXIT.
        ENDIF.
      ENDLOOP.

      IF ev_root_idx IS INITIAL.
        " Partial deep insert (only for charc value)
        LOOP AT mt_charc_change_data ASSIGNING <ls_charc_create_data>
          WHERE changenumber = iv_changenumber.
          ls_value = VALUE #( <ls_charc_create_data>-charcval[ cid = iv_cid_ref ] OPTIONAL ).

          IF ls_value IS NOT INITIAL.
            ev_parent_idx = line_index( <ls_charc_create_data>-charcval[ cid = iv_cid_ref ] ).

            EXIT.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDIF.

  ENDMETHOD.