private section.

  methods AUTH_CHECK
    importing
      !IV_CLASSCLASSFCTNAUTHGRP type BGRKL
      !IV_OBJECT_STATE type NGC_CORE_OBJECT_STATE
    returning
      value(RV_HAS_AUTH) type BOOLE_D .