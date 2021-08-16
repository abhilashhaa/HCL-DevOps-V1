  METHOD render_field.

    DATA lv_opt_id TYPE string.
    DATA lv_error TYPE string.
    DATA lv_value TYPE string.
    DATA lv_checked TYPE string.
    DATA lv_item_class TYPE string.
    FIELD-SYMBOLS <ls_opt> LIKE LINE OF is_field-subitems.

    " Get value and validation error from maps
    lv_value = io_values->get( is_field-name ).
    IF io_validation_log IS BOUND.
      lv_error = io_validation_log->get( is_field-name ).
    ENDIF.

    " Prepare item class
    lv_item_class = is_field-item_class.
    IF lv_error IS NOT INITIAL.
      lv_item_class = condense( lv_item_class && ' error' ).
    ENDIF.
    IF lv_item_class IS NOT INITIAL.
      lv_item_class = | class="{ lv_item_class }"|.
    ENDIF.

    " Render field
    ii_html->add( |<li{ lv_item_class }>| ).

    CASE is_field-type.
      WHEN c_field_type-text.

        ii_html->add( |<label for="{ is_field-name }"{ is_field-hint }>{
          is_field-label }{ is_field-required }</label>| ).
        IF lv_error IS NOT INITIAL.
          ii_html->add( |<small>{ lv_error }</small>| ).
        ENDIF.

        IF is_field-side_action IS NOT INITIAL.
          ii_html->add( '<div class="input-container">' ). " Ugly :(
        ENDIF.

        ii_html->add( |<input type="text" name="{ is_field-name }" id="{
          is_field-name }"{ is_field-placeholder } value="{ lv_value }"{ is_field-dblclick }>| ).

        IF is_field-side_action IS NOT INITIAL.
          ii_html->add( '</div>' ).
          ii_html->add( '<div class="command-container">' ).
          ii_html->add( |<input type="submit" value="&#x2026;" formaction="sapevent:{ is_field-side_action }">| ).
          ii_html->add( '</div>' ).
        ENDIF.

      WHEN c_field_type-checkbox.

        IF lv_error IS NOT INITIAL.
          ii_html->add( |<small>{ lv_error }</small>| ).
        ENDIF.
        IF lv_value IS NOT INITIAL.
          lv_checked = ' checked'.
        ENDIF.
        ii_html->add( |<input type="checkbox" name="{ is_field-name }" id="{ is_field-name }"{ lv_checked }>| ).
        ii_html->add( |<label for="{ is_field-name }"{ is_field-hint }>{
          is_field-label }{ is_field-required }</label>| ).

      WHEN c_field_type-radio.

        ii_html->add( |<label{ is_field-hint }>{ is_field-label }{ is_field-required }</label>| ).
        IF lv_error IS NOT INITIAL.
          ii_html->add( |<small>{ lv_error }</small>| ).
        ENDIF.
        ii_html->add( |<div class="radio-container">| ).

        LOOP AT is_field-subitems ASSIGNING <ls_opt>.
          CLEAR lv_checked.
          IF lv_value = <ls_opt>-value OR ( lv_value IS INITIAL AND <ls_opt>-value = is_field-default_value ).
            lv_checked = ' checked'.
          ENDIF.
          lv_opt_id = |{ is_field-name }{ sy-tabix }|.
          ii_html->add( |<input type="radio" name="{ is_field-name }" id="{
            lv_opt_id }" value="{ <ls_opt>-value }"{ lv_checked }>| ).
          ii_html->add( |<label for="{ lv_opt_id }">{ <ls_opt>-label }</label>| ).
        ENDLOOP.

        ii_html->add( '</div>' ).

      WHEN OTHERS.
        ASSERT 1 = 0.
    ENDCASE.

    ii_html->add( '</li>' ).

  ENDMETHOD.