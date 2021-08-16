*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS ltd_runtime_for_inspector DEFINITION INHERITING FROM cl_lo_vchclf_vch_rt FINAL FOR TESTING.

  PUBLIC SECTION.
    CONSTANTS:
      gc_context_id_bom_exc TYPE if_lo_vchclf_types=>context_id VALUE 'BOM_EXCEPTION',
      gc_simulation_id      TYPE string VALUE 'TESTSIMULATION_ID',
      gc_configuration_date TYPE d VALUE '20101220',
      gc_bom_component_id   TYPE string VALUE '9_9',
      gc_knobj              TYPE knobj VALUE '1234',
      gc_knnum              TYPE knnum VALUE '9876'.

    METHODS constructor IMPORTING iv_context_id	TYPE vchclf_context_id.
    METHODS get_configuration_context REDEFINITION.
    METHODS get_bom_node REDEFINITION.

  PRIVATE SECTION.
    DATA:
      mo_context_id TYPE if_lo_vchclf_types=>context_id.
ENDCLASS.

CLASS ltd_runtime_for_inspector IMPLEMENTATION.
  METHOD constructor.
    super->constructor( ).
    mo_context_id = iv_context_id.
  ENDMETHOD.

  METHOD get_configuration_context.
    es_entity = VALUE #( object_key = gc_simulation_id configuration_date = gc_configuration_date ).
  ENDMETHOD.

  METHOD get_bom_node.
    CLEAR: et_entityset, et_messages.
    et_entityset = VALUE #( ( component_id = gc_bom_component_id dep_obj_number = gc_knobj ) ).
  ENDMETHOD.
ENDCLASS.