FUNCTION ngc_core_cls_hier_generate.
*"----------------------------------------------------------------------
*"*"Update Function Module:
*"
*"*"Local Interface:
*"  TABLES
*"      LT_CLINT TYPE  TT_CLINT_RANGE
*"----------------------------------------------------------------------

  DATA:
    lt_kssk        TYPE tt_kssk,
    lo_cls_hier_db TYPE REF TO cl_ngc_core_cls_hier_dbaccess,
    lo_cls_hier    TYPE REF TO if_ngc_core_cls_hier_maint.

  " Delete data first.
  DELETE FROM ngc_clhier_idx
    WHERE
      node     IN lt_clint OR
      ancestor IN lt_clint.

  " Create Graph Index maintenance class.
  lo_cls_hier_db = NEW #( ).
  lo_cls_hier    = NEW cl_ngc_core_cls_hier_maint( lo_cls_hier_db ).

  " Collect relevant classes.
  SELECT * FROM klah
    INTO TABLE @DATA(lt_klah)
    WHERE
      clint IN @lt_clint.

  " Add class nodes to graph index.
  LOOP AT lt_klah ASSIGNING FIELD-SYMBOL(<ls_klah>).
    IF <ls_klah>-bisdt IS INITIAL.
      <ls_klah>-bisdt = '99991231'.
    ENDIF.

    lo_cls_hier->add_node(
      iv_klart = <ls_klah>-klart
      iv_node  = <ls_klah>-clint
      iv_datuv = <ls_klah>-vondt
      iv_datub = <ls_klah>-bisdt ).
  ENDLOOP.

  CLEAR lt_klah[].                                              "2790065

  " Get relevant relations.
  SELECT * FROM kssk
    INTO CORRESPONDING FIELDS OF TABLE @lt_kssk
    WHERE
      ( clint IN @lt_clint OR
        objek IN @lt_clint ) AND
      lkenz = ' ' AND
      mafid = 'K'.

  " Add new relations to graph index.
  lo_cls_hier->update_relations(
      it_relations = lt_kssk
      iv_action    = 'I').

  lo_cls_hier->update( ).
ENDFUNCTION.