  METHOD read_sotr.

    FIELD-SYMBOLS <ls_sotr_use> TYPE sotr_use.

    " Known SOTR usage...
    " LIMU: CPUB, WAPP, WDYV
    " R3TR: ENHC, ENHO, ENHS, ENSC, SCGR, SMIF, WDYA, WEBI, WEBS

    et_sotr_use = get_sotr_usage( iv_pgmid    = iv_pgmid
                                  iv_object   = iv_object
                                  iv_obj_name = iv_obj_name ).

    LOOP AT et_sotr_use ASSIGNING <ls_sotr_use> WHERE NOT concept IS INITIAL.
      INSERT get_sotr_4_concept( <ls_sotr_use>-concept ) INTO TABLE et_sotr.
    ENDLOOP.

    IF io_xml IS BOUND.
      io_xml->add( iv_name = 'SOTR'
                   ig_data = et_sotr ).
      io_xml->add( iv_name = 'SOTR_USE'
                   ig_data = et_sotr_use ).
    ENDIF.

  ENDMETHOD.