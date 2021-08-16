  METHOD create_class_initial_id.

    DATA:
      lt_class TYPE TABLE FOR CREATE i_clfnobjectclasstp.


    " Given: A not existing class
    lt_class = VALUE #(
      ( clfnobjectid    = lth_test_data=>cv_object_name_01
        clfnobjecttable = 'MARA'
        classtype       = lth_test_data=>cv_class_type_300 ) ).

    " When: I call create class
    MODIFY ENTITIES OF i_clfnobjecttp
      ENTITY objectclass
        CREATE FROM lt_class
          REPORTED DATA(lt_reported)
          FAILED DATA(lt_failed)
          MAPPED DATA(lt_mapped).

    " Then: Failed and reported should exist
    cl_abap_unit_assert=>assert_not_initial(
      act = lt_failed
      msg = 'Failed should not be initial' ).

    cl_abap_unit_assert=>assert_not_initial(
      act = lt_reported
      msg = 'Reported should not be initial' ).

    " And: Mapping should be initial
    cl_abap_unit_assert=>assert_initial(
      act = lt_mapped
      msg = 'Mapping should be initial' ).

  ENDMETHOD.