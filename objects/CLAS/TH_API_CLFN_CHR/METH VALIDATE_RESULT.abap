  METHOD validate_result.

*--------------------------------------------------------------------*
* Validate characteristic data
*--------------------------------------------------------------------*

    SELECT SINGLE * FROM a_clfncharacteristicforkeydate( p_keydate = @sy-datum )
      WHERE
        charcinternalid = @is_charc-charcinternalid
      INTO @DATA(ls_charc).

    cl_abap_unit_assert=>assert_not_initial(
      act = ls_charc
      msg = |Characteristic should exist| ).

    cl_abap_unit_assert=>assert_equals(
      act = ls_charc-multiplevaluesareallowed
      exp = is_charc-multiplevaluesareallowed
      msg = |Expected 'multiplevaluesareallowed' should be read| ).

    cl_abap_unit_assert=>assert_equals(
      act = ls_charc-charcstatus
      exp = is_charc-charcstatus
      msg = |Expected 'charcstatus' should be read| ).

    cl_abap_unit_assert=>assert_equals(
      act = ls_charc-characteristic
      exp = is_charc-characteristic
      msg = |Expected 'characteristic' should be read| ).

*--------------------------------------------------------------------*
* Validate characteristic description data
*--------------------------------------------------------------------*

    SELECT * FROM a_clfncharcdescforkeydate( p_keydate = @sy-datum )
      WHERE
        charcinternalid = @is_charc-charcinternalid
      INTO TABLE @DATA(lt_charc_desc).

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_charc_desc )
      exp = lines( it_charc_desc )
      msg = |Expected number of descriptions should be created| ).

    LOOP AT it_charc_desc ASSIGNING FIELD-SYMBOL(<ls_charc_desc>).
      DATA(ls_charc_desc) = VALUE #( lt_charc_desc[ language = <ls_charc_desc>-language ] OPTIONAL ).

      cl_abap_unit_assert=>assert_not_initial(
        act = ls_charc_desc
        msg = |Characteristic desc should exist with language { <ls_charc_desc>-language }| ).

      cl_abap_unit_assert=>assert_equals(
        act = ls_charc_desc-charcdescription
        exp = <ls_charc_desc>-charcdescription
        msg = |Expected 'charcdescription' should be read| ).
    ENDLOOP.

*--------------------------------------------------------------------*
* Validate characteristic reference data
*--------------------------------------------------------------------*

    SELECT * FROM a_clfncharcrefforkeydate( p_keydate = @sy-datum )
      WHERE
        charcinternalid = @is_charc-charcinternalid
      INTO TABLE @DATA(lt_charc_ref).

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_charc_ref )
      exp = lines( it_charc_ref )
      msg = |Expected number of references should be created| ).

    LOOP AT it_charc_ref ASSIGNING FIELD-SYMBOL(<ls_charc_ref>).
      DATA(ls_charc_ref) = VALUE #( lt_charc_ref[ charcreferencetable = <ls_charc_ref>-charcreferencetable charcreferencetablefield = <ls_charc_ref>-charcreferencetablefield ] OPTIONAL ).

      cl_abap_unit_assert=>assert_not_initial(
        act = ls_charc_ref
        msg = |Characteristic ref should exist with { <ls_charc_ref>-charcreferencetable }:{ <ls_charc_ref>-charcreferencetablefield }| ).

      cl_abap_unit_assert=>assert_equals(
        act = ls_charc_ref-charcreferencetable
        exp = <ls_charc_ref>-charcreferencetable
        msg = |Expected 'charcreferencetable' should be read| ).

      cl_abap_unit_assert=>assert_equals(
        act = ls_charc_ref-charcreferencetablefield
        exp = <ls_charc_ref>-charcreferencetablefield
        msg = |Expected 'charcreferencetablefield' should be read| ).
    ENDLOOP.

*--------------------------------------------------------------------*
* Validate characteristic restriction data
*--------------------------------------------------------------------*

    SELECT * FROM a_clfncharcrstrcnforkeydate( p_keydate = @sy-datum )
      WHERE
        charcinternalid = @is_charc-charcinternalid
      INTO TABLE @DATA(lt_charc_rstrcn).

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_charc_rstrcn )
      exp = lines( it_charc_rstrcn )
      msg = |Expected number of restrictions should be created| ).

    LOOP AT it_charc_rstrcn ASSIGNING FIELD-SYMBOL(<ls_charc_rstrcn>).
      DATA(ls_charc_rstrcn) = VALUE #( lt_charc_rstrcn[ classtype = <ls_charc_rstrcn>-classtype ] OPTIONAL ).

      cl_abap_unit_assert=>assert_not_initial(
        act = ls_charc_rstrcn
        msg = |Characteristic rstrcn should exist with class type { <ls_charc_rstrcn>-classtype }| ).

      cl_abap_unit_assert=>assert_equals(
        act = ls_charc_rstrcn-classtype
        exp = <ls_charc_rstrcn>-classtype
        msg = |Expected 'classtype' should be read| ).
    ENDLOOP.

*--------------------------------------------------------------------*
* Validate characteristic value data
*--------------------------------------------------------------------*

    SELECT * FROM a_clfncharcvalueforkeydate( p_keydate = @sy-datum )
      WHERE
        charcinternalid = @is_charc-charcinternalid
      INTO TABLE @DATA(lt_charc_val).

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_charc_val )
      exp = lines( it_charc_val )
      msg = |Expected number of values should be created| ).

    LOOP AT it_charc_val ASSIGNING FIELD-SYMBOL(<ls_charc_val>).
      DATA(ls_charc_val) = VALUE #( lt_charc_val[ charcvalue = <ls_charc_val>-charcvalue ] OPTIONAL ).

      cl_abap_unit_assert=>assert_not_initial(
        act = ls_charc_val
        msg = |Characteristic value { <ls_charc_val>-charcvalue } should exist| ).

      cl_abap_unit_assert=>assert_equals(
        act = ls_charc_val-charcvalue
        exp = <ls_charc_val>-charcvalue
        msg = |Expected 'charcvalue' should be read| ).

      cl_abap_unit_assert=>assert_equals(
        act = ls_charc_val-charcvaluedependency
        exp = <ls_charc_val>-charcvaluedependency
        msg = |Expected 'charcvaluedependency' should be read| ).
    ENDLOOP.

*--------------------------------------------------------------------*
* Validate characteristic value description data
*--------------------------------------------------------------------*

    " TODO: Enhance JSON parser to handle charc value description

*    SELECT * FROM a_clfncharcvaluedescforkeydate( p_keydate = @sy-datum )
*      WHERE
*        charcinternalid = @lv_charcinternalid
*      INTO TABLE @DATA(lt_charc_val_desc).
*
*    cl_abap_unit_assert=>assert_equals(
*      act = lines( lt_charc_val_desc )
*      exp = 1
*      msg = |One value description should be created| ).
*
*    cl_abap_unit_assert=>assert_equals(
*      act = lt_charc_val_desc[ 1 ]-language
*      exp = ms_chr_val_desc_en-language
*      msg = |Expected 'language' should be read| ).
*
*    cl_abap_unit_assert=>assert_equals(
*      act = lt_charc_val_desc[ 1 ]-charcvaluedescription
*      exp = ms_chr_val_desc_en-charcvaluedescription
*      msg = |Expected 'charcvaluedescription' should be read| ).

  ENDMETHOD.