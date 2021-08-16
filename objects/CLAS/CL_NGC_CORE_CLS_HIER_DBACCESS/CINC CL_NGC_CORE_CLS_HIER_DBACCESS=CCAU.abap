CLASS ltc_cls_hier_dbaccess DEFINITION FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT.
  PRIVATE SECTION.

  CLASS-DATA:
    go_cls_hier_dbaccess TYPE REF TO cl_ngc_core_cls_hier_dbaccess.

  CLASS-METHODS:
    class_setup.

  METHODS:
    get_ancestors_initial FOR TESTING,
    get_descendants_initial FOR TESTING,
    get_direct_relations_initial FOR TESTING,
    get_relevant_relations_initial FOR TESTING.
ENDCLASS.

CLASS ltc_cls_hier_dbaccess IMPLEMENTATION.
  METHOD class_setup.
    go_cls_hier_dbaccess = NEW #( ).
  ENDMETHOD.

  METHOD get_ancestors_initial.
    DATA lt_kssk_relations TYPE tt_kssk.

    DATA(lt_relations) = go_cls_hier_dbaccess->if_ngc_core_cls_hier_dbaccess~get_ancestors( lt_kssk_relations ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_relations
      msg = 'Result table should be initial' ).
  ENDMETHOD.

  METHOD get_descendants_initial.
    DATA lt_kssk_relations TYPE tt_kssk.

    DATA(lt_relations) = go_cls_hier_dbaccess->if_ngc_core_cls_hier_dbaccess~get_descendants( lt_kssk_relations ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_relations
      msg = 'Result table should be initial' ).
  ENDMETHOD.

  METHOD get_direct_relations_initial.
    DATA lt_relations TYPE ngct_clhier_idx.

    DATA(lt_direct_relations) = go_cls_hier_dbaccess->if_ngc_core_cls_hier_dbaccess~get_direct_relations( lt_relations ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_direct_relations
      msg = 'Result table should be initial' ).
  ENDMETHOD.

  METHOD get_relevant_relations_initial.
    DATA:
      lt_relations      TYPE ngct_clhier_idx,
      lt_kssk_relations TYPE tt_kssk.

    DATA(lt_relevant_relations) = go_cls_hier_dbaccess->if_ngc_core_cls_hier_dbaccess~get_relevant_relations(
      it_relations   = lt_kssk_relations
      it_descendants = lt_relations
      it_ancestors   = lt_relations ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_relevant_relations
      msg = 'Result table should be initial' ).
  ENDMETHOD.
ENDCLASS.