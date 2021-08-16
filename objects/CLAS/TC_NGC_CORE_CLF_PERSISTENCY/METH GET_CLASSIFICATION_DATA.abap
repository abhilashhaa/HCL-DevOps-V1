  METHOD get_classification_data.

    LOOP AT it_classification ASSIGNING FIELD-SYMBOL(<ls_clfn_with_kdate>).
      LOOP AT <ls_clfn_with_kdate>-classification ASSIGNING FIELD-SYMBOL(<ls_classification>).
        IF NOT line_exists( et_classification_key[
          object_key       = <ls_classification>-clfnobjectid
          technical_object = <ls_classification>-clfnobjecttable
          key_date         = <ls_clfn_with_kdate>-keydate ] ).
          APPEND VALUE #(
            object_key       = <ls_classification>-clfnobjectid
            technical_object = <ls_classification>-clfnobjecttable
            key_date         = <ls_clfn_with_kdate>-keydate ) TO et_classification_key.
        ENDIF.

        READ TABLE et_classification_exp
          ASSIGNING FIELD-SYMBOL(<ls_classification_exp>)
          WITH KEY
            object_key       = <ls_classification>-clfnobjectid
            technical_object = <ls_classification>-clfnobjecttable
            key_date         = <ls_clfn_with_kdate>-keydate.

        IF sy-subrc <> 0.
          APPEND VALUE #(
            object_key       = <ls_classification>-clfnobjectid
            technical_object = <ls_classification>-clfnobjecttable
            key_date         = <ls_clfn_with_kdate>-keydate ) TO et_classification_exp ASSIGNING <ls_classification_exp>.
        ENDIF.

        APPEND INITIAL LINE TO <ls_classification_exp>-classification_data ASSIGNING FIELD-SYMBOL(<ls_classification_data_exp>).
        MOVE-CORRESPONDING <ls_classification> TO <ls_classification_data_exp>.
      ENDLOOP.

      LOOP AT it_valuation ASSIGNING FIELD-SYMBOL(<ls_val_with_kdate>).
        LOOP AT <ls_val_with_kdate>-valuation ASSIGNING FIELD-SYMBOL(<ls_valuation>).
          READ TABLE et_classification_exp
            ASSIGNING <ls_classification_exp>
            WITH KEY
              object_key       = <ls_valuation>-clfnobjectid
              technical_object = <ls_valuation>-clfnobjecttable
              key_date         = <ls_val_with_kdate>-keydate.

          IF sy-subrc = 0.
            APPEND INITIAL LINE TO <ls_classification_exp>-valuation_data ASSIGNING FIELD-SYMBOL(<ls_valuation_data_exp>).
            MOVE-CORRESPONDING <ls_valuation> TO <ls_valuation_data_exp>.
          ENDIF.
        ENDLOOP.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.