  METHOD zif_abapgit_object~serialize.

    DATA:
      lo_personalization_object TYPE REF TO cl_pers_reg,
      ls_personalization_object TYPE ty_personalization_object.

    lo_personalization_object = get_personalization_object( iv_view_only = abap_true ).

    lo_personalization_object->get_reg_data(
      IMPORTING
        p_pers_reg      = ls_personalization_object-pers_reg
        p_pers_reg_text = ls_personalization_object-pers_reg_text ).

    CLEAR:
      ls_personalization_object-pers_reg-author,
      ls_personalization_object-pers_reg-fdate,
      ls_personalization_object-pers_reg-ftime.

    io_xml->add( iv_name = 'PERS'
                 ig_data = ls_personalization_object ).

  ENDMETHOD.