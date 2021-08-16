  METHOD zif_abapgit_object~changed_by.
* looks like "changed by user" is not stored in the database
    rv_user = c_user_unknown.
  ENDMETHOD.