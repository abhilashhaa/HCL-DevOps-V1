  METHOD get_clmdpc_data.

    LOOP AT it_kssk ASSIGNING FIELD-SYMBOL(<ls_kssk>)
      WHERE
        vwstl = abap_true.
      IF line_exists( it_ausp[
        objek = <ls_kssk>-objek
        klart = <ls_kssk>-klart ] ).
        APPEND INITIAL LINE TO et_clmdpc ASSIGNING FIELD-SYMBOL(<ls_clmdpc>).

        <ls_clmdpc>-class = <ls_kssk>-class.
        <ls_clmdpc>-klart = <ls_kssk>-klart.
        <ls_clmdpc>-matnr = <ls_kssk>-objek.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.