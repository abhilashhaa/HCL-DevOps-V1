*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_ngc_xpra_cls_hier_dbaccess DEFINITION.

  PUBLIC SECTION.

    INTERFACES if_ngc_core_cls_hier_dbaccess.

    METHODS constructor
      IMPORTING
        !iv_mandt TYPE mandt.

  PROTECTED SECTION.

    DATA mv_mandt TYPE mandt.

ENDCLASS.

CLASS lcl_ngc_xpra_cls_hier_dbaccess IMPLEMENTATION.

  METHOD constructor.
    mv_mandt = iv_mandt.
  ENDMETHOD.

  METHOD if_ngc_core_cls_hier_dbaccess~get_ancestors.
    CLEAR: rt_ancestors.
  ENDMETHOD.

  METHOD if_ngc_core_cls_hier_dbaccess~get_descendants.
    CLEAR: rt_descendants.
  ENDMETHOD.

  METHOD if_ngc_core_cls_hier_dbaccess~get_direct_relations.
    CLEAR: rt_relations.
  ENDMETHOD.

  METHOD if_ngc_core_cls_hier_dbaccess~get_relevant_relations.
    CLEAR: rt_relations.
  ENDMETHOD.

  METHOD if_ngc_core_cls_hier_dbaccess~update.
    DELETE ngc_clhier_idx CLIENT SPECIFIED FROM TABLE @it_delete.
    INSERT ngc_clhier_idx CLIENT SPECIFIED FROM TABLE @it_insert.
    UPDATE ngc_clhier_idx CLIENT SPECIFIED FROM TABLE @it_update.
  ENDMETHOD.
ENDCLASS.