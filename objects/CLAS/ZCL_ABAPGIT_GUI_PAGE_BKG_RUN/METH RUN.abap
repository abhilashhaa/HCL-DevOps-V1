  METHOD run.

    DATA: lx_error TYPE REF TO zcx_abapgit_exception,
          lv_text  TYPE string,
          lv_line  TYPE i VALUE 1.


    TRY.
        zcl_abapgit_background=>run( ).

        DO.
          READ LINE lv_line LINE VALUE INTO lv_text.
          IF sy-subrc <> 0.
            EXIT.
          ENDIF.
          APPEND lv_text TO mt_text.
          lv_line = lv_line + 1.
        ENDDO.
      CATCH zcx_abapgit_exception INTO lx_error.
        APPEND lx_error->get_text( ) TO mt_text.
    ENDTRY.

  ENDMETHOD.