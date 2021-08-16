  METHOD if_ngc_core_clf_persistency~read_classtype_objtype_redun.

    read_classtypes_int( ).

    ASSIGN mt_classtypes_redun[ classtype       = iv_classtype
                                clfnobjecttable = iv_clfnobjecttable ]
      TO FIELD-SYMBOL(<ls_classtypes_redun>).
    IF sy-subrc = 0.
      rv_charcredundantstorisallowed = <ls_classtypes_redun>-charcredundantstorageisallowed.
    ENDIF.

  ENDMETHOD.