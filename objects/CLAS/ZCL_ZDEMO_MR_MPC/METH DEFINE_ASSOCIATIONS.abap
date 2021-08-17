  method DEFINE_ASSOCIATIONS.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS         &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL  &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                   &*
*&                                                                     &*
*&---------------------------------------------------------------------*




data:
lo_annotation     type ref to /iwbep/if_mgw_odata_annotation,                   "#EC NEEDED
lo_entity_type    type ref to /iwbep/if_mgw_odata_entity_typ,                   "#EC NEEDED
lo_association    type ref to /iwbep/if_mgw_odata_assoc,                        "#EC NEEDED
lo_ref_constraint type ref to /iwbep/if_mgw_odata_ref_constr,                   "#EC NEEDED
lo_assoc_set      type ref to /iwbep/if_mgw_odata_assoc_set,                    "#EC NEEDED
lo_nav_property   type ref to /iwbep/if_mgw_odata_nav_prop.                     "#EC NEEDED

***********************************************************************************************************************************
*   ASSOCIATIONS
***********************************************************************************************************************************

 lo_association = model->create_association(
                            iv_association_name = 'HeadToItem' "#EC NOTEXT
                            iv_left_type        = 'POHeader' "#EC NOTEXT
                            iv_right_type       = 'POlineitem' "#EC NOTEXT
                            iv_right_card       = 'N' "#EC NOTEXT
                            iv_left_card        = '1'  "#EC NOTEXT
                            iv_def_assoc_set    = abap_false ). "#EC NOTEXT
* Referential constraint for association - HeadToItem
lo_ref_constraint = lo_association->create_ref_constraint( ).
lo_ref_constraint->add_property( iv_principal_property = 'Ebeln'   iv_dependent_property = 'Ebeln' ). "#EC NOTEXT
lo_ref_constraint->add_property( iv_principal_property = 'Bukrs'   iv_dependent_property = 'Bukrs' ). "#EC NOTEXT
lo_assoc_set = model->create_association_set( iv_association_set_name  = 'HeadToItemSet'                         "#EC NOTEXT
                                              iv_left_entity_set_name  = 'POHeaderSet'              "#EC NOTEXT
                                              iv_right_entity_set_name = 'POlineitemSet'             "#EC NOTEXT
                                              iv_association_name      = 'HeadToItem' ).                                 "#EC NOTEXT


***********************************************************************************************************************************
*   NAVIGATION PROPERTIES
***********************************************************************************************************************************

* Navigation Properties for entity - POHeader
lo_entity_type = model->get_entity_type( iv_entity_name = 'POHeader' ). "#EC NOTEXT
lo_nav_property = lo_entity_type->create_navigation_property( iv_property_name  = 'HeadToItem' "#EC NOTEXT
                                                              iv_abap_fieldname = 'HEADTOITEM' "#EC NOTEXT
                                                              iv_association_name = 'HeadToItem' ). "#EC NOTEXT
  endmethod.