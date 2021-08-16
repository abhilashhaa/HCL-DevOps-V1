  METHOD zif_abapgit_object~serialize.

    DATA: ls_char TYPE ty_char.

    CONSTANTS: lc_active TYPE c LENGTH 1 VALUE 'A'.


    SELECT SINGLE * FROM cls_attribute INTO ls_char-cls_attribute
      WHERE name = ms_item-obj_name
      AND activation_state = lc_active.
* todo, ASSIGNMENT_DEVC?

    CLEAR: ls_char-cls_attribute-created_by,
           ls_char-cls_attribute-created_on,
           ls_char-cls_attribute-changed_by,
           ls_char-cls_attribute-changed_on.

    SELECT * FROM cls_attributet INTO TABLE ls_char-cls_attributet
      WHERE name = ms_item-obj_name
      AND activation_state = lc_active.

    SELECT * FROM cls_attr_value INTO TABLE ls_char-cls_attr_value
      WHERE name = ms_item-obj_name
      AND activation_state = lc_active.

    SELECT * FROM cls_attr_valuet INTO TABLE ls_char-cls_attr_valuet
      WHERE name = ms_item-obj_name
      AND activation_state = lc_active.

    io_xml->add( iv_name = 'CHAR'
                 ig_data = ls_char ).

  ENDMETHOD.