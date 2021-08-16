  METHOD if_ngc_classification~set_reference_data.

    READ TABLE mt_reference_data ASSIGNING FIELD-SYMBOL(<ls_reference_table>)
      WITH KEY charcreferencetable = iv_charcreferencetable.
    IF sy-subrc = 0.
      <ls_reference_table>-data = ir_data.
    ELSE.
      APPEND VALUE #( charcreferencetable = iv_charcreferencetable
                      data                = ir_data ) TO mt_reference_data.
    ENDIF.

    setup_classtypes_node_leaf( ).

    me->if_ngc_classification~get_assigned_classes(
      IMPORTING
        et_assigned_class = DATA(lt_assigned_class) ).

    LOOP AT lt_assigned_class ASSIGNING FIELD-SYMBOL(<ls_class>).
      me->set_reference_charc_valuation( <ls_class> ).
    ENDLOOP.

  ENDMETHOD.