  METHOD zif_abapgit_object~delete.

    DATA: lv_bfset  TYPE sfw_bset,
          lt_delete TYPE sfw_bstab,
          lt_msgtab TYPE sprot_u_tab.


    lv_bfset = ms_item-obj_name.
    APPEND lv_bfset TO lt_delete.

    cl_sfw_activate=>delete_sfbs( EXPORTING p_bsets = lt_delete
                                  IMPORTING p_msgtab = lt_msgtab ).

    READ TABLE lt_msgtab WITH KEY severity = 'E' TRANSPORTING NO FIELDS.
    IF sy-subrc = 0.
      zcx_abapgit_exception=>raise( 'Error deleting SFBS' ).
    ENDIF.

  ENDMETHOD.