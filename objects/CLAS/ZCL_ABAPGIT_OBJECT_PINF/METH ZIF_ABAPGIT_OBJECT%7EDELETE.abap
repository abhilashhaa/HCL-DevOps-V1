  METHOD zif_abapgit_object~delete.

    DATA: li_interface TYPE REF TO lif_package_interface_facade.

    li_interface = load( |{ ms_item-obj_name }| ).

* elements must be deleted before the package interface
* can be deleted
    delete_elements( li_interface ).

    li_interface->set_changeable( abap_true ).

    li_interface->delete( ).

    li_interface->save( ).

  ENDMETHOD.