  METHOD version_to_numeric.

    DATA: lv_major   TYPE n LENGTH 4,
          lv_minor   TYPE n LENGTH 4,
          lv_release TYPE n LENGTH 4.

    SPLIT iv_version AT '.' INTO lv_major lv_minor lv_release.

    " Calculated value of version number, empty version will become 0 which is OK
    rv_version = lv_major * 1000000 + lv_minor * 1000 + lv_release.

  ENDMETHOD.