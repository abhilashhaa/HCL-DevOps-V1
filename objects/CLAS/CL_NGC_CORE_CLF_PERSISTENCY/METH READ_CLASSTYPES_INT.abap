  METHOD read_classtypes_int.

    DATA:
      lt_tclao TYPE STANDARD TABLE OF tclao,
      lt_tclt  TYPE STANDARD TABLE OF tclt.

    CHECK mt_classtypes IS INITIAL AND mt_classtypes_redun IS INITIAL.

    TEST-SEAM class_type_selection.
      SELECT
        classtype,
        clfnobjecttable,
        multipleobjtableclfnisallowed,
        clfnnewnumberingisallowed,
        engchangemgmtisallowed,
        multipleclassisallowed,
        clfnobjecthierarchylevel,
        classtypeisusableinvarconfign,
        \_classtypetext[ language = @sy-langu ]-classtypename AS classtypename    ##ASSOC_TO_N_OK[_CLASSTYPETEXT]
        FROM i_clfnclasstype
        INTO CORRESPONDING FIELDS OF TABLE @mt_classtypes.
    END-TEST-SEAM.

    " Get redundancy flag.
    SELECT klart obtab redun FROM tclao INTO CORRESPONDING FIELDS OF TABLE lt_tclao.
    SELECT obtab redun FROM tclt INTO CORRESPONDING FIELDS OF TABLE lt_tclt. "#EC CI_GENBUFF

    LOOP AT mt_classtypes ASSIGNING FIELD-SYMBOL(<ls_classtypes>).
      ASSIGN lt_tclao[ klart = <ls_classtypes>-classtype
                       obtab = <ls_classtypes>-clfnobjecttable ]
        TO FIELD-SYMBOL(<ls_tclao>).
      IF sy-subrc = 0.
        APPEND VALUE #(
          classtype                      = <ls_classtypes>-classtype
          clfnobjecttable                = <ls_classtypes>-clfnobjecttable
          charcredundantstorageisallowed = <ls_tclao>-redun ) TO mt_classtypes_redun.
      ELSE.
        ASSIGN lt_tclt[ obtab = <ls_classtypes>-clfnobjecttable ] TO FIELD-SYMBOL(<ls_tclt>).
        IF sy-subrc = 0.
          APPEND VALUE #(
            classtype                      = <ls_classtypes>-classtype
            clfnobjecttable                = <ls_classtypes>-clfnobjecttable
            charcredundantstorageisallowed = <ls_tclt>-redun ) TO mt_classtypes_redun.
        ELSE.
          APPEND VALUE #(
            classtype                      = <ls_classtypes>-classtype
            clfnobjecttable                = <ls_classtypes>-clfnobjecttable
            charcredundantstorageisallowed = abap_false ) TO mt_classtypes_redun.
        ENDIF.
      ENDIF.
    ENDLOOP.

    SORT: mt_classtypes ASCENDING BY clfnobjecttable classtype.
    SORT: mt_classtypes_redun ASCENDING BY clfnobjecttable classtype.

  ENDMETHOD.