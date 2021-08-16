  PROTECTED SECTION.

    TYPES:
      BEGIN OF ty_scp1,
        scprattr TYPE scprattr,
        scprtext TYPE STANDARD TABLE OF scprtext WITH DEFAULT KEY,
        scprvals TYPE STANDARD TABLE OF scprvals WITH DEFAULT KEY,
        scprvall TYPE STANDARD TABLE OF scprvall WITH DEFAULT KEY,
        scprreca TYPE STANDARD TABLE OF scprreca WITH DEFAULT KEY,
        scprfldv TYPE STANDARD TABLE OF scprfldv WITH DEFAULT KEY,
        subprofs TYPE STANDARD TABLE OF scprpprl WITH DEFAULT KEY,
      END OF ty_scp1 .

    METHODS dequeue .
    METHODS enqueue
      RAISING
        zcx_abapgit_exception .
    METHODS save
      IMPORTING
        !is_scp1 TYPE ty_scp1
      RAISING
        zcx_abapgit_exception .
    METHODS save_hier
      IMPORTING
        !is_scp1 TYPE ty_scp1
      RAISING
        zcx_abapgit_exception .
    METHODS adjust_inbound
      CHANGING
        !cs_scp1 TYPE ty_scp1 .
    METHODS adjust_outbound
      CHANGING
        !cs_scp1 TYPE ty_scp1 .
    METHODS load
      CHANGING
        !cs_scp1 TYPE ty_scp1 .
    METHODS load_hier
      CHANGING
        !cs_scp1 TYPE ty_scp1 .
    METHODS call_delete_fms
      IMPORTING
        !iv_profile_id TYPE scpr_id
      RAISING
        zcx_abapgit_exception .