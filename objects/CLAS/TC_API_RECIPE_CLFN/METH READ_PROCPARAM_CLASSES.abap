  METHOD read_procparam_classes.

    DATA:
      lv_recipeuuid   TYPE string,
      lv_recipeuuid_2 TYPE string.


    DATA(lv_body) = me->geturl(
      iv_uri         = 'A_RecProcParamValClass?$top=10'
      iv_status_code = 200 ).

    me->get_property_from_xml(
      EXPORTING
        iv_property_name = 'RecipeProcessParamValUUID'
        iv_xml           = lv_body
      IMPORTING
        ev_value         = lv_recipeuuid ).

    CHECK lv_recipeuuid IS NOT INITIAL.

    me->geturl(
      iv_uri         = |A_RecProcParamValClass?$filter=RecipeProcessParamValUUID eq guid'{ lv_recipeuuid }'|
      iv_status_code = 200 ).

    me->get_property_from_xml(
      EXPORTING
        iv_property_name = 'RecipeProcessParamValUUID'
        iv_xml           = lv_body
      IMPORTING
        ev_value         = lv_recipeuuid_2 ).

    cl_abap_unit_assert=>assert_equals(
      act = lv_recipeuuid
      exp = lv_recipeuuid_2 ).

  ENDMETHOD.