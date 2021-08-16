  METHOD no_auth_for_classtype.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lo_display_023) = cl_cds_test_data=>create_access_control_data(
      VALUE #(
        ( object         = 'C_TCLA_BKA'
          authorizations = VALUE #(
            ( VALUE #(
                ( fieldname   = 'KLART'
                  fieldvalues = VALUE #(
                    ( lower_value = '023' ) ) ) ) ) ) )

        ( object         = 'C_KLAH_BKP'
          authorizations = VALUE #(
            ( VALUE #(
                ( fieldname   = 'ACTVT'
                  fieldvalues = VALUE #(
                    ( lower_value = '*' ) ) ) ) ) ) ) ) ).
    go_environment->get_access_control_double( )->enable_access_control( lo_display_023 ).

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