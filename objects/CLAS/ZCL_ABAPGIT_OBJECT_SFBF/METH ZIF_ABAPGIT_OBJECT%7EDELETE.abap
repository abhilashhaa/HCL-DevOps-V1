  METHOD zif_abapgit_object~delete.

    DATA: lv_bf     TYPE sfw_bfunction,
          lt_delete TYPE sfw_bftab,
          lt_msgtab TYPE sprot_u_tab.


    lv_bf = ms_item-obj_name.
    APPEND lv_bf TO lt_delete.

    cl_sfw_activate=>delete_sfbf( EXPORTING p_bfuncts = lt_delete
                                  IMPORTING p_msgtab = lt_msgtab ).

    READ TABLE lt_msgtab WITH KEY severity = 'E' TRANSPORTING NO FIELDS.
    IF sy-subrc = 0.
      zcx_abapgit_exception=>raise( 'Error deleting SFBF' ).
    ENDIF.

  ENDMETHOD.