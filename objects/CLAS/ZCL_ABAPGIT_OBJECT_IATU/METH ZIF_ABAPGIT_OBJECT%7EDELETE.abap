  METHOD zif_abapgit_object~delete.

    DATA: li_template TYPE REF TO if_w3_api_template,
          ls_name     TYPE iacikeyt.


    ls_name = ms_item-obj_name.

    li_template = w3_api_load( is_name = ls_name ).

    w3_api_set_changeable( ii_template   = li_template
                           iv_changeable = abap_true ).

    w3_api_delete( ii_template = li_template ).

    w3_api_save( ii_template = li_template ).

  ENDMETHOD.