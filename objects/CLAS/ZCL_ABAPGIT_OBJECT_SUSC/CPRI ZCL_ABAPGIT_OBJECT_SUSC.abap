  PRIVATE SECTION.

    METHODS delete_class
      IMPORTING
        !iv_auth_object_class TYPE tobc-oclss .
    METHODS put_delete_to_transport
      RAISING
        zcx_abapgit_exception .