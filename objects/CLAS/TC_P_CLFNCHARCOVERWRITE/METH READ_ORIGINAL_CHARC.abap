  METHOD read_original_charc.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    SELECT * FROM p_clfncharcoverwrite
      INTO TABLE @DATA(lt_charc)
      WHERE
        charcinternalid = '0000000001' OR
        charcinternalid = '0000000002'.

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_initial(
      act = lt_charc ).

  ENDMETHOD.