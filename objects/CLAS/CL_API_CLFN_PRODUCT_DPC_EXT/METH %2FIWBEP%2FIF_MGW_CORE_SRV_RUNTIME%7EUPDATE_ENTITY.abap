  METHOD /iwbep/if_mgw_core_srv_runtime~update_entity.

    RAISE EXCEPTION TYPE /iwbep/cx_mgw_tech_exception
      EXPORTING
        textid      = /iwbep/cx_mgw_tech_exception=>operation_not_supported
        operation   = 'update'
        entity_type = iv_entity_name.

  ENDMETHOD.