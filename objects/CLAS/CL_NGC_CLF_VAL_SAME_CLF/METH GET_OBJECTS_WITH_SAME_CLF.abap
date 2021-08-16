  METHOD get_objects_with_same_clf.
* Original source: CLSC_SELECT_SAME_OBJECT - Function Module


    DATA lv_object TYPE cuobn.

    io_class->get_characteristics(
      IMPORTING
        et_characteristic = DATA(lt_characteristic) ).

    DATA(ls_class) = io_class->get_header( ).

    " Get objects with the given class assigned
    TEST-SEAM select_same_object.
      SELECT
          clfnobjectid,
          clfnobjecttable,
          classinternalid,
          classtype,
          clfnobjectinternalid,
          clfnstatus,
          classpositionnumber,
          classisstandardclass,
          bomisrecursive,
          changenumber,
          validitystartdate,
          validityenddate,
          \_class-class
        FROM i_clfnobjectclassforkeydate( p_keydate = @is_classification-key_date )
        WHERE classinternalid =  @ls_class-classinternalid
        APPENDING CORRESPONDING FIELDS OF TABLE @rt_same_objects.
    END-TEST-SEAM.

    TEST-SEAM select_class_type_details.
      SELECT SINGLE * FROM i_clfnclasstype
        INTO @DATA(ls_classtype)
        WHERE
          classtype = @ls_class-classtype.
    END-TEST-SEAM.

    DELETE rt_same_objects
      WHERE
        clfnobjectid = is_classification-object_key.

    CHECK rt_same_objects IS NOT INITIAL.

    " Check if selected objects have the same valuation
    me->check_same_valuation(
      EXPORTING
        iv_multiple_tables_allowed = ls_classtype-multipleobjtableclfnisallowed
        it_valuation               = it_valuation_data
        it_characteristics         = lt_characteristic
        iv_keydate                 = is_classification-key_date
      CHANGING
        ct_objects                 = rt_same_objects ).

  ENDMETHOD.