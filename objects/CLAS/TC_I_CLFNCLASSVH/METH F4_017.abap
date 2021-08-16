  METHOD f4_017.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lo_f4_017) = cl_cds_test_data=>create_access_control_data(
      VALUE #(
        ( object         = 'C_TCLA_BKA'
          authorizations = VALUE #(
            ( VALUE #(
                ( fieldname   = 'KLART'
                  fieldvalues = VALUE #(
                    ( lower_value = '017' ) ) ) ) ) ) )

        ( object         = 'C_KLAH_BKP'
          authorizations = VALUE #(
            ( VALUE #(
                ( fieldname   = 'ACTVT'
                  fieldvalues = VALUE #(
                    ( lower_value = 'F4' ) ) ) ) ) ) ) ) ).
    go_environment->get_access_control_double( )->enable_access_control( lo_f4_017 ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    SELECT * FROM i_clfnclassvh
      INTO TABLE @DATA(lt_result).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_result )
      exp = 1 ).

  ENDMETHOD.