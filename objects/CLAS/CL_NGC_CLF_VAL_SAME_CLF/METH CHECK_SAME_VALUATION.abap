  METHOD check_same_valuation.

    TYPES: lty_where_condition TYPE c LENGTH 80.

    DATA:
      lt_where_condition        TYPE TABLE OF lty_where_condition,
      lt_where_condition_buffer TYPE TABLE OF lty_where_condition,
      lt_valuation              TYPE ngct_valuation_data,
      lv_same_clf_exists        TYPE abap_bool,
      lv_object                 TYPE cuobn.

    " Check valuation for each selected object
    LOOP AT ct_objects INTO DATA(ls_object).

      " Each characteristic should have the same valuation
      LOOP AT it_characteristics INTO DATA(ls_characteristic).
        CLEAR: lt_valuation, lt_where_condition.

        lv_same_clf_exists = abap_false.

        LOOP AT it_valuation INTO DATA(ls_valuation)
          WHERE
            charcinternalid = ls_characteristic-charcinternalid.
          APPEND ls_valuation TO lt_valuation.
        ENDLOOP.

        IF lt_valuation IS INITIAL.
          CONTINUE.
        ENDIF.

        DATA(ls_characteristic_header) = ls_characteristic-characteristic_object->get_header( ).

        " Build where condition table using valuation data
        lt_where_condition = VALUE #( ( '(' ) ).

        LOOP AT lt_valuation INTO ls_valuation.
          IF sy-tabix <> 1.
            APPEND 'OR ' TO lt_where_condition.
          ENDIF.

          CLEAR: lt_where_condition_buffer.

          IF ls_characteristic_header-charcdatatype = if_ngc_c=>gc_charcdatatype-char.
            DATA(lv_charcvalue) = cl_abap_dyn_prg=>escape_quotes( ls_valuation-charcvalue ).

            lt_where_condition_buffer = VALUE #(
              ( 'CHARCVALUE = ''' && lv_charcvalue && '''' ) ).
          ELSE.
            DATA(lv_epsilon) = get_epsilon( ls_valuation-charcfromnumericvalue ).
            DATA(lv_low_charcfromnumericvalue) = ls_valuation-charcfromnumericvalue - lv_epsilon.
            DATA(lv_high_charcfromnumericvalue) = ls_valuation-charcfromnumericvalue + lv_epsilon.

            lv_epsilon = get_epsilon( ls_valuation-charcfromnumericvalue ).
            DATA(lv_low_charctonumericvalue) = ls_valuation-charctonumericvalue - lv_epsilon.
            DATA(lv_high_charctonumericvalue) = ls_valuation-charctonumericvalue + lv_epsilon.

            IF ls_characteristic_header-valueintervalisallowed = abap_true.
              CASE ls_valuation-charcvaluedependency.
                WHEN 1.
                  lt_where_condition_buffer = VALUE #(
                    ( '( CHARCVALUEDEPENDENCY = 1 ' )
                    ( 'AND CHARCFROMNUMERICVALUE >= ''' && lv_low_charcfromnumericvalue  && '''' )
                    ( 'AND CHARCFROMNUMERICVALUE <= ''' && lv_high_charcfromnumericvalue && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 2' )
                    ( 'AND CHARCFROMNUMERICVALUE <= ''' && lv_high_charcfromnumericvalue && '''' )
                    ( 'AND CHARCTONUMERICVALUE > '''    && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 3' )
                    ( 'AND CHARCFROMNUMERICVALUE <= ''' && lv_high_charcfromnumericvalue && '''' )
                    ( 'AND CHARCTONUMERICVALUE >= '''   && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 4' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charcfromnumericvalue && '''' )
                    ( 'AND CHARCTONUMERICVALUE > '''    && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 5' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charcfromnumericvalue && '''' )
                    ( 'AND CHARCTONUMERICVALUE >= '''   && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 6' )
                    ( 'AND CHARCFROMNUMERICVALUE > '''  && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 7' )
                    ( 'AND CHARCFROMNUMERICVALUE >= ''' && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 8' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charcfromnumericvalue && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 9 ' )
                    ( 'AND CHARCFROMNUMERICVALUE <= ''' && lv_high_charcfromnumericvalue && ''' )' ) ).

                WHEN 2.
                  lt_where_condition_buffer = VALUE #(
                    ( '( CHARCVALUEDEPENDENCY = 1' )
                    ( 'AND CHARCFROMNUMERICVALUE >= ''' && lv_low_charcfromnumericvalue  && '''' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charctonumericvalue   && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 2' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charctonumericvalue   && '''' )
                    ( 'AND CHARCTONUMERICVALUE > '''    && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 3' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charctonumericvalue   && '''' )
                    ( 'AND CHARCTONUMERICVALUE >= '''   && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 4' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charctonumericvalue   && '''' )
                    ( 'AND CHARCTONUMERICVALUE > '''    && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 5' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charctonumericvalue   && '''' )
                    ( 'AND CHARCTONUMERICVALUE >= '''   && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 6' )
                    ( 'AND CHARCFROMNUMERICVALUE > '''  && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 7' )
                    ( 'AND CHARCFROMNUMERICVALUE >= ''' && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 8' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charctonumericvalue   && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 9' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charctonumericvalue   && ''' )' ) ).

                WHEN 3.
                  lt_where_condition_buffer = VALUE #(
                    ( '( CHARCVALUEDEPENDENCY = 1' )
                    ( 'AND CHARCFROMNUMERICVALUE >= ''' && lv_low_charcfromnumericvalue  && '''' )
                    ( 'AND CHARCFROMNUMERICVALUE <= ''' && lv_high_charctonumericvalue   && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 2' )
                    ( 'AND CHARCFROMNUMERICVALUE <= ''' && lv_high_charctonumericvalue   && '''' )
                    ( 'AND CHARCTONUMERICVALUE > '''    && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 3' )
                    ( 'AND CHARCFROMNUMERICVALUE <= ''' && lv_high_charctonumericvalue   && '''' )
                    ( 'AND CHARCTONUMERICVALUE >= '''   && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 4' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charctonumericvalue   && '''' )
                    ( 'AND CHARCTONUMERICVALUE > '''    && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 5' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charctonumericvalue   && '''' )
                    ( 'AND CHARCTONUMERICVALUE >= '''   && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 6' )
                    ( 'AND CHARCFROMNUMERICVALUE > '''  && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 7' )
                    ( 'AND CHARCFROMNUMERICVALUE >= ''' && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 8' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charctonumericvalue   && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 9' )
                    ( 'AND CHARCFROMNUMERICVALUE <= ''' && lv_high_charctonumericvalue   && ''' )' ) ).

                WHEN 4.
                  lt_where_condition_buffer = VALUE #(
                    ( '( CHARCVALUEDEPENDENCY = 1' )
                    ( 'AND CHARCFROMNUMERICVALUE > '''  && lv_low_charcfromnumericvalue  && '''' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charctonumericvalue   && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 2' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charctonumericvalue   && '''' )
                    ( 'AND CHARCTONUMERICVALUE > '''    && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 3' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charctonumericvalue   && '''' )
                    ( 'AND CHARCTONUMERICVALUE > '''    && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 4' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charctonumericvalue   && '''' )
                    ( 'AND CHARCTONUMERICVALUE > '''    && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 5' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charctonumericvalue   && '''' )
                    ( 'AND CHARCTONUMERICVALUE > '''    && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 6' )
                    ( 'AND CHARCFROMNUMERICVALUE > '''  && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 7' )
                    ( 'AND CHARCFROMNUMERICVALUE > '''  && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 8' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charctonumericvalue   && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 9' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charctonumericvalue   && ''' )' ) ).

                WHEN 5.
                  lt_where_condition_buffer = VALUE #(
                    ( '( CHARCVALUEDEPENDENCY = 1' )
                    ( 'AND CHARCFROMNUMERICVALUE > '''  && lv_low_charcfromnumericvalue  && '''' )
                    ( 'AND CHARCFROMNUMERICVALUE <= ''' && lv_high_charctonumericvalue   && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 2' )
                    ( 'AND CHARCFROMNUMERICVALUE <= ''' && lv_high_charctonumericvalue   && '''' )
                    ( 'AND CHARCTONUMERICVALUE > '''    && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 3' )
                    ( 'AND CHARCFROMNUMERICVALUE <= ''' && lv_high_charctonumericvalue   && '''' )
                    ( 'AND CHARCTONUMERICVALUE > '''    && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 4' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charctonumericvalue   && '''' )
                    ( 'AND CHARCTONUMERICVALUE > '''    && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 5' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charctonumericvalue   && '''' )
                    ( 'AND CHARCTONUMERICVALUE > '''    && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 6' )
                    ( 'AND CHARCFROMNUMERICVALUE > '''  && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 7' )
                    ( 'AND CHARCFROMNUMERICVALUE > '''  && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 8' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charctonumericvalue   && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 9' )
                    ( 'AND CHARCFROMNUMERICVALUE <= ''' && lv_high_charctonumericvalue   && ''' )' ) ).

                WHEN 6.
                  lt_where_condition_buffer = VALUE #(
                    ( '( CHARCVALUEDEPENDENCY = 1' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charcfromnumericvalue && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 2' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charcfromnumericvalue && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 3' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charcfromnumericvalue && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 4' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charcfromnumericvalue && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 5' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charcfromnumericvalue && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 6 )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 7 )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 8' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charcfromnumericvalue && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 9' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charcfromnumericvalue && ''' )' ) ).

                WHEN 7.
                  lt_where_condition_buffer = VALUE #(
                    ( '( CHARCVALUEDEPENDENCY = 1' )
                    ( 'AND CHARCFROMNUMERICVALUE <= ''' && lv_high_charcfromnumericvalue && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 2' )
                    ( 'AND CHARCFROMNUMERICVALUE <= ''' && lv_high_charcfromnumericvalue && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 3' )
                    ( 'AND CHARCFROMNUMERICVALUE <= ''' && lv_high_charcfromnumericvalue && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 4' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charcfromnumericvalue && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 5' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charcfromnumericvalue && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 6 )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 7 )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 8' )
                    ( 'AND CHARCFROMNUMERICVALUE < '''  && lv_high_charcfromnumericvalue && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 9' )
                    ( 'AND CHARCFROMNUMERICVALUE <= ''' && lv_high_charcfromnumericvalue && ''' )' ) ).

                WHEN 8.
                  lt_where_condition_buffer = VALUE #(
                    ( '( CHARCVALUEDEPENDENCY = 1' )
                    ( 'AND CHARCFROMNUMERICVALUE > '''  && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 2' )
                    ( 'AND CHARCTONUMERICVALUE > '''    && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 3' )
                    ( 'AND CHARCTONUMERICVALUE > '''    && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 4' )
                    ( 'AND CHARCTONUMERICVALUE > '''    && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 5' )
                    ( 'AND CHARCTONUMERICVALUE > '''    && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 6' )
                    ( 'AND CHARCFROMNUMERICVALUE > '''  && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 7' )
                    ( 'AND CHARCFROMNUMERICVALUE > '''  && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 8 )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 9 )' ) ).

                WHEN 9.
                  lt_where_condition_buffer = VALUE #(
                    ( '( CHARCVALUEDEPENDENCY = 1' )
                    ( 'AND CHARCFROMNUMERICVALUE >= ''' && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 2' )
                    ( 'AND CHARCTONUMERICVALUE > '''    && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 3' )
                    ( 'AND CHARCTONUMERICVALUE >= '''   && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 4' )
                    ( 'AND CHARCTONUMERICVALUE > '''    && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 5' )
                    ( 'AND CHARCTONUMERICVALUE >= '''   && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 6' )
                    ( 'AND CHARCFROMNUMERICVALUE > '''  && lv_low_charcfromnumericvalue  && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 7' )
                    ( 'AND CHARCFROMNUMERICVALUE >= '''  && lv_low_charcfromnumericvalue && ''' )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 8 )' )

                    ( 'OR ( CHARCVALUEDEPENDENCY = 9 )' ) ).
              ENDCASE.
            ELSE.
              lt_where_condition_buffer = VALUE #(
                ( '( CHARCFROMNUMERICVALUE >= '''   && lv_low_charcfromnumericvalue  && '''' )
                ( 'AND CHARCFROMNUMERICVALUE <= ''' && lv_high_charcfromnumericvalue && ''' )' ) ).
            ENDIF.
          ENDIF.

          APPEND LINES OF lt_where_condition_buffer TO lt_where_condition.
        ENDLOOP.

        APPEND ')' TO lt_where_condition.

        TEST-SEAM select_same_valuation.
          SELECT SINGLE @abap_true FROM i_clfnobjectcharcvalforkeydate( p_keydate = @iv_keydate )
            WHERE
              charcinternalid      = @ls_characteristic-charcinternalid AND
              clfnobjectid         = @ls_object-clfnobjectid AND
              classtype            = @ls_object-classtype AND
              clfnobjecttype       = 'O' AND
              (lt_where_condition)
            INTO @lv_same_clf_exists.
        END-TEST-SEAM.

        IF lv_same_clf_exists = abap_false.
          EXIT.
        ENDIF.

      ENDLOOP.

      IF lv_same_clf_exists = abap_false.
        DELETE ct_objects.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.