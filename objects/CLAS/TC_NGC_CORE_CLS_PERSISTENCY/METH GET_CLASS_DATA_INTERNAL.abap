  METHOD get_class_data_internal.

    DATA(lt_class_status) = th_ngc_core_cls_pers_data=>get_class_statuses( ).

    LOOP AT it_class_with_keydate ASSIGNING FIELD-SYMBOL(<ls_class_with_keydate>).
      LOOP AT <ls_class_with_keydate>-classes ASSIGNING FIELD-SYMBOL(<ls_class>).
        APPEND VALUE #(
          classinternalid = <ls_class>-classinternalid
          key_date        = <ls_class_with_keydate>-keydate ) TO et_class_in.

        APPEND INITIAL LINE TO et_class_exp ASSIGNING FIELD-SYMBOL(<ls_class_exp>).
        MOVE-CORRESPONDING <ls_class> TO <ls_class_exp>.
        <ls_class_exp>-key_date = <ls_class_with_keydate>-keydate.

        DATA(ls_status) = VALUE #( lt_class_status[ classtype = <ls_class>-classtype classstatus = <ls_class>-classstatus ] OPTIONAL ).
        <ls_class_exp>-classificationisallowed = ls_status-classificationisallowed.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.