METHOD query_charchier_class_ext_key.

* Assumption: IT_CLASS_RANGE_BY_CLASSTYPE contains list of class ids, with only
*  sign = 'I' and option = 'EQ'.
*
* This method fills up mt_clfnclasshiercharc and mt_clfnclasshiercharcforkeydat tables
* Role of these tables:
*  - mt_clfnclasshiercharc: contains each characteristic for a class, own characteristics and inherited as well
*  - mt_clfnclasshiercharcforkeydat: similar to mt_clfnclasshiercharc, but contains more rows. This table contains
*     additional row for the inherited characteristic, in the following format:
*      - ClassInternalId:         this class
*      - AncestorClassInternalId: this class
*      - CharcInternalId:         internal id of the inherited char.
*      - Class:                   this class
*      - AncestorClass:           this class
*      - Characteristic:          name of the inherited char.

  DATA:
    lt_clfnclasshiercharcforkeydat TYPE tt_clfnclasshiercharcforkeydat,
    lt_classhiercharc_buffer       TYPE tt_clfnclasshiercharcforkeydat,
    lt_class_range_by_classtype    TYPE tt_class_ext_key_with_range,
    lt_ancestor_range              TYPE RANGE OF clint,
    lv_lines_already_read          TYPE int4 VALUE 0,
    lt_class_range_to_be_read      TYPE tt_class_range,
    lt_class_int_range_to_be_read  TYPE RANGE OF clint.

  lt_class_range_by_classtype = it_class_range_by_classtype.

  " if MT_CLFNCLASSHIERCHARC already contain this class,
  " we will not go further with the selections with this class
  LOOP AT lt_class_range_by_classtype ASSIGNING FIELD-SYMBOL(<ls_class_range_by_classtype>).
    LOOP AT <ls_class_range_by_classtype>-class ASSIGNING FIELD-SYMBOL(<ls_range_class>)
      WHERE sign   = if_ngc_core_c=>gc_range_sign-include
        AND option = if_ngc_core_c=>gc_range_option-equals.
      READ TABLE mt_clfnclasshiercharc TRANSPORTING NO FIELDS
        WITH KEY key_date  = <ls_class_range_by_classtype>-key_date
                 classtype = <ls_class_range_by_classtype>-classtype
                 class     = <ls_range_class>-low.
      IF sy-subrc = 0.
        " this will delete the actual row from <ls_class_range_by_classtype>-class table
        " (which is a range)
        DELETE <ls_class_range_by_classtype>-class.
      ENDIF.
    ENDLOOP.
    IF <ls_class_range_by_classtype>-class IS INITIAL.
      " delete the current row from lt_class_range_by_classtype
      DELETE lt_class_range_by_classtype.
    ENDIF.
  ENDLOOP.

  LOOP AT lt_class_range_by_classtype ASSIGNING <ls_class_range_by_classtype>.
    CLEAR: lt_clfnclasshiercharcforkeydat, lv_lines_already_read.

    WHILE lv_lines_already_read < lines( <ls_class_range_by_classtype>-class ).
      CLEAR: lt_class_range_to_be_read.
      APPEND LINES OF <ls_class_range_by_classtype>-class
        FROM lv_lines_already_read + 1 TO lv_lines_already_read + if_ngc_core_c=>gc_range_entries_max
        TO lt_class_range_to_be_read.
      ADD if_ngc_core_c=>gc_range_entries_max TO lv_lines_already_read.
      TEST-SEAM sel_cds_classcharc_ext_key.
        SELECT
          @<ls_class_range_by_classtype>-key_date AS key_date,
          classsuperior~classinternalid,
          classsuperior~ancestorclassinternalid,
          classcharcbasic~charcinternalid,
          classsuperior~classtype,
          classsuperior~class,
          classsuperior~ancestorclass,
          CASE WHEN classsuperior~classinternalid = classcharcbasic~classinternalid
            THEN ' '
            ELSE 'X'
          END AS charcisinherited,
          characteristic~characteristic,
          classcharcbasic~overwrittencharcinternalid,
          classcharcbasic~clfnorganizationalarea
          FROM i_clfnclasssuperiorforkeydate( p_keydate = @<ls_class_range_by_classtype>-key_date )  AS classsuperior
             LEFT OUTER JOIN i_clfnclasscharcbasic   AS classcharcbasic
               ON  classcharcbasic~classinternalid   = classsuperior~ancestorclassinternalid
               AND ( ( classcharcbasic~validitystartdate <= @<ls_class_range_by_classtype>-key_date
                   AND classcharcbasic~validityenddate   >= @<ls_class_range_by_classtype>-key_date )
                  OR ( classcharcbasic~validitystartdate IS INITIAL " tolerate the case when KSML valid from date and valid to date are both initial
                   AND classcharcbasic~validityenddate   IS INITIAL ) )
               AND classcharcbasic~isdeleted         =  ''
             LEFT OUTER JOIN i_clfncharcbasic        AS characteristic
               ON  characteristic~charcinternalid    = classcharcbasic~charcinternalid
               AND characteristic~validitystartdate  <= @<ls_class_range_by_classtype>-key_date
               AND characteristic~validityenddate    >= @<ls_class_range_by_classtype>-key_date
               AND characteristic~isdeleted          =  ''
           WHERE classsuperior~classtype =  @<ls_class_range_by_classtype>-classtype
             AND classsuperior~class     IN @lt_class_range_to_be_read
           APPENDING CORRESPONDING FIELDS OF TABLE @lt_clfnclasshiercharcforkeydat.
      END-TEST-SEAM.
    ENDWHILE.

    LOOP AT lt_clfnclasshiercharcforkeydat ASSIGNING FIELD-SYMBOL(<ls_clfnclasshiercharc>).
      IF <ls_clfnclasshiercharc>-classinternalid = <ls_clfnclasshiercharc>-ancestorclassinternalid.
        APPEND  <ls_clfnclasshiercharc> TO mt_clfnclasshiercharc.
      ENDIF.
    ENDLOOP.

    " The following part is needed because in MT_CLFNCLASSHIERHARC we store a characteristic
    " only once, in case it is inherited from multiple superclasses.
    " The superclass with the lower CLINT is taken into account (that's why the table is
    " sorted by ANCESTORCLASSINTERNALID).
    LOOP AT lt_clfnclasshiercharcforkeydat ASSIGNING <ls_clfnclasshiercharc>.
      READ TABLE mt_clfnclasshiercharc TRANSPORTING NO FIELDS
        WITH KEY classinternalid = <ls_clfnclasshiercharc>-classinternalid
                 charcinternalid = <ls_clfnclasshiercharc>-charcinternalid
                 key_date        = <ls_clfnclasshiercharc>-key_date.
      IF sy-subrc <> 0.
        APPEND <ls_clfnclasshiercharc> TO mt_clfnclasshiercharc.
      ENDIF.
    ENDLOOP.

*--------------------------------------------------------------------*
* MT_CLFNCLASSHIERCHARCFORKEYDAT is very similar to LT_CLFCLASSHIERCHARCFORKEYDAT,
* but:
*  - CLFNORGANIZATIONALAREA is empty
*  - CHARCISINHERITED is empty
* In addition to this, MT_CLFNCLASSHIERCHARCFORKEYDAT will contain an additional
* row for each inherited characteristic of the class, and this row will look like
* the following:
*  - CLASSINTERNALID = ANCESTORCLASSINTERNALID = Internal Id of the current class
*  - CLASS = ANCESTORCLASS = External Id of the current class
*  - CLFNORGANIZATIONALAREA is empty
*  - CHARCISINHERITED = 'X'
* This additional row is also inserted in case the characteristic is not inherited from
* the direct parent of the class, but from some further ancestor. From the
* MT_CLFNCLASSHIERCHARCFORKEYDAT table it is possible to get the whole tree back to the
* origin of the characteristic.
*--------------------------------------------------------------------*

    CLEAR: lt_ancestor_range.
    LOOP AT lt_clfnclasshiercharcforkeydat ASSIGNING <ls_clfnclasshiercharc>.
      " not just the ancestor class internal id, but the the class internal id
      " should also be put to LT_ANCESTOR_RANGE
      " otherwise, if the class does not have an own characteristics, just inherited
      " characteristics, then the characteristics would not be returned
      APPEND VALUE #( sign   = if_ngc_core_c=>gc_range_sign-include
                      option = if_ngc_core_c=>gc_range_option-equals
                      low    = <ls_clfnclasshiercharc>-classinternalid ) TO lt_ancestor_range.
      APPEND VALUE #( sign   = if_ngc_core_c=>gc_range_sign-include
                      option = if_ngc_core_c=>gc_range_option-equals
                      low    = <ls_clfnclasshiercharc>-ancestorclassinternalid ) TO lt_ancestor_range.
    ENDLOOP.
    SORT lt_ancestor_range ASCENDING BY sign option low.
    DELETE ADJACENT DUPLICATES FROM lt_ancestor_range COMPARING sign option low.

    IF lt_ancestor_range IS NOT INITIAL.
      CLEAR: lv_lines_already_read.
      WHILE lv_lines_already_read < lines( lt_ancestor_range ).
        CLEAR: lt_class_int_range_to_be_read.
        APPEND LINES OF lt_ancestor_range
          FROM lv_lines_already_read + 1 TO lv_lines_already_read + if_ngc_core_c=>gc_range_entries_max
          TO lt_class_int_range_to_be_read.
        ADD if_ngc_core_c=>gc_range_entries_max TO lv_lines_already_read.
        TEST-SEAM sel_cds_anc_classcharc_ext_key.
          SELECT
            @<ls_class_range_by_classtype>-key_date AS key_date,
            classsuperior~classinternalid,
            classsuperior~ancestorclassinternalid,
            classcharcbasic~charcinternalid,
            classsuperior~classtype,
            classsuperior~class,
            classsuperior~ancestorclass,
            CASE WHEN classsuperior~classinternalid = classcharcbasic~classinternalid
              THEN ' '
              ELSE 'X'
            END AS charcisinherited,
            characteristic~characteristic,
            classcharcbasic~overwrittencharcinternalid
*            classcharcbasic~clfnorganizationalarea
            FROM i_clfnclasssuperiorforkeydate( p_keydate = @<ls_class_range_by_classtype>-key_date )  AS classsuperior
               LEFT OUTER JOIN i_clfnclasscharcbasic   AS classcharcbasic
                 ON  classcharcbasic~classinternalid   = classsuperior~ancestorclassinternalid
                 AND ( ( classcharcbasic~validitystartdate <= @<ls_class_range_by_classtype>-key_date
                     AND classcharcbasic~validityenddate   >= @<ls_class_range_by_classtype>-key_date )
                    OR ( classcharcbasic~validitystartdate IS INITIAL " tolerate the case when KSML valid from date and valid to date are both initial
                     AND classcharcbasic~validityenddate   IS INITIAL ) )
                 AND classcharcbasic~isdeleted         =  ''
               LEFT OUTER JOIN i_clfncharcbasic        AS characteristic
                 ON  characteristic~charcinternalid    = classcharcbasic~charcinternalid
                 AND characteristic~validitystartdate  <= @<ls_class_range_by_classtype>-key_date
                 AND characteristic~validityenddate    >= @<ls_class_range_by_classtype>-key_date
                 AND characteristic~isdeleted          =  ''
               WHERE classsuperior~classinternalid IN @lt_class_int_range_to_be_read
                 AND classcharcbasic~charcinternalid <> ''
             APPENDING CORRESPONDING FIELDS OF TABLE @lt_classhiercharc_buffer.
        END-TEST-SEAM.
      ENDWHILE.
    ENDIF.

    LOOP AT lt_clfnclasshiercharcforkeydat ASSIGNING <ls_clfnclasshiercharc>.
      LOOP AT lt_classhiercharc_buffer INTO DATA(ls_classhiearcharc_buffer)
        WHERE ( classinternalid = <ls_clfnclasshiercharc>-ancestorclassinternalid
             OR classinternalid = <ls_clfnclasshiercharc>-classinternalid )
          AND charcinternalid <> ''
          AND key_date        = <ls_clfnclasshiercharc>-key_date.
        ls_classhiearcharc_buffer-ancestorclassinternalid = ls_classhiearcharc_buffer-classinternalid.
        ls_classhiearcharc_buffer-ancestorclass           = ls_classhiearcharc_buffer-class.
        ls_classhiearcharc_buffer-classinternalid         = <ls_clfnclasshiercharc>-classinternalid.
        ls_classhiearcharc_buffer-class                   = <ls_clfnclasshiercharc>-class.
        ls_classhiearcharc_buffer-key_date                = <ls_clfnclasshiercharc>-key_date.
        APPEND ls_classhiearcharc_buffer TO mt_clfnclasshiercharcforkeydat.
      ENDLOOP.
    ENDLOOP.

    LOOP AT mt_clfnclasshiercharcforkeydat ASSIGNING <ls_clfnclasshiercharc>
      WHERE charcisinherited = abap_true
        AND overwrittencharcinternalid IS NOT INITIAL
        AND key_date = <ls_class_range_by_classtype>-key_date.
      IF <ls_clfnclasshiercharc>-classinternalid = <ls_clfnclasshiercharc>-ancestorclassinternalid.
        CLEAR: <ls_clfnclasshiercharc>-overwrittencharcinternalid.
      ENDIF.
    ENDLOOP.

    SORT mt_clfnclasshiercharcforkeydat ASCENDING BY classinternalid ancestorclassinternalid charcinternalid.
    DELETE ADJACENT DUPLICATES FROM mt_clfnclasshiercharcforkeydat COMPARING classinternalid ancestorclassinternalid charcinternalid.

  ENDLOOP.

ENDMETHOD.