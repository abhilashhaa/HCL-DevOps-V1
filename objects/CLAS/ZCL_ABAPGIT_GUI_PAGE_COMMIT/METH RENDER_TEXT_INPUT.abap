  METHOD render_text_input.

    DATA lv_attrs TYPE string.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    IF iv_value IS NOT INITIAL AND
       iv_max_length IS NOT INITIAL.
      lv_attrs = | value="{ iv_value }" maxlength="{ iv_max_length }"|.
    ELSEIF iv_value IS NOT INITIAL.
      lv_attrs = | value="{ iv_value }"|.

    ELSEIF iv_max_length IS NOT INITIAL.
      lv_attrs = | maxlength="{ iv_max_length }"|.
    ENDIF.

    ri_html->add( '<div class="row">' ).
    ri_html->add( |<label for="{ iv_name }">{ iv_label }</label>| ).
    ri_html->add( |<input id="{ iv_name }" name="{ iv_name }" type="text"{ lv_attrs }>| ).
    ri_html->add( '</div>' ).

  ENDMETHOD.