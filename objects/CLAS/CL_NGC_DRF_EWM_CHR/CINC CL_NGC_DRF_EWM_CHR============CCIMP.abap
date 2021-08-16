*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_db_access DEFINITION FINAL.
  PUBLIC SECTION.
    INTERFACES lif_db_access.
ENDCLASS.

CLASS lcl_db_access IMPLEMENTATION.
  METHOD lif_db_access~get_chr_data.
    SELECT *
      FROM cabn
      APPENDING TABLE et_cabn
      WHERE atnam = iv_characteristic_name
        AND aennr = iv_change_number.
    SELECT cabnt~*
      FROM ( cabn INNER JOIN cabnt ON cabn~atinn = cabnt~atinn AND cabn~adzhl = cabnt~adzhl )
      APPENDING CORRESPONDING FIELDS OF TABLE @et_cabnt
      WHERE cabn~atnam = @iv_characteristic_name
        AND cabn~aennr = @iv_change_number.
    SELECT cawn~*
      FROM ( cabn INNER JOIN cawn ON cabn~atinn = cawn~atinn AND cabn~adzhl = cawn~adzhl )
      APPENDING CORRESPONDING FIELDS OF TABLE @et_cawn
      WHERE cabn~atnam = @iv_characteristic_name
        AND cabn~aennr = @iv_change_number.
    SELECT cawnt~*
      FROM ( cabn INNER JOIN cawnt ON cabn~atinn = cawnt~atinn AND cabn~adzhl = cawnt~adzhl )
      APPENDING CORRESPONDING FIELDS OF TABLE @et_cawnt
      WHERE cabn~atnam = @iv_characteristic_name
        AND cabn~aennr = @iv_change_number.
    SELECT cabnz~*
      FROM ( cabn INNER JOIN cabnz ON cabn~atinn = cabnz~atinn )
      APPENDING CORRESPONDING FIELDS OF TABLE @et_cabnz
      WHERE cabn~atnam = @iv_characteristic_name
        AND cabn~aennr = @iv_change_number.
    SELECT tcme~*
      FROM ( cabn INNER JOIN tcme ON cabn~atinn = tcme~atinn )
      APPENDING CORRESPONDING FIELDS OF TABLE @et_tcme
      WHERE cabn~atnam = @iv_characteristic_name
        AND cabn~aennr = @iv_change_number.

  ENDMETHOD.
ENDCLASS.