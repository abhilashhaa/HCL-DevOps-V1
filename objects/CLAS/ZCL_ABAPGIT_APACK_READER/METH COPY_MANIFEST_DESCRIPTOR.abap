  METHOD copy_manifest_descriptor.

    DATA: ls_my_manifest_wo_deps TYPE zif_abapgit_apack_definitions=>ty_descriptor_wo_dependencies,
          ls_my_dependency       TYPE zif_abapgit_apack_definitions=>ty_dependency,
          ls_descriptor          TYPE zif_abapgit_apack_definitions=>ty_descriptor.

    FIELD-SYMBOLS: <lg_descriptor>   TYPE any,
                   <lt_dependencies> TYPE ANY TABLE,
                   <lg_dependency>   TYPE any.

    ASSIGN io_manifest_provider->('ZIF_APACK_MANIFEST~DESCRIPTOR') TO <lg_descriptor>.
    IF <lg_descriptor> IS NOT ASSIGNED.
      ASSIGN io_manifest_provider->('IF_APACK_MANIFEST~DESCRIPTOR') TO <lg_descriptor>.
    ENDIF.
    IF <lg_descriptor> IS ASSIGNED.
      " A little more complex than a normal MOVE-CORRSPONDING
      " to avoid dumps in case of future updates to the dependencies table structure
      ASSIGN COMPONENT 'DEPENDENCIES' OF STRUCTURE <lg_descriptor> TO <lt_dependencies>.
      IF <lt_dependencies> IS ASSIGNED.
        LOOP AT <lt_dependencies> ASSIGNING <lg_dependency>.
          MOVE-CORRESPONDING <lg_dependency> TO ls_my_dependency.
          INSERT ls_my_dependency INTO TABLE ls_descriptor-dependencies.
        ENDLOOP.
        MOVE-CORRESPONDING <lg_descriptor> TO ls_my_manifest_wo_deps.
        MOVE-CORRESPONDING ls_my_manifest_wo_deps TO ls_descriptor.
      ENDIF.
    ENDIF.

    set_manifest_descriptor( ls_descriptor ).

  ENDMETHOD.