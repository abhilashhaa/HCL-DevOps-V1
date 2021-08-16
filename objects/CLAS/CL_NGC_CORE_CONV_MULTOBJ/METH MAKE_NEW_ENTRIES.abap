METHOD make_new_entries.
  DATA:
    lv_cuobj         TYPE inob-cuobj,                    " neue Nummer
    lv_nrkreis       TYPE inri-nrrangenr VALUE '01',     " Nummernkreis
    lv_nrobject      TYPE inri-object    VALUE 'CU_INOB'." Nummernkreisobjekt

  DATA:
    lv_last_objek    TYPE cuobn,
    lv_last_klart    TYPE klassenart,
    lv_error         TYPE string.

  CLEAR: et_kssk_ins, et_ausp_ins, et_inob_ins.

  lv_last_objek = ''.
  lv_last_klart = ''.

  LOOP AT it_kssk ASSIGNING FIELD-SYMBOL(<is_kssk>).
    " We have to generate new inob-cuobj only when we have an other Class Type or other BO:
    IF <is_kssk>-objek NE lv_last_objek OR <is_kssk>-klart NE lv_last_klart.
      CALL FUNCTION 'NUMBER_GET_NEXT'
        EXPORTING
          nr_range_nr             = lv_nrkreis
          object                  = lv_nrobject
        IMPORTING
          number                  = lv_cuobj
        EXCEPTIONS
          interval_not_found      = 01
          number_range_not_intern = 02
          object_not_found        = 03
          quantity_is_0           = 04
          quantity_is_not_1       = 05
          interval_overflow       = 06
          buffer_overflow         = 07
          OTHERS                  = 08.
      IF sy-subrc NE 0.
        CASE sy-subrc.
          WHEN 01.
            lv_error = 'interval_not_found'.
          WHEN 02.
            lv_error = 'number_range_not_intern'.
          WHEN 03.
            lv_error = 'object_not_found'.
          WHEN 04.
            lv_error = 'quantity_is_0'.
          WHEN 05.
            lv_error = 'quantity_is_not_1'.
          WHEN 06.
            lv_error = 'interval_overflow'.
          WHEN 07.
            lv_error = 'buffer_overflow'.
          WHEN 08.
            lv_error = 'other'.
        ENDCASE.
        CALL FUNCTION 'DB_ROLLBACK'.
        RAISE EXCEPTION TYPE cx_data_conv_error
          MESSAGE ID 'UPGBA'
          TYPE 'E'
          NUMBER '033'
          WITH 'Exception raised in NUMBER_GET_NEXT: ' lv_error.
      ENDIF.

      " We need the tcla entry for this class type
      READ TABLE mt_tcla WITH TABLE KEY klart = <is_kssk>-klart ASSIGNING FIELD-SYMBOL(<ls_tcla>).
      " Since we already filtered the KSSK rows by tcla-klart in the CDS view,
      " it is theoretically impossible to have a non-existent class type here

      " Generate the new inob entry
      APPEND INITIAL LINE TO et_inob_ins ASSIGNING FIELD-SYMBOL(<es_inob_ins>).
      <es_inob_ins>-mandt = sy-mandt.
      <es_inob_ins>-cuobj = lv_cuobj.
      <es_inob_ins>-klart = <is_kssk>-klart.
      <es_inob_ins>-obtab = <ls_tcla>-obtab.
      <es_inob_ins>-objek = <is_kssk>-objek.

      " Replace the BO id in all ausp entries with this objek and klart
      LOOP AT it_ausp ASSIGNING FIELD-SYMBOL(<is_ausp>) WHERE objek = <is_kssk>-objek AND klart = <is_kssk>-klart.
        APPEND <is_ausp> TO et_ausp_ins ASSIGNING FIELD-SYMBOL(<es_ausp_ins>).
        <es_ausp_ins>-mandt = sy-mandt.
        <es_ausp_ins>-objek = lv_cuobj.
      ENDLOOP.
    ENDIF.

    APPEND <is_kssk> TO et_kssk_ins ASSIGNING FIELD-SYMBOL(<es_kssk_ins>).
    <es_kssk_ins>-mandt = sy-mandt.
    <es_kssk_ins>-objek = lv_cuobj.

    lv_last_objek = <is_kssk>-objek.
    lv_last_klart = <is_kssk>-klart.
  ENDLOOP.
ENDMETHOD.