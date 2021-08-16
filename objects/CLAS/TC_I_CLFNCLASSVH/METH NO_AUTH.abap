  METHOD no_auth.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lo_no_auth) = cl_cds_test_data=>create_access_control_data( VALUE #( ) ).
    go_environment->get_access_control_double( )->enable_access_control( lo_no_auth ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    SELECT * FROM i_clfnclassvh
      INTO TABLE @DATA(lt_result).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_initial(
      act = lt_result ).

  ENDMETHOD.