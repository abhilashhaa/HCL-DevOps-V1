CLASS lcl_cls_hier_test_data DEFINITION.
  PUBLIC SECTION.
    CLASS-DATA:
      gt_simple_hierarchy_01       TYPE ngct_clhier_idx,
      gt_simple_hierarchy_01_kssk  TYPE tt_kssk,
      gt_simple_hierarchy_02       TYPE ngct_clhier_idx,
      gt_simple_hierarchy_02_kssk  TYPE tt_kssk,
      gt_complex_hierarchy_01      TYPE ngct_clhier_idx,
      gt_complex_hierarchy_01_kssk TYPE tt_kssk,
      gt_complex_hierarchy_02      TYPE ngct_clhier_idx,
      gt_complex_hierarchy_02_kssk TYPE tt_kssk,
      gt_complex_hierarchy_03      TYPE ngct_clhier_idx,
      gt_complex_hierarchy_03_kssk TYPE tt_kssk.

    CLASS-METHODS:
      class_constructor.
ENDCLASS.



CLASS ltd_cls_hier_dbaccess DEFINITION
  INHERITING FROM cl_ngc_core_cls_hier_dbaccess.
  PUBLIC SECTION.
    DATA:
      gt_clhier_idx TYPE ngct_clhier_idx,
      gt_kssk       TYPE tt_kssk.

    METHODS:
      if_ngc_core_cls_hier_dbaccess~get_ancestors REDEFINITION,
      if_ngc_core_cls_hier_dbaccess~get_descendants REDEFINITION,
      if_ngc_core_cls_hier_dbaccess~get_direct_relations REDEFINITION,
      if_ngc_core_cls_hier_dbaccess~get_relevant_relations REDEFINITION,
      if_ngc_core_cls_hier_dbaccess~update REDEFINITION.

    METHODS:
      clear.
ENDCLASS.



CLASS ltc_cls_hier_maint DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    CLASS-DATA:
      go_cls_hier_maint    TYPE REF TO if_ngc_core_cls_hier_maint,
      go_cls_hier_dbaccess TYPE REF TO ltd_cls_hier_dbaccess.

    CLASS-METHODS:
      class_setup.

    METHODS:
      setup,
      add_node_successful FOR TESTING,
      delete_node_successful FOR TESTING,
      update_node_datuv_change FOR TESTING,
      update_node FOR TESTING,
      insert_into_simple_graph_01 FOR TESTING,
      insert_into_simple_graph_02 FOR TESTING,
      insert_into_simple_graph_upd FOR TESTING,
      delete_from_simple_graph_del FOR TESTING,
      delete_from_simple_graph_add FOR TESTING,
      delete_from_simple_graph_upd FOR TESTING,
      insert_into_complex_graph_01 FOR TESTING,
      insert_into_complex_graph_02 FOR TESTING,
      insert_into_complex_graph_03 FOR TESTING,
      delete_from_complex_graph_01 FOR TESTING,
      delete_from_complex_graph_02 FOR TESTING,
      dateshift FOR TESTING,
      insert_whole_graph_01 FOR TESTING,
      insert_whole_graph_02 FOR TESTING,
      insert_delete_in_graph FOR TESTING.

    METHODS:
      add_relation
        IMPORTING
          it_relations TYPE tt_kssk,
      delete_relation
        IMPORTING
          it_relations TYPE tt_kssk,
      update_relation
        IMPORTING
          it_relations TYPE tt_kssk
          iv_new_date  TYPE datuv OPTIONAL.

    METHODS:
      check_relations_exists
        IMPORTING
          it_expected_relations   TYPE ngct_clhier_idx
          iv_expected_lines_count TYPE i,
      check_relations_not_exists
        IMPORTING
          it_expected_relations   TYPE ngct_clhier_idx
          iv_expected_lines_count TYPE i.
ENDCLASS.



CLASS lcl_cls_hier_test_data IMPLEMENTATION.
  METHOD class_constructor.
    gt_simple_hierarchy_01 = VALUE #(
      ( node = '0000000001' ancestor = '0000000001' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000002' ancestor = '0000000002' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000003' ancestor = '0000000003' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000004' ancestor = '0000000004' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )

      ( node = '0000000002' ancestor = '0000000001' datuv = '20020101' datub = '20031231' klart = '001' aennr = '20020101' )
      ( node = '0000000003' ancestor = '0000000002' datuv = '20030101' datub = '20041231' klart = '001' aennr = '20030101' )
      ( node = '0000000003' ancestor = '0000000001' datuv = '20030101' datub = '20031231' klart = '001' aennr = '20030101' ) ).

    gt_simple_hierarchy_01_kssk = VALUE #(
      ( objek = '0000000002' clint = '0000000001' adzhl = '0001'
        datuv = '20020101'   datub = '20031231'   klart = '001'
        aennr = '20020101'   mafid = 'K'          lkenz = ' '  )
      ( objek = '0000000002' clint = '0000000001' adzhl = '0002'
        datuv = '20040101'   datub = '99991231'   klart = '001'
        aennr = '20040101'   mafid = 'K'          lkenz = 'X'  )

      ( objek = '0000000003' clint = '0000000002' adzhl = '0001'
        datuv = '20030101'   datub = '20031231'   klart = '001'
        aennr = '20030101'   mafid = 'K'          lkenz = ' '  )
      ( objek = '0000000003' clint = '0000000002' adzhl = '0002'
        datuv = '20040101'   datub = '20041231'   klart = '001'
        aennr = '20040101'   mafid = 'K'          lkenz = ' '  )
      ( objek = '0000000003' clint = '0000000002' adzhl = '0003'
        datuv = '20050101'   datub = '99991231'   klart = '001'
        aennr = '20050101'   mafid = 'K'          lkenz = 'X'  )

      ( objek = '0000000004' clint = '0000000003' adzhl = '0001'
        datuv = '20020101'   datub = '99991231'   klart = '001'
        aennr = '20020101'   mafid = 'K'          lkenz = 'X'  )

      ( objek = '0000000002' clint = '0000000001' adzhl = '0001'
        datuv = '20020101'   datub = '99991231'   klart = '001'
        aennr = '20020101'   mafid = 'O'          lkenz = ' '  ) ).

    gt_simple_hierarchy_02 = VALUE #(
      ( node = '0000000001' ancestor = '0000000001' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000002' ancestor = '0000000002' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000003' ancestor = '0000000003' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )

      ( node = '0000000003' ancestor = '0000000002' datuv = '20020101' datub = '20031231' klart = '001' aennr = '20020101' ) ).

    gt_simple_hierarchy_02_kssk = VALUE #(
      ( objek = '0000000003' clint = '0000000002' adzhl = '0001'
        datuv = '20020101'   datub = '20031231'   klart = '001'
        aennr = '20020101'   mafid = 'K'          lkenz = ' '  )
      ( objek = '0000000003' clint = '0000000002' adzhl = '0002'
        datuv = '20040101'   datub = '99991231'   klart = '001'
        aennr = '20040101'   mafid = 'K'          lkenz = 'X'  ) ).

    gt_complex_hierarchy_01 = VALUE #(
      ( node = '0000000001' ancestor = '0000000001' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000002' ancestor = '0000000002' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000003' ancestor = '0000000003' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000004' ancestor = '0000000004' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )

      ( node = '0000000002' ancestor = '0000000001' datuv = '20010101' datub = '20031231' klart = '001' aennr = '20010101' )
      ( node = '0000000002' ancestor = '0000000001' datuv = '20050101' datub = '20071231' klart = '001' aennr = '20050101' )
      ( node = '0000000003' ancestor = '0000000001' datuv = '20020101' datub = '20041231' klart = '001' aennr = '20020101' )
      ( node = '0000000003' ancestor = '0000000001' datuv = '20060101' datub = '20081231' klart = '001' aennr = '20060101' )
      ( node = '0000000004' ancestor = '0000000002' datuv = '20030101' datub = '20041231' klart = '001' aennr = '20030101' )
      ( node = '0000000004' ancestor = '0000000002' datuv = '20060101' datub = '20061231' klart = '001' aennr = '20060101' )
      ( node = '0000000004' ancestor = '0000000001' datuv = '20030101' datub = '20031231' klart = '001' aennr = '20030101' )
      ( node = '0000000004' ancestor = '0000000001' datuv = '20060101' datub = '20061231' klart = '001' aennr = '20060101' ) ).

    gt_complex_hierarchy_01_kssk = VALUE #(
      ( objek = '0000000002' clint = '0000000001' adzhl = '0001'
        datuv = '20010101'   datub = '20031231'   klart = '001'
        aennr = '20010101'   mafid = 'K'          lkenz = ' '  )
      ( objek = '0000000002' clint = '0000000001' adzhl = '0002'
        datuv = '20040101'   datub = '20041231'   klart = '001'
        aennr = '20040101'   mafid = 'K'          lkenz = 'X'  )
      ( objek = '0000000002' clint = '0000000001' adzhl = '0003'
        datuv = '20050101'   datub = '20071231'   klart = '001'
        aennr = '20050101'   mafid = 'K'          lkenz = ' '  )
      ( objek = '0000000002' clint = '0000000001' adzhl = '0004'
        datuv = '20080101'   datub = '99991231'   klart = '001'
        aennr = '20080101'   mafid = 'K'          lkenz = 'X'  )

      ( objek = '0000000003' clint = '0000000001' adzhl = '0001'
        datuv = '20020101'   datub = '20041231'   klart = '001'
        aennr = '20020101'   mafid = 'K'          lkenz = ' '  )
      ( objek = '0000000003' clint = '0000000001' adzhl = '0002'
        datuv = '20050101'   datub = '20051231'   klart = '001'
        aennr = '20050101'   mafid = 'K'          lkenz = 'X'  )
      ( objek = '0000000003' clint = '0000000001' adzhl = '0003'
        datuv = '20060101'   datub = '20081231'   klart = '001'
        aennr = '20060101'   mafid = 'K'          lkenz = ' '  )
      ( objek = '0000000003' clint = '0000000001' adzhl = '0004'
        datuv = '20090101'   datub = '99991231'   klart = '001'
        aennr = '20090101'   mafid = 'K'          lkenz = 'X'  )

      ( objek = '0000000004' clint = '0000000002' adzhl = '0001'
        datuv = '20030101'   datub = '20041231'   klart = '001'
        aennr = '20030101'   mafid = 'K'          lkenz = ' '  )
      ( objek = '0000000004' clint = '0000000002' adzhl = '0002'
        datuv = '20050101'   datub = '20051231'   klart = '001'
        aennr = '20050101'   mafid = 'K'          lkenz = 'X'  )
      ( objek = '0000000004' clint = '0000000002' adzhl = '0003'
        datuv = '20060101'   datub = '20061231'   klart = '001'
        aennr = '20060101'   mafid = 'K'          lkenz = ' '  )
      ( objek = '0000000004' clint = '0000000002' adzhl = '0004'
        datuv = '20070101'   datub = '99991231'   klart = '001'
        aennr = '20070101'   mafid = 'K'          lkenz = 'X'  ) ).

    gt_complex_hierarchy_02 = VALUE #(
      ( node = '0000000001' ancestor = '0000000001' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000002' ancestor = '0000000002' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000003' ancestor = '0000000003' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000004' ancestor = '0000000004' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )

      ( node = '0000000002' ancestor = '0000000001' datuv = '20010101' datub = '20031231' klart = '001' aennr = '20010101' )
      ( node = '0000000002' ancestor = '0000000001' datuv = '20050101' datub = '20071231' klart = '001' aennr = '20050101' )
      ( node = '0000000003' ancestor = '0000000001' datuv = '20020101' datub = '20041231' klart = '001' aennr = '20020101' )
      ( node = '0000000003' ancestor = '0000000001' datuv = '20060101' datub = '20081231' klart = '001' aennr = '20060101' )
      ( node = '0000000004' ancestor = '0000000002' datuv = '20030101' datub = '20041231' klart = '001' aennr = '20030101' )
      ( node = '0000000004' ancestor = '0000000002' datuv = '20060101' datub = '20061231' klart = '001' aennr = '20060101' )
      ( node = '0000000004' ancestor = '0000000001' datuv = '20000101' datub = '20201231' klart = '001' aennr = '20000101' ) ).

    gt_complex_hierarchy_02_kssk = gt_complex_hierarchy_01_kssk.

    APPEND
      VALUE #( objek = '0000000004' clint = '0000000001' adzhl = '0001'
               datuv = '20000101'   datub = '20201231'   klart = '001'
               aennr = '20000101'   mafid = 'K'          lkenz = ' ' )
      TO gt_complex_hierarchy_02_kssk.

    gt_complex_hierarchy_03 = VALUE #(
      ( node = '0000000001' ancestor = '0000000001' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000002' ancestor = '0000000002' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000003' ancestor = '0000000003' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000004' ancestor = '0000000004' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )

      ( node = '0000000002' ancestor = '0000000001' datuv = '20010101' datub = '20011231' klart = '001' aennr = '20010101' )
      ( node = '0000000002' ancestor = '0000000001' datuv = '20030101' datub = '20031231' klart = '001' aennr = '20030101' )
      ( node = '0000000003' ancestor = '0000000001' datuv = '20010101' datub = '20031231' klart = '001' aennr = '20010101' )
      ( node = '0000000004' ancestor = '0000000002' datuv = '20010101' datub = '20011231' klart = '001' aennr = '20010101' )
      ( node = '0000000004' ancestor = '0000000002' datuv = '20030101' datub = '20031231' klart = '001' aennr = '20030101' )
      ( node = '0000000004' ancestor = '0000000003' datuv = '20010101' datub = '20031231' klart = '001' aennr = '20010101' )
      ( node = '0000000004' ancestor = '0000000001' datuv = '20000101' datub = '99991231' klart = '001' aennr = '20000101' ) ).

    gt_complex_hierarchy_03_kssk = VALUE #(
      ( objek = '0000000002' clint = '0000000001' adzhl = '0001'
        datuv = '20010101'   datub = '20011231'   klart = '001'
        aennr = '20010101'   mafid = 'K'          lkenz = ' '  )
      ( objek = '0000000002' clint = '0000000001' adzhl = '0002'
        datuv = '20020101'   datub = '20021231'   klart = '001'
        aennr = '20020101'   mafid = 'K'          lkenz = 'X'  )
      ( objek = '0000000002' clint = '0000000001' adzhl = '0003'
        datuv = '20030101'   datub = '20031231'   klart = '001'
        aennr = '20030101'   mafid = 'K'          lkenz = ' '  )
      ( objek = '0000000002' clint = '0000000001' adzhl = '0004'
        datuv = '20040101'   datub = '99991231'   klart = '001'
        aennr = '20040101'   mafid = 'K'          lkenz = 'X'  )

      ( objek = '0000000004' clint = '0000000002' adzhl = '0001'
        datuv = '20010101'   datub = '20011231'   klart = '001'
        aennr = '20010101'   mafid = 'K'          lkenz = ' '  )
      ( objek = '0000000004' clint = '0000000002' adzhl = '0002'
        datuv = '20020101'   datub = '20021231'   klart = '001'
        aennr = '20020101'   mafid = 'K'          lkenz = 'X'  )
      ( objek = '0000000004' clint = '0000000002' adzhl = '0003'
        datuv = '20030101'   datub = '20031231'   klart = '001'
        aennr = '20030101'   mafid = 'K'          lkenz = ' '  )
      ( objek = '0000000004' clint = '0000000002' adzhl = '0004'
        datuv = '20040101'   datub = '99991231'   klart = '001'
        aennr = '20040101'   mafid = 'K'          lkenz = 'X'  )

      ( objek = '0000000003' clint = '0000000001' adzhl = '0001'
        datuv = '20010101'   datub = '20031231'   klart = '001'
        aennr = '20010101'   mafid = 'K'          lkenz = ' '  )
      ( objek = '0000000003' clint = '0000000001' adzhl = '0002'
        datuv = '20040101'   datub = '99991231'   klart = '001'
        aennr = '20040101'   mafid = 'K'          lkenz = 'X'  )

      ( objek = '0000000004' clint = '0000000003' adzhl = '0001'
        datuv = '20010101'   datub = '20031231'   klart = '001'
        aennr = '20010101'   mafid = 'K'          lkenz = ' '  )
      ( objek = '0000000004' clint = '0000000003' adzhl = '0002'
        datuv = '20040101'   datub = '99991231'   klart = '001'
        aennr = '20040101'   mafid = 'K'          lkenz = 'X'  )

      ( objek = '0000000004' clint = '0000000001' adzhl = '0001'
        datuv = '20000101'   datub = '99991231'   klart = '001'
        aennr = '20000101'   mafid = 'K'          lkenz = ' '  ) ).
  ENDMETHOD.
ENDCLASS.



CLASS ltd_cls_hier_dbaccess IMPLEMENTATION.
  METHOD if_ngc_core_cls_hier_dbaccess~get_ancestors.
    DATA(lt_relations_kssk) = it_relations.
    DELETE lt_relations_kssk
      WHERE
        lkenz = 'X'.
    DATA(lt_relations) = convert_idx_from_kssk( it_relations = it_relations ).

    LOOP AT gt_clhier_idx INTO DATA(ls_existing_relation).
      LOOP AT lt_relations INTO DATA(ls_relation).
        IF ls_existing_relation-node  =  ls_relation-ancestor AND
           ls_existing_relation-node  <> ls_existing_relation-ancestor AND
           ls_existing_relation-datub >= ls_relation-datuv AND
           ls_existing_relation-datuv <= ls_relation-datub.
          READ TABLE rt_ancestors
            TRANSPORTING NO FIELDS
            WITH KEY
              node = ls_existing_relation-node
              ancestor = ls_existing_relation-ancestor
              datuv = ls_existing_relation-datuv.

          IF sy-subrc <> 0.
            APPEND ls_existing_relation TO rt_ancestors.
          ENDIF.
        ENDIF.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.

  METHOD if_ngc_core_cls_hier_dbaccess~get_descendants.
    DATA(lt_relations_kssk) = it_relations.
    DELETE lt_relations_kssk
      WHERE
        lkenz = 'X'.
    DATA(lt_relations) = convert_idx_from_kssk( it_relations = it_relations ).

    LOOP AT gt_clhier_idx INTO DATA(ls_existing_relation).
      LOOP AT lt_relations INTO DATA(ls_relation).
        IF ls_existing_relation-ancestor =  ls_relation-node AND
           ls_existing_relation-node     <> ls_existing_relation-ancestor AND
           ls_existing_relation-datub    >= ls_relation-datuv AND
           ls_existing_relation-datuv    <= ls_relation-datub.
          READ TABLE rt_descendants
            TRANSPORTING NO FIELDS
            WITH KEY
              node = ls_existing_relation-node
              ancestor = ls_existing_relation-ancestor
              datuv = ls_existing_relation-datuv.

          IF sy-subrc <> 0.
            APPEND ls_existing_relation TO rt_descendants.
          ENDIF.
        ENDIF.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.

  METHOD if_ngc_core_cls_hier_dbaccess~get_direct_relations.
    DATA:
      lt_direct_relations TYPE tt_kssk.

    DATA(lt_relations) = convert_kssk_from_idx( it_relations = it_relations ).

    LOOP AT gt_kssk INTO DATA(ls_existing_relation).
      LOOP AT lt_relations INTO DATA(ls_relation).
        IF ( ls_existing_relation-objek = ls_relation-objek OR
           ls_existing_relation-clint = ls_relation-clint ) AND
           ls_existing_relation-mafid = 'K' AND
           ls_existing_relation-lkenz = ' '.
          APPEND ls_existing_relation TO lt_direct_relations.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

    rt_relations = convert_idx_from_kssk( lt_direct_relations ).
  ENDMETHOD.

  METHOD if_ngc_core_cls_hier_dbaccess~get_relevant_relations.
    DATA(lt_relations) = convert_idx_from_kssk( it_relations = it_relations ).

    LOOP AT gt_clhier_idx INTO DATA(ls_existing_relation).
      LOOP AT lt_relations INTO DATA(ls_relation).
        IF ( ls_existing_relation-node   =  ls_relation-node OR
           ls_existing_relation-ancestor = ls_relation-ancestor ) AND
           ls_existing_relation-node <> ls_existing_relation-ancestor.
          APPEND ls_existing_relation TO rt_relations.
        ENDIF.
      ENDLOOP.

      LOOP AT it_descendants INTO ls_relation.
        IF ( ls_existing_relation-node   =  ls_relation-node OR
           ls_existing_relation-ancestor = ls_relation-ancestor ) AND
           ls_existing_relation-node <> ls_existing_relation-ancestor.
          APPEND ls_existing_relation TO rt_relations.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

    APPEND LINES OF it_ancestors TO rt_relations.
    APPEND LINES OF it_descendants TO rt_relations.
    SORT rt_relations. DELETE ADJACENT DUPLICATES FROM rt_relations. "2790065
  ENDMETHOD.

  METHOD if_ngc_core_cls_hier_dbaccess~update.
    LOOP AT it_insert INTO DATA(ls_relation).
      APPEND ls_relation TO gt_clhier_idx.
    ENDLOOP.

    LOOP AT it_update INTO ls_relation.
      LOOP AT gt_clhier_idx ASSIGNING FIELD-SYMBOL(<ls_existing_relation>).
        IF <ls_existing_relation>-node     = ls_relation-node AND
           <ls_existing_relation>-ancestor = ls_relation-ancestor AND
           <ls_existing_relation>-datuv    = ls_relation-datuv.
          <ls_existing_relation> = ls_relation.
          EXIT.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

    LOOP AT it_delete INTO ls_relation.
      DELETE gt_clhier_idx
        WHERE
          node     = ls_relation-node AND
          ancestor = ls_relation-ancestor AND
          datuv    = ls_relation-datuv.
    ENDLOOP.
  ENDMETHOD.

  METHOD clear.
    CLEAR: gt_clhier_idx, gt_kssk.
  ENDMETHOD.
ENDCLASS.



CLASS ltc_cls_hier_maint IMPLEMENTATION.
  METHOD class_setup.
    go_cls_hier_dbaccess = NEW #( ).
    go_cls_hier_maint = NEW cl_ngc_core_cls_hier_maint( go_cls_hier_dbaccess ).
  ENDMETHOD.

  METHOD setup.
    go_cls_hier_dbaccess->clear( ).
  ENDMETHOD.

  METHOD add_node_successful.
    DATA ls_node TYPE ngc_clhier_idx.

    ls_node = VALUE #( node = '0000000001' ancestor = '0000000001' datuv = '20000101' datub = '20201231' klart = '001' ).

    go_cls_hier_maint->add_node(
        iv_node  = ls_node-node
        iv_datuv = ls_node-datuv
        iv_datub = ls_node-datub
        iv_klart = ls_node-klart ).

    go_cls_hier_maint->update( ).

    cl_abap_unit_assert=>assert_equals(
      act = go_cls_hier_dbaccess->gt_clhier_idx[ 1 ]
      exp = ls_node
      msg = 'Node not stored as expected' ).
  ENDMETHOD.

  METHOD delete_node_successful.
    DATA ls_node TYPE ngc_clhier_idx.

    ls_node = VALUE #( node = '0000000001' ancestor = '0000000001' datuv = '20000101' datub = '20201231' klart = '001' ).

    APPEND ls_node TO go_cls_hier_dbaccess->gt_clhier_idx.

    go_cls_hier_maint->delete_node(
        iv_node  = ls_node-node
        iv_datuv = ls_node-datuv ).

    go_cls_hier_maint->update( ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( go_cls_hier_dbaccess->gt_clhier_idx )
      exp = 0
      msg = 'Node is not removed' ).
  ENDMETHOD.

  METHOD update_node_datuv_change.
    DATA ls_expected_node TYPE ngc_clhier_idx.

    SELECT SINGLE * FROM ngc_clhier_idx
      INTO @DATA(ls_node)
      WHERE
        node  = ngc_clhier_idx~ancestor AND
        datuv > '00010101' AND
        datub < '99981231'.

    IF sy-subrc = 0.
      ls_expected_node = VALUE #( node = ls_node-node ancestor = ls_node-ancestor datuv = '00010101' datub = '99981231' klart = ls_node-klart ).

      APPEND ls_node TO go_cls_hier_dbaccess->gt_clhier_idx.

      go_cls_hier_maint->update_node(
          iv_node  = ls_node-node
          iv_datuv = '00010101'
          iv_datub = '99981231' ).

      go_cls_hier_maint->update( ).

      cl_abap_unit_assert=>assert_equals(
        act = go_cls_hier_dbaccess->gt_clhier_idx[ 1 ]
        exp = ls_expected_node
        msg = 'Node not updated' ).
    ENDIF.
  ENDMETHOD.

  METHOD update_node.
    DATA ls_expected_node TYPE ngc_clhier_idx.

    SELECT SINGLE * FROM ngc_clhier_idx
      INTO @DATA(ls_node)
      WHERE
        node  = ngc_clhier_idx~ancestor AND
        datub < '99981231'.

    IF sy-subrc = 0.
      ls_expected_node = VALUE #( node = ls_node-node ancestor = ls_node-ancestor datuv = ls_node-datuv datub = '99981231' klart = ls_node-klart ).

      APPEND ls_node TO go_cls_hier_dbaccess->gt_clhier_idx.

      go_cls_hier_maint->update_node(
          iv_node  = ls_node-node
          iv_datuv = ls_node-datuv
          iv_datub = '99981231' ).

      go_cls_hier_maint->update( ).

      cl_abap_unit_assert=>assert_equals(
        act = go_cls_hier_dbaccess->gt_clhier_idx[ 1 ]
        exp = ls_expected_node
        msg = 'Node not updated' ).
    ENDIF.
  ENDMETHOD.

  METHOD insert_into_simple_graph_01.
    DATA:
      lt_relations          TYPE tt_kssk,
      lt_expected_relations TYPE ngct_clhier_idx.

    go_cls_hier_dbaccess->gt_clhier_idx = lcl_cls_hier_test_data=>gt_simple_hierarchy_01.
    go_cls_hier_dbaccess->gt_kssk       = lcl_cls_hier_test_data=>gt_simple_hierarchy_01_kssk.

    " Insert 2 new relations.
    lt_expected_relations = VALUE #(
      ( node = '0000000001' ancestor = '0000000001' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000002' ancestor = '0000000002' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000003' ancestor = '0000000003' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000004' ancestor = '0000000004' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )

      ( node = '0000000002' ancestor = '0000000001' datuv = '20020101' datub = '20031231' klart = '001' aennr = '20020101' )
      ( node = '0000000003' ancestor = '0000000002' datuv = '20030101' datub = '20041231' klart = '001' aennr = '20030101' )
      ( node = '0000000003' ancestor = '0000000001' datuv = '20030101' datub = '20031231' klart = '001' aennr = '20030101' )
      ( node = '0000000005' ancestor = '0000000003' datuv = '20000101' datub = '20051231' klart = '001' aennr = '20000101' )
      ( node = '0000000005' ancestor = '0000000002' datuv = '20030101' datub = '20041231' klart = '001' aennr = '20030101' )
      ( node = '0000000005' ancestor = '0000000001' datuv = '20030101' datub = '20031231' klart = '001' aennr = '20030101' )
      ( node = '0000000006' ancestor = '0000000003' datuv = '20040101' datub = '20051231' klart = '001' aennr = '20040101' )
      ( node = '0000000006' ancestor = '0000000002' datuv = '20040101' datub = '20041231' klart = '001' aennr = '20040101' ) ).

    lt_relations = VALUE #(
      ( objek = '0000000005' clint = '0000000003' adzhl = '0001'
        datuv = '20000101'   datub = '20051231'   klart = '001'
        aennr = '20000101'   mafid = 'K'          lkenz = ' ' )
      ( objek = '0000000006' clint = '0000000003' adzhl = '0001'
        datuv = '20040101'   datub = '20051231'   klart = '001'
        aennr = '20040101'   mafid = 'K'          lkenz = ' ' ) ).

    add_relation( lt_relations ).

    SORT lt_expected_relations BY node ancestor datuv.
    SORT go_cls_hier_dbaccess->gt_clhier_idx BY node ancestor datuv.

    cl_abap_unit_assert=>assert_equals(
        act = go_cls_hier_dbaccess->gt_clhier_idx
        exp = lt_expected_relations
        msg = 'Table not updated as expected' ).
  ENDMETHOD.

  METHOD insert_into_simple_graph_02.
    DATA:
      lt_relations          TYPE tt_kssk,
      lt_expected_relations TYPE ngct_clhier_idx.

    go_cls_hier_dbaccess->gt_clhier_idx = lcl_cls_hier_test_data=>gt_simple_hierarchy_02.
    go_cls_hier_dbaccess->gt_kssk       = lcl_cls_hier_test_data=>gt_simple_hierarchy_02_kssk.

    " Insert new relation.
    lt_expected_relations = VALUE #(
      ( node = '0000000001' ancestor = '0000000001' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000002' ancestor = '0000000002' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000003' ancestor = '0000000003' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )

      ( node = '0000000003' ancestor = '0000000002' datuv = '20020101' datub = '20031231' klart = '001' aennr = '20020101' )
      ( node = '0000000002' ancestor = '0000000001' datuv = '20010101' datub = '20021231' klart = '001' aennr = '20010101' )
      ( node = '0000000003' ancestor = '0000000001' datuv = '20020101' datub = '20021231' klart = '001' aennr = '20020101' ) ).

    lt_relations = VALUE #(
      ( objek = '0000000002' clint = '0000000001' adzhl = '0001'
        datuv = '20010101'   datub = '20021231'   klart = '001'
        aennr = '20010101'   mafid = 'K'          lkenz = ' ' ) ).

    add_relation( lt_relations ).

    SORT lt_expected_relations BY node ancestor datuv.
    SORT go_cls_hier_dbaccess->gt_clhier_idx BY node ancestor datuv.

    cl_abap_unit_assert=>assert_equals(
        act = go_cls_hier_dbaccess->gt_clhier_idx
        exp = lt_expected_relations
        msg = 'Table not updated as expected' ).
  ENDMETHOD.

  METHOD insert_into_simple_graph_upd.
    DATA:
      lt_relations          TYPE tt_kssk,
      lt_expected_relations TYPE ngct_clhier_idx.

    go_cls_hier_dbaccess->gt_clhier_idx = lcl_cls_hier_test_data=>gt_simple_hierarchy_01.
    go_cls_hier_dbaccess->gt_kssk       = lcl_cls_hier_test_data=>gt_simple_hierarchy_01_kssk.

    " Delete relation (using add).
    lt_expected_relations = VALUE #(
      ( node = '0000000001' ancestor = '0000000001' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000002' ancestor = '0000000002' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000003' ancestor = '0000000003' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000004' ancestor = '0000000004' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )

      ( node = '0000000002' ancestor = '0000000001' datuv = '20020101' datub = '20031231' klart = '001' aennr = '20020101' )
      ( node = '0000000003' ancestor = '0000000002' datuv = '20030101' datub = '20041231' klart = '001' aennr = '20030101' )
      ( node = '0000000003' ancestor = '0000000001' datuv = '20030101' datub = '20031231' klart = '001' aennr = '20030101' )
      ( node = '0000000004' ancestor = '0000000003' datuv = '20020101' datub = '99991231' klart = '001' aennr = '20020101' )
      ( node = '0000000004' ancestor = '0000000002' datuv = '20030101' datub = '20041231' klart = '001' aennr = '20030101' )
      ( node = '0000000004' ancestor = '0000000001' datuv = '20030101' datub = '20031231' klart = '001' aennr = '20030101' ) ).

    lt_relations = VALUE #(
      ( objek = '0000000004' clint = '0000000003' adzhl = '0001'
        datuv = '20020101'   datub = '99991231'   klart = '001'
        aennr = '20020101'   mafid = 'K'          lkenz = ' ' ) ).

    update_relation( lt_relations ).

    SORT lt_expected_relations BY node ancestor datuv.
    SORT go_cls_hier_dbaccess->gt_clhier_idx BY node ancestor datuv.

    cl_abap_unit_assert=>assert_equals(
        act = go_cls_hier_dbaccess->gt_clhier_idx
        exp = lt_expected_relations
        msg = 'Table not updated as expected' ).
  ENDMETHOD.

  METHOD delete_from_simple_graph_del.
    DATA:
      lt_relations          TYPE tt_kssk,
      lt_expected_relations TYPE ngct_clhier_idx.

    go_cls_hier_dbaccess->gt_clhier_idx = lcl_cls_hier_test_data=>gt_simple_hierarchy_01.
    go_cls_hier_dbaccess->gt_kssk       = lcl_cls_hier_test_data=>gt_simple_hierarchy_01_kssk.

    " Delete relation (using delete).
    lt_expected_relations = VALUE #(
      ( node = '0000000001' ancestor = '0000000001' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000002' ancestor = '0000000002' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000003' ancestor = '0000000003' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000004' ancestor = '0000000004' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )

      ( node = '0000000003' ancestor = '0000000002' datuv = '20030101' datub = '20041231' klart = '001' aennr = '20030101' ) ).

    lt_relations = VALUE #(
      ( objek = '0000000002' clint = '0000000001' adzhl = '0001'
        datuv = '20020101'   datub = '20031231'   klart = '001'
        aennr = '20020101'   mafid = 'K'          lkenz = ' ' ) ).

    delete_relation( lt_relations ).

    SORT lt_expected_relations BY node ancestor datuv.
    SORT go_cls_hier_dbaccess->gt_clhier_idx BY node ancestor datuv.

    cl_abap_unit_assert=>assert_equals(
        act = go_cls_hier_dbaccess->gt_clhier_idx
        exp = lt_expected_relations
        msg = 'Table not updated as expected' ).
  ENDMETHOD.

  METHOD delete_from_simple_graph_add.
    DATA:
      lt_relations          TYPE tt_kssk,
      lt_expected_relations TYPE ngct_clhier_idx.

    go_cls_hier_dbaccess->gt_clhier_idx = lcl_cls_hier_test_data=>gt_simple_hierarchy_01.
    go_cls_hier_dbaccess->gt_kssk       = lcl_cls_hier_test_data=>gt_simple_hierarchy_01_kssk.

    " Delete relation (using update).
    lt_expected_relations = VALUE #(
      ( node = '0000000001' ancestor = '0000000001' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000002' ancestor = '0000000002' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000003' ancestor = '0000000003' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000004' ancestor = '0000000004' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )

      ( node = '0000000002' ancestor = '0000000001' datuv = '20020101' datub = '20031231' klart = '001' aennr = '20020101' )
      ( node = '0000000003' ancestor = '0000000002' datuv = '20030101' datub = '20030531' klart = '001' aennr = '20030101' )
      ( node = '0000000003' ancestor = '0000000002' datuv = '20040101' datub = '20041231' klart = '001' aennr = '20040101' )
      ( node = '0000000003' ancestor = '0000000001' datuv = '20030101' datub = '20030531' klart = '001' aennr = '20030101' ) ).

    lt_relations = VALUE #(
      ( objek = '0000000003' clint = '0000000002' adzhl = '0003'
        datuv = '20030601'   datub = '20031231'   klart = '001'
        aennr = '20030601'   mafid = 'K'          lkenz = 'X' ) ).

    add_relation( lt_relations ).

    SORT lt_expected_relations BY node ancestor datuv.
    SORT go_cls_hier_dbaccess->gt_clhier_idx BY node ancestor datuv.

    cl_abap_unit_assert=>assert_equals(
        act = go_cls_hier_dbaccess->gt_clhier_idx
        exp = lt_expected_relations
        msg = 'Table not updated as expected' ).
  ENDMETHOD.

  METHOD delete_from_simple_graph_upd.
    DATA:
      lt_relations          TYPE tt_kssk,
      lt_expected_relations TYPE ngct_clhier_idx.

    go_cls_hier_dbaccess->gt_clhier_idx = lcl_cls_hier_test_data=>gt_simple_hierarchy_01.
    go_cls_hier_dbaccess->gt_kssk       = lcl_cls_hier_test_data=>gt_simple_hierarchy_01_kssk.

    " Delete relation (using add).
    lt_expected_relations = VALUE #(
      ( node = '0000000001' ancestor = '0000000001' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000002' ancestor = '0000000002' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000003' ancestor = '0000000003' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000004' ancestor = '0000000004' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )

      ( node = '0000000002' ancestor = '0000000001' datuv = '20020101' datub = '20031231' klart = '001' aennr = '20020101' )
      ( node = '0000000003' ancestor = '0000000002' datuv = '20030101' datub = '20031231' klart = '001' aennr = '20030101' )
      ( node = '0000000003' ancestor = '0000000001' datuv = '20030101' datub = '20031231' klart = '001' aennr = '20030101' ) ).

    lt_relations = VALUE #(
      ( objek = '0000000003' clint = '0000000002' adzhl = '0002'
        datuv = '20040101'   datub = '20041231'   klart = '001'
        aennr = '20040101'   mafid = 'K'          lkenz = 'X' ) ).

    update_relation( lt_relations ).

    SORT lt_expected_relations BY node ancestor datuv.
    SORT go_cls_hier_dbaccess->gt_clhier_idx BY node ancestor datuv.

    cl_abap_unit_assert=>assert_equals(
        act = go_cls_hier_dbaccess->gt_clhier_idx
        exp = lt_expected_relations
        msg = 'Table not updated as expected' ).
  ENDMETHOD.

  METHOD insert_into_complex_graph_01.
    DATA:
      lt_relations          TYPE tt_kssk,
      lt_expected_relations TYPE ngct_clhier_idx.

    go_cls_hier_dbaccess->gt_clhier_idx = lcl_cls_hier_test_data=>gt_complex_hierarchy_01.
    go_cls_hier_dbaccess->gt_kssk       = lcl_cls_hier_test_data=>gt_complex_hierarchy_01_kssk.

    " Insert new not overlapping interval.
    lt_expected_relations = VALUE #(
      ( node = '0000000001' ancestor = '0000000001' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000002' ancestor = '0000000002' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000003' ancestor = '0000000003' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000004' ancestor = '0000000004' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )

      ( node = '0000000002' ancestor = '0000000001' datuv = '20010101' datub = '20031231' klart = '001' aennr = '20010101' )
      ( node = '0000000002' ancestor = '0000000001' datuv = '20050101' datub = '20071231' klart = '001' aennr = '20050101' )
      ( node = '0000000003' ancestor = '0000000001' datuv = '20020101' datub = '20041231' klart = '001' aennr = '20020101' )
      ( node = '0000000003' ancestor = '0000000001' datuv = '20060101' datub = '20081231' klart = '001' aennr = '20060101' )
      ( node = '0000000004' ancestor = '0000000002' datuv = '20030101' datub = '20041231' klart = '001' aennr = '20030101' )
      ( node = '0000000004' ancestor = '0000000002' datuv = '20060101' datub = '20061231' klart = '001' aennr = '20060101' )
      ( node = '0000000004' ancestor = '0000000001' datuv = '20030101' datub = '20031231' klart = '001' aennr = '20030101' )
      ( node = '0000000004' ancestor = '0000000001' datuv = '20060101' datub = '20061231' klart = '001' aennr = '20060101' )
      ( node = '0000000004' ancestor = '0000000003' datuv = '20080101' datub = '20081231' klart = '001' aennr = '20080101' )
      ( node = '0000000004' ancestor = '0000000001' datuv = '20080101' datub = '20081231' klart = '001' aennr = '20080101' ) ).

    lt_relations = VALUE #(
      ( objek = '0000000004' clint = '0000000003' adzhl = '0001'
        datuv = '20080101'   datub = '20081231'   klart = '001'
        aennr = '20080101'   mafid = 'K'          lkenz = ' ' ) ).

    add_relation( lt_relations ).

    SORT lt_expected_relations BY node ancestor datuv.
    SORT go_cls_hier_dbaccess->gt_clhier_idx BY node ancestor datuv.

    cl_abap_unit_assert=>assert_equals(
        act = go_cls_hier_dbaccess->gt_clhier_idx
        exp = lt_expected_relations
        msg = 'Table not updated as expected' ).
  ENDMETHOD.

  METHOD insert_into_complex_graph_02.
    DATA:
      lt_relations          TYPE tt_kssk,
      lt_expected_relations TYPE ngct_clhier_idx.

    go_cls_hier_dbaccess->gt_clhier_idx = lcl_cls_hier_test_data=>gt_complex_hierarchy_01.
    go_cls_hier_dbaccess->gt_kssk       = lcl_cls_hier_test_data=>gt_complex_hierarchy_01_kssk.

    " Insert new overlapping interval.
    lt_expected_relations = VALUE #(
      ( node = '0000000001' ancestor = '0000000001' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000002' ancestor = '0000000002' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000003' ancestor = '0000000003' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000004' ancestor = '0000000004' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )

      ( node = '0000000002' ancestor = '0000000001' datuv = '20010101' datub = '20031231' klart = '001' aennr = '20010101' )
      ( node = '0000000002' ancestor = '0000000001' datuv = '20050101' datub = '20071231' klart = '001' aennr = '20050101' )
      ( node = '0000000003' ancestor = '0000000001' datuv = '20020101' datub = '20041231' klart = '001' aennr = '20020101' )
      ( node = '0000000003' ancestor = '0000000001' datuv = '20060101' datub = '20081231' klart = '001' aennr = '20060101' )
      ( node = '0000000004' ancestor = '0000000002' datuv = '20030101' datub = '20041231' klart = '001' aennr = '20030101' )
      ( node = '0000000004' ancestor = '0000000002' datuv = '20060101' datub = '20061231' klart = '001' aennr = '20060101' )
      ( node = '0000000004' ancestor = '0000000001' datuv = '20030101' datub = '20041231' klart = '001' aennr = '20030101' )
      ( node = '0000000004' ancestor = '0000000001' datuv = '20060101' datub = '20061231' klart = '001' aennr = '20060101' )
      ( node = '0000000004' ancestor = '0000000003' datuv = '20030101' datub = '20041231' klart = '001' aennr = '20030101' ) ).

    lt_relations = VALUE #(
      ( objek = '0000000004' clint = '0000000003' adzhl = '0002'
        datuv = '20030101'   datub = '20041231'   klart = '001'
        aennr = '20030101'   mafid = 'K'          lkenz = ' ' ) ).

    add_relation( lt_relations ).

    SORT lt_expected_relations BY node ancestor datuv.
    SORT go_cls_hier_dbaccess->gt_clhier_idx BY node ancestor datuv.

    cl_abap_unit_assert=>assert_equals(
        act = go_cls_hier_dbaccess->gt_clhier_idx
        exp = lt_expected_relations
        msg = 'Table not updated as expected' ).
  ENDMETHOD.

  METHOD insert_into_complex_graph_03.
    DATA:
      lt_relations          TYPE tt_kssk,
      lt_expected_relations TYPE ngct_clhier_idx.

    go_cls_hier_dbaccess->gt_clhier_idx = lcl_cls_hier_test_data=>gt_complex_hierarchy_01.
    go_cls_hier_dbaccess->gt_kssk       = lcl_cls_hier_test_data=>gt_complex_hierarchy_01_kssk.

    " Insert new overlapping interval.
    lt_expected_relations = VALUE #(
      ( node = '0000000001' ancestor = '0000000001' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000002' ancestor = '0000000002' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000003' ancestor = '0000000003' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000004' ancestor = '0000000004' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )

      ( node = '0000000002' ancestor = '0000000001' datuv = '20010101' datub = '20031231' klart = '001' aennr = '20010101' )
      ( node = '0000000002' ancestor = '0000000001' datuv = '20050101' datub = '20071231' klart = '001' aennr = '20050101' )
      ( node = '0000000003' ancestor = '0000000001' datuv = '20020101' datub = '20041231' klart = '001' aennr = '20020101' )
      ( node = '0000000003' ancestor = '0000000001' datuv = '20060101' datub = '20081231' klart = '001' aennr = '20060101' )
      ( node = '0000000004' ancestor = '0000000002' datuv = '20030101' datub = '20041231' klart = '001' aennr = '20030101' )
      ( node = '0000000004' ancestor = '0000000002' datuv = '20060101' datub = '20061231' klart = '001' aennr = '20060101' )
      ( node = '0000000004' ancestor = '0000000001' datuv = '20000101' datub = '20201231' klart = '001' aennr = '20000101' ) ).

    lt_relations = VALUE #(
      ( objek = '0000000004' clint = '0000000001' adzhl = '0002'
        datuv = '20000101'   datub = '20201231'   klart = '001'
        aennr = '20000101'   mafid = 'K'          lkenz = ' ' ) ).

    add_relation( lt_relations ).

    SORT lt_expected_relations BY node ancestor datuv.
    SORT go_cls_hier_dbaccess->gt_clhier_idx BY node ancestor datuv.

    cl_abap_unit_assert=>assert_equals(
        act = go_cls_hier_dbaccess->gt_clhier_idx
        exp = lt_expected_relations
        msg = 'Table not updated as expected' ).
  ENDMETHOD.

  METHOD delete_from_complex_graph_01.
    DATA:
      lt_relations          TYPE tt_kssk,
      lt_expected_relations TYPE ngct_clhier_idx.

    go_cls_hier_dbaccess->gt_clhier_idx = lcl_cls_hier_test_data=>gt_complex_hierarchy_02.
    go_cls_hier_dbaccess->gt_kssk       = lcl_cls_hier_test_data=>gt_complex_hierarchy_02_kssk.

    " Insert new overlapping interval.
    lt_expected_relations = VALUE #(
      ( node = '0000000001' ancestor = '0000000001' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000002' ancestor = '0000000002' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000003' ancestor = '0000000003' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000004' ancestor = '0000000004' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )

      ( node = '0000000002' ancestor = '0000000001' datuv = '20010101' datub = '20031231' klart = '001' aennr = '20010101' )
      ( node = '0000000002' ancestor = '0000000001' datuv = '20050101' datub = '20071231' klart = '001' aennr = '20050101' )
      ( node = '0000000003' ancestor = '0000000001' datuv = '20020101' datub = '20041231' klart = '001' aennr = '20020101' )
      ( node = '0000000003' ancestor = '0000000001' datuv = '20060101' datub = '20081231' klart = '001' aennr = '20060101' )
      ( node = '0000000004' ancestor = '0000000002' datuv = '20030101' datub = '20041231' klart = '001' aennr = '20030101' )
      ( node = '0000000004' ancestor = '0000000002' datuv = '20060101' datub = '20061231' klart = '001' aennr = '20060101' )
      ( node = '0000000004' ancestor = '0000000001' datuv = '20060101' datub = '20061231' klart = '001' aennr = '20060101' )
      ( node = '0000000004' ancestor = '0000000001' datuv = '20030101' datub = '20031231' klart = '001' aennr = '20030101' ) ).

    lt_relations = VALUE #(
      ( objek = '0000000004' clint = '0000000001' adzhl = '0001'
        datuv = '20000101'   datub = '20201231'   klart = '001'
        aennr = '20000101'   mafid = 'K'          lkenz = ' ' ) ).

    delete_relation( lt_relations ).

    SORT lt_expected_relations BY node ancestor datuv.
    SORT go_cls_hier_dbaccess->gt_clhier_idx BY node ancestor datuv.

    cl_abap_unit_assert=>assert_equals(
        act = go_cls_hier_dbaccess->gt_clhier_idx
        exp = lt_expected_relations
        msg = 'Table not updated as expected' ).
  ENDMETHOD.

  METHOD delete_from_complex_graph_02.
    DATA:
      lt_relations          TYPE tt_kssk,
      lt_expected_relations TYPE ngct_clhier_idx.

    go_cls_hier_dbaccess->gt_clhier_idx = lcl_cls_hier_test_data=>gt_complex_hierarchy_03.
    go_cls_hier_dbaccess->gt_kssk       = lcl_cls_hier_test_data=>gt_complex_hierarchy_03_kssk.

    " Insert new overlapping interval.
    lt_expected_relations = VALUE #(
      ( node = '0000000001' ancestor = '0000000001' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000002' ancestor = '0000000002' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000003' ancestor = '0000000003' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000004' ancestor = '0000000004' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )

      ( node = '0000000002' ancestor = '0000000001' datuv = '20010101' datub = '20011231' klart = '001' aennr = '20010101' )
      ( node = '0000000002' ancestor = '0000000001' datuv = '20030101' datub = '20031231' klart = '001' aennr = '20030101' )
      ( node = '0000000003' ancestor = '0000000001' datuv = '20010101' datub = '20031231' klart = '001' aennr = '20010101' )
      ( node = '0000000004' ancestor = '0000000002' datuv = '20010101' datub = '20011231' klart = '001' aennr = '20010101' )
      ( node = '0000000004' ancestor = '0000000002' datuv = '20030101' datub = '20031231' klart = '001' aennr = '20030101' )
      ( node = '0000000004' ancestor = '0000000003' datuv = '20010101' datub = '20031231' klart = '001' aennr = '20010101' )
      ( node = '0000000004' ancestor = '0000000001' datuv = '20010101' datub = '20031231' klart = '001' aennr = '20010101' ) ).

    lt_relations = VALUE #(
      ( objek = '0000000004' clint = '0000000001' adzhl = '0001'
        datuv = '20000101'   datub = '99991231'   klart = '001'
        aennr = '20000101'   mafid = 'K'          lkenz = ' ' ) ).

    delete_relation( lt_relations ).

    SORT lt_expected_relations BY node ancestor datuv.
    SORT go_cls_hier_dbaccess->gt_clhier_idx BY node ancestor datuv.

    cl_abap_unit_assert=>assert_equals(
        act = go_cls_hier_dbaccess->gt_clhier_idx
        exp = lt_expected_relations
        msg = 'Table not updated as expected' ).
  ENDMETHOD.

  METHOD dateshift.
    DATA:
      lt_relations          TYPE tt_kssk,
      lt_expected_relations TYPE ngct_clhier_idx.

    go_cls_hier_dbaccess->gt_clhier_idx = lcl_cls_hier_test_data=>gt_simple_hierarchy_01.
    go_cls_hier_dbaccess->gt_kssk       = lcl_cls_hier_test_data=>gt_simple_hierarchy_01_kssk.

    " Insert 2 new relations.
    lt_expected_relations = VALUE #(
      ( node = '0000000001' ancestor = '0000000001' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000002' ancestor = '0000000002' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000003' ancestor = '0000000003' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )
      ( node = '0000000004' ancestor = '0000000004' datuv = '20000101' datub = '99991231' klart = '001' aennr = '' )

      ( node = '0000000002' ancestor = '0000000001' datuv = '20020101' datub = '20031231' klart = '001' aennr = '20020101' )
      ( node = '0000000003' ancestor = '0000000002' datuv = '20030601' datub = '20041231' klart = '001' aennr = '20030101' )
      ( node = '0000000003' ancestor = '0000000001' datuv = '20030601' datub = '20031231' klart = '001' aennr = '20030101' ) ).

    lt_relations = VALUE #(
      ( objek = '0000000003' clint = '0000000002' adzhl = '0001'
        datuv = '20030101'   datub = '20041231'   klart = '001'
        aennr = '20030101'   mafid = 'K'          lkenz = ' ' ) ).

    update_relation( it_relations = lt_relations iv_new_date = '20030601' ).

    SORT lt_expected_relations BY node ancestor datuv.
    SORT go_cls_hier_dbaccess->gt_clhier_idx BY node ancestor datuv.

    cl_abap_unit_assert=>assert_equals(
        act = go_cls_hier_dbaccess->gt_clhier_idx
        exp = lt_expected_relations
        msg = 'Table not updated as expected' ).
  ENDMETHOD.

  METHOD insert_whole_graph_01.
    DATA:
      lt_relations          TYPE tt_kssk,
      lt_expected_relations TYPE ngct_clhier_idx.

    go_cls_hier_dbaccess->gt_kssk = lcl_cls_hier_test_data=>gt_complex_hierarchy_01_kssk.

    lt_expected_relations = VALUE #(
      ( node = '0000000002' ancestor = '0000000001' datuv = '20010101' datub = '20031231' klart = '001' aennr = '20010101' )
      ( node = '0000000002' ancestor = '0000000001' datuv = '20050101' datub = '20071231' klart = '001' aennr = '20050101' )
      ( node = '0000000003' ancestor = '0000000001' datuv = '20020101' datub = '20041231' klart = '001' aennr = '20020101' )
      ( node = '0000000003' ancestor = '0000000001' datuv = '20060101' datub = '20081231' klart = '001' aennr = '20060101' )
      ( node = '0000000004' ancestor = '0000000002' datuv = '20030101' datub = '20041231' klart = '001' aennr = '20030101' )
      ( node = '0000000004' ancestor = '0000000002' datuv = '20060101' datub = '20061231' klart = '001' aennr = '20060101' )
      ( node = '0000000004' ancestor = '0000000001' datuv = '20030101' datub = '20031231' klart = '001' aennr = '20030101' )
      ( node = '0000000004' ancestor = '0000000001' datuv = '20060101' datub = '20061231' klart = '001' aennr = '20060101' ) ).

    update_relation( lcl_cls_hier_test_data=>gt_complex_hierarchy_01_kssk ).

    SORT lt_expected_relations BY node ancestor datuv.
    SORT go_cls_hier_dbaccess->gt_clhier_idx BY node ancestor datuv.

    cl_abap_unit_assert=>assert_equals(
        act = go_cls_hier_dbaccess->gt_clhier_idx
        exp = lt_expected_relations
        msg = 'Table not updated as expected' ).
  ENDMETHOD.

  METHOD insert_whole_graph_02.
    DATA:
      lt_relations          TYPE tt_kssk,
      lt_expected_relations TYPE ngct_clhier_idx.

    go_cls_hier_dbaccess->gt_kssk = lcl_cls_hier_test_data=>gt_complex_hierarchy_01_kssk.

    DELETE go_cls_hier_dbaccess->gt_kssk
      WHERE
        lkenz = 'X'.

    lt_expected_relations = VALUE #(
      ( node = '0000000002' ancestor = '0000000001' datuv = '20010101' datub = '20031231' klart = '001' aennr = '20010101' )
      ( node = '0000000002' ancestor = '0000000001' datuv = '20050101' datub = '20071231' klart = '001' aennr = '20050101' )
      ( node = '0000000003' ancestor = '0000000001' datuv = '20020101' datub = '20041231' klart = '001' aennr = '20020101' )
      ( node = '0000000003' ancestor = '0000000001' datuv = '20060101' datub = '20081231' klart = '001' aennr = '20060101' )
      ( node = '0000000004' ancestor = '0000000002' datuv = '20030101' datub = '20041231' klart = '001' aennr = '20030101' )
      ( node = '0000000004' ancestor = '0000000002' datuv = '20060101' datub = '20061231' klart = '001' aennr = '20060101' )
      ( node = '0000000004' ancestor = '0000000001' datuv = '20030101' datub = '20031231' klart = '001' aennr = '20030101' )
      ( node = '0000000004' ancestor = '0000000001' datuv = '20060101' datub = '20061231' klart = '001' aennr = '20060101' ) ).

    update_relation( lcl_cls_hier_test_data=>gt_complex_hierarchy_01_kssk ).

    SORT lt_expected_relations BY node ancestor datuv.
    SORT go_cls_hier_dbaccess->gt_clhier_idx BY node ancestor datuv.

    cl_abap_unit_assert=>assert_equals(
        act = go_cls_hier_dbaccess->gt_clhier_idx
        exp = lt_expected_relations
        msg = 'Table not updated as expected' ).
  ENDMETHOD.

  METHOD insert_delete_in_graph.
    DATA:
      lt_relations          TYPE tt_kssk,
      lt_expected_relations TYPE ngct_clhier_idx.

    go_cls_hier_dbaccess->gt_kssk = VALUE #(
      ( objek = '0000000002' clint = '0000000001' adzhl = '0001'
        datuv = '20010101'   datub = '20021231'   klart = '001'
        aennr = '20010101'   mafid = 'K'          lkenz = ' ' )
      ( objek = '0000000002' clint = '0000000001' adzhl = '0002'
        datuv = '20030101'   datub = '99991231'   klart = '001'
        aennr = '20030101'   mafid = 'K'          lkenz = 'X' )

      ( objek = '0000000004' clint = '0000000003' adzhl = '0001'
        datuv = '20020101'   datub = '20031231'   klart = '001'
        aennr = '20020101'   mafid = 'K'          lkenz = ' ' )
      ( objek = '0000000004' clint = '0000000003' adzhl = '0002'
        datuv = '20040101'   datub = '99991231'   klart = '001'
        aennr = '20040101'   mafid = 'K'          lkenz = 'X' ) ).

    go_cls_hier_dbaccess->gt_clhier_idx = VALUE #(
      ( node = '0000000002' ancestor = '0000000001' datuv = '20010101' datub = '20021231' klart = '001' aennr = '20010101' )
      ( node = '0000000004' ancestor = '0000000003' datuv = '20020101' datub = '20031231' klart = '001' aennr = '20020101' ) ).

    lt_relations = VALUE #(
      ( objek = '0000000003' clint = '0000000001' adzhl = '0001'
        datuv = '20020101'   datub = '20031231'   klart = '001'
        aennr = '20020101'   mafid = 'K'          lkenz = ' ' )
      ( objek = '0000000002' clint = '0000000001' adzhl = '0001'
        datuv = '20010101'   datub = '20021231'   klart = '001'
        aennr = '20010101'   mafid = 'K'          lkenz = 'X' )
      ( objek = '0000000004' clint = '0000000003' adzhl = '0001'
        datuv = '20020101'   datub = '20031231'   klart = '001'
        aennr = '20020101'   mafid = 'K'          lkenz = 'X' )
      ( objek = '0000000004' clint = '0000000002' adzhl = '0001'
        datuv = '20010101'   datub = '20021231'   klart = '001'
        aennr = '20010101'   mafid = 'K'          lkenz = ' ' ) ).

    lt_expected_relations = VALUE #(
      ( node = '0000000003' ancestor = '0000000001' datuv = '20020101' datub = '20031231' klart = '001' aennr = '20020101' )
      ( node = '0000000004' ancestor = '0000000002' datuv = '20010101' datub = '20021231' klart = '001' aennr = '20010101' ) ).

    update_relation( lt_relations ).

    SORT lt_expected_relations BY node ancestor datuv.
    SORT go_cls_hier_dbaccess->gt_clhier_idx BY node ancestor datuv.

    cl_abap_unit_assert=>assert_equals(
        act = go_cls_hier_dbaccess->gt_clhier_idx
        exp = lt_expected_relations
        msg = 'Table not updated as expected' ).
  ENDMETHOD.


  METHOD add_relation.
    LOOP AT it_relations INTO DATA(ls_relation).
      LOOP AT go_cls_hier_dbaccess->gt_kssk ASSIGNING FIELD-SYMBOL(<ls_existing_relation>).
        IF <ls_existing_relation>-objek    =  ls_relation-objek AND
           <ls_existing_relation>-clint    =  ls_relation-clint AND
           <ls_existing_relation>-datuv    <= ls_relation-datub AND
           <ls_existing_relation>-datub    >= ls_relation-datuv.
          <ls_existing_relation>-datub = ls_relation-datuv - 1.
          EXIT.
        ENDIF.
      ENDLOOP.

      APPEND ls_relation TO go_cls_hier_dbaccess->gt_kssk.
    ENDLOOP.

    go_cls_hier_maint->update_relations(
        it_relations = it_relations
        iv_action    = 'I' ).

    go_cls_hier_maint->update( ).
  ENDMETHOD.

  METHOD delete_relation.
    LOOP AT it_relations INTO DATA(ls_relation).
      READ TABLE go_cls_hier_dbaccess->gt_kssk
        ASSIGNING FIELD-SYMBOL(<ls_kssk_relation>)
        WITH KEY
          objek = ls_relation-objek
          clint = ls_relation-clint
          adzhl = ls_relation-adzhl.

      IF sy-subrc = 0.
        <ls_kssk_relation>-lkenz = 'X'.
      ENDIF.
    ENDLOOP.

    go_cls_hier_maint->update_relations(
        it_relations = it_relations
        iv_action    = 'D' ).

    go_cls_hier_maint->update( ).
  ENDMETHOD.

  METHOD update_relation.
    LOOP AT it_relations INTO DATA(ls_relation).
      READ TABLE go_cls_hier_dbaccess->gt_kssk
        ASSIGNING FIELD-SYMBOL(<ls_kssk_relation>)
        WITH KEY
          objek = ls_relation-objek
          clint = ls_relation-clint
          adzhl = ls_relation-adzhl.

      IF sy-subrc = 0.
        <ls_kssk_relation>-lkenz = ls_relation-lkenz.
      ENDIF.
    ENDLOOP.

    go_cls_hier_maint->update_relations(
        it_relations = it_relations
        iv_action    = 'U'
        iv_new_date  = iv_new_date ).

    go_cls_hier_maint->update( ).
  ENDMETHOD.

  METHOD check_relations_exists.
    DATA ls_relation TYPE ngc_clhier_idx.

    LOOP AT it_expected_relations INTO DATA(ls_expected_relation).
      READ TABLE go_cls_hier_dbaccess->gt_clhier_idx
        INTO ls_relation
        WITH KEY
          node     = ls_expected_relation-node
          ancestor = ls_expected_relation-ancestor
          datuv    = ls_expected_relation-datuv
          datub    = ls_expected_relation-datub
          klart    = ls_expected_relation-klart
          aennr    = ls_expected_relation-aennr.

      cl_abap_unit_assert=>assert_not_initial(
        act = ls_relation
        msg = 'Relation not inserted as expected' ).

      CLEAR ls_relation.
    ENDLOOP.

    IF iv_expected_lines_count IS NOT INITIAL.
      cl_abap_unit_assert=>assert_equals(
        act = lines( go_cls_hier_dbaccess->gt_clhier_idx )
        exp = iv_expected_lines_count
        msg = 'Not the expected amount of lines' ).
    ENDIF.
  ENDMETHOD.

  METHOD check_relations_not_exists.
    DATA ls_relation TYPE ngc_clhier_idx.

    LOOP AT it_expected_relations INTO DATA(ls_expected_relation).
      READ TABLE go_cls_hier_dbaccess->gt_clhier_idx
        INTO ls_relation
        WITH KEY
          node     = ls_expected_relation-node
          ancestor = ls_expected_relation-ancestor
          datuv    = ls_expected_relation-datuv.

      cl_abap_unit_assert=>assert_initial(
        act = ls_relation
        msg = 'Relation not removed as expected' ).

      CLEAR ls_relation.
    ENDLOOP.

    IF iv_expected_lines_count IS NOT INITIAL.
      cl_abap_unit_assert=>assert_equals(
        act = lines( go_cls_hier_dbaccess->gt_clhier_idx )
        exp = iv_expected_lines_count
        msg = 'Not the expected amount of lines' ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.