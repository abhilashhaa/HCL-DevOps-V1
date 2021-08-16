  METHOD zif_abapgit_object~delete.

    " FM SUSR_DELETE_OBJECT calls the UI. Therefore we reimplement it here.
    " As the class CL_SUSO_GEN isn't present in 702, we call dynamically and
    " skip the pre checks on 702 system. That seems ok.

    pre_check( ).

    delete_documentation( ).

    DELETE FROM tobj  WHERE objct  = mv_objectname.
    DELETE FROM tobjt WHERE object = mv_objectname.
    DELETE FROM tactz WHERE brobj  = mv_objectname.

    CALL FUNCTION 'SUPV_DELETE_OBJECT_ASSIGNMENTS'
      EXPORTING
        object_name  = mv_objectname
        all_releases = abap_true.

    CALL FUNCTION 'RS_TREE_OBJECT_PLACEMENT'
      EXPORTING
        object    = mv_objectname
        type      = 'SUSO'
        operation = 'DELETE'.

  ENDMETHOD.