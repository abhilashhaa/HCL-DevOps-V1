  METHOD create.
    DATA:
      lv_branch_name     TYPE string,
      ls_comment         TYPE zif_abapgit_definitions=>ty_comment,
      lo_stage           TYPE REF TO zcl_abapgit_stage,
      ls_stage_objects   TYPE zif_abapgit_definitions=>ty_stage_files,
      lt_object_statuses TYPE zif_abapgit_definitions=>ty_results_tt.

    lv_branch_name = zcl_abapgit_git_branch_list=>complete_heads_branch_name(
        zcl_abapgit_git_branch_list=>normalize_branch_name( is_transport_to_branch-branch_name ) ).

    io_repository->create_branch( lv_branch_name ).

    CREATE OBJECT lo_stage.

    ls_stage_objects = zcl_abapgit_factory=>get_stage_logic( )->get( io_repository ).

    lt_object_statuses = io_repository->status( ).

    stage_transport_objects(
       it_transport_objects = it_transport_objects
       io_stage             = lo_stage
       is_stage_objects     = ls_stage_objects
       it_object_statuses   = lt_object_statuses ).

    ls_comment = generate_commit_message( is_transport_to_branch ).

    io_repository->push( is_comment = ls_comment
                         io_stage   = lo_stage ).
  ENDMETHOD.