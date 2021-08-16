CLASS lth_test_data DEFINITION
  FINAL
  FOR TESTING.

  PUBLIC SECTION.

    TYPES:
      BEGIN OF lts_domain_value,
        charc_value TYPE atwrt,
        num_from    TYPE atflv,
        num_to      TYPE atflb,
        interval    TYPE atcod,
      END OF lts_domain_value,
      ltt_domain_value TYPE STANDARD TABLE OF lts_domain_value WITH DEFAULT KEY.

    TYPES:
      BEGIN OF lts_characteristic,
        name              TYPE atnam,
        data_type         TYPE atfor,
        length            TYPE anzst,
        decimals          TYPE anzdz,
        single_value      TYPE atein,
        additional_values TYPE atson,
        intervals_allowed TYPE atint,
        reference_table   TYPE attab,
        reference_field   TYPE atfel,
        values            TYPE ltt_domain_value,
      END OF lts_characteristic,
      ltt_characteristic TYPE STANDARD TABLE OF lts_characteristic WITH DEFAULT KEY.

    TYPES:
      BEGIN OF lts_value_restriction,
        characteristic TYPE atnam,
        charcvalue     TYPE atwrt,
      END OF lts_value_restriction,
      ltt_value_restriction TYPE STANDARD TABLE OF lts_value_restriction WITH DEFAULT KEY.

    TYPES:
      BEGIN OF lts_class,
        name              TYPE klasse_d,
        class_type        TYPE klassenart,
        parent            TYPE klasse_d,
        value_restriction TYPE ltt_value_restriction,
        charc_names       TYPE STANDARD TABLE OF atnam WITH DEFAULT KEY,
      END OF lts_class,
      ltt_class TYPE STANDARD TABLE OF lts_class WITH DEFAULT KEY.

    TYPES:
      BEGIN OF lts_classification,
        object_name TYPE cuobn,
        class_name  TYPE klasse_d,
        class_type  TYPE klassenart,
      END OF lts_classification,
      ltt_classification TYPE STANDARD TABLE OF lts_classification WITH DEFAULT KEY.

    TYPES:
      BEGIN OF lts_valuation,
        object_name TYPE cuobn,
        class_type  TYPE klassenart,
        charc_name  TYPE atnam,
        values      TYPE STANDARD TABLE OF atwrt WITH DEFAULT KEY,
      END OF lts_valuation,
      ltt_valuation TYPE STANDARD TABLE OF lts_valuation WITH DEFAULT KEY.

    TYPES:
      BEGIN OF lts_material,
        name TYPE cuobn,
      END OF lts_material,
      ltt_material TYPE STANDARD TABLE OF lts_material WITH DEFAULT KEY.

    CONSTANTS:
      cv_class_type_001        TYPE klassenart VALUE '001',
      cv_class_type_300        TYPE klassenart VALUE '300',
      cv_class_complete_name   TYPE klasse_d VALUE 'EML_INT_COMPLETE',
      cv_class_ref_char_name   TYPE klasse_d VALUE 'EML_INT_REF_CHAR',
      cv_class_empty_name      TYPE klasse_d VALUE 'EML_INT_EMPTY',
      cv_class_empty_2_name    TYPE klasse_d VALUE 'EML_INT_EMPTY_2',
      cv_class_child_name      TYPE klasse_d VALUE 'EML_INT_CHILD',
      cv_class_parent_name     TYPE klasse_d VALUE 'EML_INT_PARENT',
      cv_charc_char_multi_name TYPE atnam VALUE 'EML_INT_CHAR_MULTI',
      cv_charc_num_name        TYPE atnam VALUE 'EML_INT_NUM',
      cv_charc_char_ref_name   TYPE atnam VALUE 'EML_INT_CHAR_REF',
      cv_charc_date_name       TYPE atnam VALUE 'EML_INT_DATE',
      cv_charc_time_name       TYPE atnam VALUE 'EML_INT_TIME',
      cv_char_value_01         TYPE atwrt VALUE 'VALUE_01',
      cv_char_value_02         TYPE atwrt VALUE 'VALUE_02',
      cv_char_value_03         TYPE atwrt VALUE 'VALUE_03',
      cv_num_value_100         TYPE atflv VALUE 100,
      cv_num_value_200         TYPE atflv VALUE 200,
      cv_num_value_100_char    TYPE atwrt VALUE '100',
      cv_num_value_200_char    TYPE atwrt VALUE '200',
      cv_num_value_300_char    TYPE atwrt VALUE '300',
      cv_object_name_01        TYPE cuobn VALUE 'EML_INT_01',
      cv_object_name_02        TYPE cuobn VALUE 'EML_INT_02',
      cv_object_name_empty     TYPE cuobn VALUE 'EML_INT_EMPTY'.

    CLASS-DATA:
      gt_characteristic TYPE ltt_characteristic,
      gt_class          TYPE ltt_class,
      gt_classification TYPE ltt_classification,
      gt_valuation      TYPE ltt_valuation,
      gt_material       TYPE ltt_material.

    CLASS-METHODS:
      class_constructor.

ENDCLASS.

CLASS lth_test_data IMPLEMENTATION.

  METHOD class_constructor.

    gt_characteristic = VALUE #(
      ( name              = cv_charc_char_multi_name
        data_type         = if_ngc_c=>gc_charcdatatype-char
        length            = 20
        values            = VALUE #(
          ( charc_value = cv_char_value_01 )
          ( charc_value = cv_char_value_02 )
          ( charc_value = cv_char_value_03 ) ) )
      ( name              = cv_charc_num_name
        data_type         = if_ngc_c=>gc_charcdatatype-num
        length            = 5
        decimals          = 2
        single_value      = abap_true
        additional_values = abap_true
        intervals_allowed = abap_true
        values            = VALUE #(
          ( num_from = cv_num_value_100 interval = 1 )
          ( num_from = cv_num_value_200 interval = 1 ) ) )
      ( name              = cv_charc_char_ref_name
        data_type         = if_ngc_c=>gc_charcdatatype-char
        length            = 40
        reference_table   = 'MARA'
        reference_field   = 'MATNR' )
      ( name              = cv_charc_date_name
        data_type         = if_ngc_c=>gc_charcdatatype-date
        length            = 8 )
      ( name              = cv_charc_time_name
        data_type         = if_ngc_c=>gc_charcdatatype-time
        length            = 6 ) ).

    gt_class = VALUE #(
      " Class type 001 - master data (readonly)
      ( name              = cv_class_complete_name
        class_type        = cv_class_type_001
        charc_names       = VALUE #(
          ( cv_charc_char_multi_name )
          ( cv_charc_num_name ) ) )
      ( name              = cv_class_empty_name
        class_type        = cv_class_type_001 )

      " Class type 300 - data for changes
      ( name              = cv_class_complete_name
        class_type        = cv_class_type_300
        charc_names       = VALUE #(
          ( cv_charc_char_multi_name )
          ( cv_charc_num_name )
          ( cv_charc_date_name )
          ( cv_charc_time_name ) ) )
      ( name              = cv_class_ref_char_name
        class_type        = cv_class_type_300
        charc_names       = VALUE #(
          ( cv_charc_char_ref_name ) ) )
      ( name              = cv_class_empty_name
        class_type        = cv_class_type_300 )
      ( name              = cv_class_empty_2_name
        class_type        = cv_class_type_300 ) ).

    gt_classification = VALUE #(
      ( object_name = cv_object_name_01
        class_name  = cv_class_complete_name
        class_type  = cv_class_type_001 )
      ( object_name = cv_object_name_01
        class_name  = cv_class_empty_name
        class_type  = cv_class_type_001 )
      ( object_name = cv_object_name_01
        class_name  = cv_class_complete_name
        class_type  = cv_class_type_300 )
      ( object_name = cv_object_name_01
        class_name  = cv_class_ref_char_name
        class_type  = cv_class_type_300 )

      ( object_name = cv_object_name_02
        class_name  = cv_class_complete_name
        class_type  = cv_class_type_001 )
      ( object_name = cv_object_name_02
        class_name  = cv_class_empty_name
        class_type  = cv_class_type_001 ) ).

    gt_valuation = VALUE #(
      ( object_name = cv_object_name_01
        class_type  = cv_class_type_001
        charc_name  = cv_charc_char_multi_name
        values      = VALUE #(
          ( cv_char_value_01 )
          ( cv_char_value_02 ) ) )
      ( object_name = cv_object_name_01
        class_type  = cv_class_type_001
        charc_name  = cv_charc_num_name
        values      = VALUE #(
          ( cv_num_value_100_char ) ) )

      ( object_name = cv_object_name_02
        class_type  = cv_class_type_001
        charc_name  = cv_charc_char_multi_name
        values      = VALUE #(
          ( cv_char_value_01 )
          ( cv_char_value_02 ) ) ) ).

    gt_material = VALUE #(
      ( name = cv_object_name_01 )
      ( name = cv_object_name_02 ) ).

  ENDMETHOD.

ENDCLASS.

CLASS lth_characteristic_handler DEFINITION
  FINAL
  FOR TESTING.

  PUBLIC SECTION.

    CLASS-METHODS:
      create_characteristic,
      delete_characteristic.

ENDCLASS.

CLASS lth_characteristic_handler IMPLEMENTATION.

  METHOD create_characteristic.

    DATA:
      lt_description TYPE STANDARD TABLE OF bapicharactdescr,
      lt_char_value  TYPE STANDARD TABLE OF bapicharactvalueschar,
      lt_num_value   TYPE STANDARD TABLE OF bapicharactvaluesnum,
      lt_reference   TYPE STANDARD TABLE OF bapicharactreferences,
      lt_return      TYPE STANDARD TABLE OF bapiret2.


    lt_description = VALUE #( ( description = 'Generated by NGC integration test' language_int = sy-langu ) ).

    LOOP AT lth_test_data=>gt_characteristic ASSIGNING FIELD-SYMBOL(<ls_characteristic>).
      CLEAR: lt_char_value, lt_num_value, lt_reference, lt_return.

      DATA(ls_charc_detail) = VALUE bapicharactdetail(
        charact_name      = <ls_characteristic>-name
        status            = '1'
        data_type         = <ls_characteristic>-data_type
        length            = <ls_characteristic>-length
        decimals          = <ls_characteristic>-decimals
        additional_values = <ls_characteristic>-additional_values
        interval_allowed  = <ls_characteristic>-intervals_allowed
        value_assignment  = COND #( WHEN <ls_characteristic>-single_value = abap_true THEN 'S' ELSE 'M' ) ).

      IF <ls_characteristic>-reference_table IS NOT INITIAL.
        APPEND VALUE #(
          reference_table = <ls_characteristic>-reference_table
          reference_field = <ls_characteristic>-reference_field ) TO lt_reference.
      ENDIF.

      LOOP AT <ls_characteristic>-values ASSIGNING FIELD-SYMBOL(<ls_value>).
        CASE <ls_characteristic>-data_type.
          WHEN 'CHAR'.
            APPEND VALUE #( value_char = <ls_value>-charc_value ) TO lt_char_value.

          WHEN 'NUM'.
            APPEND VALUE #( value_from = <ls_value>-num_from value_to = <ls_value>-num_to value_relation = <ls_value>-interval ) TO lt_num_value.

          WHEN OTHERS.
            cl_abap_unit_assert=>fail(
              msg = |Correct data type should be selected| ).
        ENDCASE.
      ENDLOOP.

      CALL FUNCTION 'BAPI_CHARACT_CREATE'
        EXPORTING
          charactdetail     = ls_charc_detail
        TABLES
          charactdescr      = lt_description
          charactvalueschar = lt_char_value
          charactvaluesnum  = lt_num_value
          charactreferences = lt_reference
          return            = lt_return.

      LOOP AT lt_return ASSIGNING FIELD-SYMBOL(<ls_return>)
        WHERE
          type CA 'EAX'.
        cl_abap_unit_assert=>fail(
          level = if_aunit_constants=>severity-low
          quit  = if_aunit_constants=>quit-no
          msg   = |Characteristic create error should not be returned: { <ls_characteristic>-name }| ).
      ENDLOOP.
    ENDLOOP.

    COMMIT WORK AND WAIT.

    cl_abap_unit_assert=>assert_subrc(
      act   = sy-subrc
      level = if_aunit_constants=>severity-low
      quit  = if_aunit_constants=>quit-no
      msg   = |No error expected in update task| ).

  ENDMETHOD.

  METHOD delete_characteristic.

    DATA:
      lt_return TYPE STANDARD TABLE OF bapiret2.


    LOOP AT lth_test_data=>gt_characteristic ASSIGNING FIELD-SYMBOL(<ls_characteristic>).
      CLEAR: lt_return.

      DATA(lv_charc_name) = <ls_characteristic>-name.

      CALL FUNCTION 'BAPI_CHARACT_DELETE'
        EXPORTING
          charactname = lv_charc_name
        TABLES
          return      = lt_return.

      LOOP AT lt_return ASSIGNING FIELD-SYMBOL(<ls_return>)
        WHERE
          type CA 'EAX'.
        cl_abap_unit_assert=>fail(
          level = if_aunit_constants=>severity-low
          quit  = if_aunit_constants=>quit-no
          msg   = |Characteristic delete error should not be returned: { <ls_characteristic>-name }| ).
      ENDLOOP.
    ENDLOOP.

    COMMIT WORK AND WAIT.

    cl_abap_unit_assert=>assert_subrc(
      act   = sy-subrc
      level = if_aunit_constants=>severity-low
      quit  = if_aunit_constants=>quit-no
      msg   = |No error expected in update task| ).

  ENDMETHOD.

ENDCLASS.

CLASS lth_class_data_handler DEFINITION
  FINAL
  FOR TESTING.

  PUBLIC SECTION.

    CLASS-METHODS:
      create_classes,
      remove_classes.

ENDCLASS.

CLASS lth_class_data_handler IMPLEMENTATION.

  METHOD create_classes.

    DATA:
      ls_basic_data        TYPE bapi1003_basic,
      lt_description       TYPE STANDARD TABLE OF bapi1003_catch,
      lt_characteristic    TYPE STANDARD TABLE OF bapi1003_charact,
      lt_value_restriction TYPE STANDARD TABLE OF bapi1003_alloc_values,
      lt_return            TYPE STANDARD TABLE OF bapiret2.


    ls_basic_data  = VALUE #( status = 1 ).
    lt_description = VALUE #( ( catchword = 'Generated by NGC integration test' langu = sy-langu ) ).

    LOOP AT lth_test_data=>gt_class ASSIGNING FIELD-SYMBOL(<ls_class>).
      CLEAR: lt_characteristic, lt_return.

      LOOP AT <ls_class>-charc_names ASSIGNING FIELD-SYMBOL(<lv_charc_name>).
        APPEND <lv_charc_name> TO lt_characteristic.
      ENDLOOP.

      CALL FUNCTION 'BAPI_CLASS_CREATE'
        EXPORTING
          classnumnew          = <ls_class>-name
          classtypenew         = <ls_class>-class_type
          classbasicdata       = ls_basic_data
        TABLES
          classdescriptions    = lt_description
          classcharacteristics = lt_characteristic
          return               = lt_return.

      LOOP AT lt_return ASSIGNING FIELD-SYMBOL(<ls_return>)
        WHERE
          type CA 'EAX'.
        cl_abap_unit_assert=>fail(
          level = if_aunit_constants=>severity-low
          quit  = if_aunit_constants=>quit-no
          msg   = |Class create error should not be returned: { <ls_class>-name }| ).
      ENDLOOP.
    ENDLOOP.

    COMMIT WORK AND WAIT.

    cl_abap_unit_assert=>assert_subrc(
      act   = sy-subrc
      level = if_aunit_constants=>severity-low
      quit  = if_aunit_constants=>quit-no
      msg   = |No error expected in update task| ).

    LOOP AT lth_test_data=>gt_class ASSIGNING <ls_class>
      WHERE
        parent IS NOT INITIAL.
      CLEAR: lt_characteristic, lt_value_restriction, lt_return.

      LOOP AT <ls_class>-value_restriction ASSIGNING FIELD-SYMBOL(<ls_value_restriction>).
        APPEND VALUE #(
          charact    = <ls_value_restriction>-characteristic
          value_char = <ls_value_restriction>-charcvalue
          inherited  = abap_true ) TO lt_value_restriction.
      ENDLOOP.

      CALL FUNCTION 'BAPI_HIERA_ADDSUBCLASS'
        EXPORTING
          classnum        = <ls_class>-parent
          subclass        = <ls_class>-name
          classtype       = <ls_class>-class_type
        TABLES
          hierarchyvalues = lt_value_restriction
          return          = lt_return.

      LOOP AT lt_return ASSIGNING <ls_return>
        WHERE
          type CA 'EAX'.
        cl_abap_unit_assert=>fail(
          level = if_aunit_constants=>severity-low
          quit  = if_aunit_constants=>quit-no
          msg   = |Class create error should not be returned: { <ls_class>-name }| ).
      ENDLOOP.
    ENDLOOP.

    COMMIT WORK AND WAIT.

    cl_abap_unit_assert=>assert_subrc(
      act   = sy-subrc
      level = if_aunit_constants=>severity-low
      quit  = if_aunit_constants=>quit-no
      msg   = |No error expected in update task| ).

  ENDMETHOD.

  METHOD remove_classes.

    DATA:
      lt_return TYPE STANDARD TABLE OF bapiret2.


    " Delete children first
    LOOP AT lth_test_data=>gt_class ASSIGNING FIELD-SYMBOL(<ls_class>)
      WHERE
        parent IS NOT INITIAL.
      CLEAR: lt_return.

      CALL FUNCTION 'BAPI_CLASS_DELETE'
        EXPORTING
          classnum  = <ls_class>-name
          classtype = <ls_class>-class_type
        TABLES
          return    = lt_return.

      LOOP AT lt_return ASSIGNING FIELD-SYMBOL(<ls_return>)
        WHERE
          type CA 'EAX'.
        cl_abap_unit_assert=>fail(
          level = if_aunit_constants=>severity-low
          quit  = if_aunit_constants=>quit-no
          msg   = |Class delete error should not be returned: { <ls_class>-name }| ).
      ENDLOOP.
    ENDLOOP.

    COMMIT WORK AND WAIT.

    cl_abap_unit_assert=>assert_subrc(
      act   = sy-subrc
      level = if_aunit_constants=>severity-low
      quit  = if_aunit_constants=>quit-no
      msg   = |No error expected in update task| ).

    LOOP AT lth_test_data=>gt_class ASSIGNING <ls_class>
      WHERE
        parent IS INITIAL.
      CLEAR: lt_return.

      CALL FUNCTION 'BAPI_CLASS_DELETE'
        EXPORTING
          classnum  = <ls_class>-name
          classtype = <ls_class>-class_type
        TABLES
          return    = lt_return.

      LOOP AT lt_return ASSIGNING <ls_return>
        WHERE
          type CA 'EAX'.
        cl_abap_unit_assert=>fail(
          level = if_aunit_constants=>severity-low
          quit  = if_aunit_constants=>quit-no
          msg   = |Class delete error should not be returned: { <ls_class>-name }| ).
      ENDLOOP.
    ENDLOOP.

    COMMIT WORK AND WAIT.

    cl_abap_unit_assert=>assert_subrc(
      act   = sy-subrc
      level = if_aunit_constants=>severity-low
      quit  = if_aunit_constants=>quit-no
      msg   = |No error expected in update task| ).

  ENDMETHOD.

ENDCLASS.

CLASS lth_classification_handler DEFINITION
  FINAL
  FOR TESTING.

  PUBLIC SECTION.

    CLASS-METHODS:
      create_classification,
      remove_classification.

ENDCLASS.

CLASS lth_classification_handler IMPLEMENTATION.

  METHOD create_classification.

    DATA:
      lt_value TYPE tt_api_val_c.


    LOOP AT lth_test_data=>gt_classification ASSIGNING FIELD-SYMBOL(<ls_classification>).
      CLEAR: lt_value.

      /plmi/cl_clf_bo=>get_instance(
        EXPORTING
          it_lead_objkey = VALUE #(
            ( field = 'MATNR' value = <ls_classification>-object_name )
            ( field = 'MTART' value = 'FERT' ) )
          iv_objtyp      = 'MARA'
          iv_classtype   = <ls_classification>-class_type
          iv_langu       = sy-langu
        IMPORTING
          eo_bo          = DATA(lo_clf_bo)
          et_message     = DATA(lt_message) ).

      cl_abap_unit_assert=>assert_initial(
        act   = lt_message
        level = if_aunit_constants=>severity-low
        quit  = if_aunit_constants=>quit-no
        msg   = |No load messages expected| ).

      cl_abap_unit_assert=>assert_not_initial(
        act   = lo_clf_bo
        level = if_aunit_constants=>severity-low
        msg   = |BO should be initialized| ).

      lo_clf_bo->lock( ).

      lo_clf_bo->assign_class(
        EXPORTING
          iv_class   = <ls_classification>-class_name
        IMPORTING
          et_message = lt_message ).

      cl_abap_unit_assert=>assert_initial(
        act   = lt_message
        level = if_aunit_constants=>severity-low
        quit  = if_aunit_constants=>quit-no
        msg   = |No class assignment messages expected| ).

      LOOP AT lth_test_data=>gt_valuation ASSIGNING FIELD-SYMBOL(<ls_valuation>)
        WHERE
          object_name = <ls_classification>-object_name AND
          class_type  = <ls_classification>-class_type.

        SELECT SINGLE FROM cabn
          FIELDS atinn
          WHERE
            atnam = @<ls_valuation>-charc_name
          INTO @DATA(lv_atinn).

        cl_abap_unit_assert=>assert_subrc(
          act   = sy-subrc
          level = if_aunit_constants=>severity-low
          quit  = if_aunit_constants=>quit-no
          msg   = |Characteristic should exist in db| ).

        LOOP AT <ls_valuation>-values ASSIGNING FIELD-SYMBOL(<lv_value>).
          APPEND VALUE #( atinn = lv_atinn new_value = <lv_value> ) TO lt_value.
        ENDLOOP.
      ENDLOOP.

      lo_clf_bo->change_values(
        EXPORTING
          it_change_value = lt_value
        IMPORTING
          et_message      = lt_message ).

      cl_abap_unit_assert=>assert_initial(
        act   = lt_message
        level = if_aunit_constants=>severity-low
        quit  = if_aunit_constants=>quit-no
        msg   = |No value assignment messages expected| ).

      lo_clf_bo->check_before_save(
        IMPORTING
          et_message = lt_message ).

      cl_abap_unit_assert=>assert_initial(
        act   = lt_message
        level = if_aunit_constants=>severity-low
        quit  = if_aunit_constants=>quit-no
        msg   = |No check before save messages expected| ).

      CHECK lt_message IS INITIAL.

      lo_clf_bo->save(
        IMPORTING
          et_message = lt_message ).

      cl_abap_unit_assert=>assert_initial(
        act   = lt_message
        level = if_aunit_constants=>severity-low
        quit  = if_aunit_constants=>quit-no
        msg   = |No save messages expected| ).
    ENDLOOP.

    COMMIT WORK AND WAIT.

    cl_abap_unit_assert=>assert_subrc(
      act   = sy-subrc
      level = if_aunit_constants=>severity-low
      quit  = if_aunit_constants=>quit-no
      msg   = |No error expected in update task| ).

  ENDMETHOD.

  METHOD remove_classification.

    LOOP AT lth_test_data=>gt_classification ASSIGNING FIELD-SYMBOL(<ls_classification>).
      /plmi/cl_clf_bo=>get_instance(
        EXPORTING
          it_lead_objkey = VALUE #(
            ( field = 'MATNR' value = <ls_classification>-object_name )
            ( field = 'MTART' value = 'FERT' ) )
          iv_objtyp      = 'MARA'
          iv_classtype   = <ls_classification>-class_type
          iv_langu       = sy-langu
        IMPORTING
          eo_bo          = DATA(lo_clf_bo)
          et_message     = DATA(lt_message) ).

      cl_abap_unit_assert=>assert_initial(
        act   = lt_message
        level = if_aunit_constants=>severity-low
        quit  = if_aunit_constants=>quit-no
        msg   = |No load messages expected| ).

      cl_abap_unit_assert=>assert_not_initial(
        act   = lo_clf_bo
        level = if_aunit_constants=>severity-low
        quit  = if_aunit_constants=>quit-no
        msg   = |BO should be initialized| ).

      lo_clf_bo->lock( ).

      lo_clf_bo->remove_class(
        EXPORTING
          iv_class   = <ls_classification>-class_name
        IMPORTING
          et_message = lt_message ).

      cl_abap_unit_assert=>assert_initial(
        act   = lt_message
        level = if_aunit_constants=>severity-low
        quit  = if_aunit_constants=>quit-no
        msg   = |No class assignment messages expected| ).

      lo_clf_bo->check_before_save(
        IMPORTING
          et_message = lt_message ).

      cl_abap_unit_assert=>assert_initial(
        act   = lt_message
        level = if_aunit_constants=>severity-low
        quit  = if_aunit_constants=>quit-no
        msg   = |No check before save messages expected| ).

      lo_clf_bo->save(
        IMPORTING
          et_message = lt_message ).

      cl_abap_unit_assert=>assert_initial(
        act   = lt_message
        level = if_aunit_constants=>severity-low
        quit  = if_aunit_constants=>quit-no
        msg   = |No save messages expected| ).
    ENDLOOP.

    COMMIT WORK AND WAIT.

    cl_abap_unit_assert=>assert_subrc(
      act = sy-subrc
      level = if_aunit_constants=>severity-low
      quit  = if_aunit_constants=>quit-no
      msg = |No error expected in update task| ).

  ENDMETHOD.

ENDCLASS.

CLASS lth_material_handler DEFINITION
  FINAL
  FOR TESTING.

  PUBLIC SECTION.

    CLASS-METHODS:
      create_materials
      " Cannot remove
      .

ENDCLASS.

CLASS lth_material_handler IMPLEMENTATION.

  METHOD create_materials.

    DATA:
      lt_description TYPE STANDARD TABLE OF bapi_makt,
      ls_return      TYPE bapiret2.


    lt_description = VALUE #( ( matl_desc = 'Generated by NGC integration test' langu = sy-langu ) ).

    LOOP AT lth_test_data=>gt_material ASSIGNING FIELD-SYMBOL(<ls_material>).
      CLEAR: ls_return.

      DATA(ls_header)       = VALUE bapimathead( material = <ls_material>-name matl_type = 'FERT' basic_view = abap_true ind_sector = 'M' ).
      DATA(ls_basic_data)   = VALUE bapi_mara( base_uom = 'KG' base_uom_iso = 'KG' ).
      DATA(ls_basic_data_x) = VALUE bapi_marax( base_uom = 'KG' base_uom_iso = 'KG'  ).

      CALL FUNCTION 'BAPI_MATERIAL_SAVEDATA'
        EXPORTING
          headdata            = ls_header
          clientdata          = ls_basic_data
          clientdatax         = ls_basic_data_x
        IMPORTING
          return              = ls_return
        TABLES
          materialdescription = lt_description.
    ENDLOOP.

    COMMIT WORK AND WAIT.

  ENDMETHOD.

ENDCLASS.