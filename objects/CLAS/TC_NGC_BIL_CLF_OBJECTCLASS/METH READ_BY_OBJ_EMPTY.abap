  METHOD read_by_obj_empty.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    get_responses(
      IMPORTING
        es_reported      = DATA(ls_reported)
        es_failed        = DATA(ls_failed) ).

    DATA(lt_result) = VALUE if_ngc_bil_clf=>ts_obj-read_by-_objectclass-t_result( ( ) ).
    DATA(lt_link)   = VALUE if_ngc_bil_clf=>ts_obj-read_by-_objectclass-t_link( ( ) ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_clf~read_obj_objclass(
      EXPORTING
        it_input    = VALUE #( )
      IMPORTING
        et_result   = lt_result
        et_link     = lt_link
        es_failed   = ls_failed
        es_reported = ls_reported ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_initial(
      act = ls_failed
      msg = 'No failed entry was expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = ls_reported
      msg = 'No reported entry was expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_result
      msg = 'No result entry was expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_link
      msg = 'No link entry was expected' ).

  ENDMETHOD.