  method IF_SADL_GW_DPC_UTIL~GET_DPC.
    TYPES ty_ZCR_C_GAMES_1 TYPE zcr_c_games ##NEEDED. " reference for where-used list
    TYPES ty_ZCR_C_PLAYERS_2 TYPE zcr_c_players ##NEEDED. " reference for where-used list

    DATA(lv_sadl_xml) =
               |<?xml version="1.0" encoding="utf-16"?>| &
               |<sadl:definition xmlns:sadl="http://sap.com/sap.nw.f.sadl" syntaxVersion="V2" >| &
               | <sadl:dataSource type="CDS" name="A_Player" binding="ZCR_C_PLAYERS" />| &
               | <sadl:dataSource type="CDS" name="A_Games" binding="ZCR_C_GAMES" />| &
               |<sadl:resultSet>| &
               |<sadl:structure name="A_Player" dataSource="A_Player" maxEditMode="RO" >| &
               | <sadl:query name="EntitySetDefault">| &
               | </sadl:query>| &
               | <sadl:attribute name="PLAYERID" binding="PLAYERID" isKey="TRUE" />| &
               | <sadl:attribute name="FIRSTNAME" binding="FIRSTNAME" isKey="FALSE" />| &
               | <sadl:attribute name="LASTNAME" binding="LASTNAME" isKey="FALSE" />| &
               | <sadl:attribute name="GENDER" binding="GENDER" isKey="FALSE" />| &
               | <sadl:attribute name="EMAILADDRESS" binding="EMAILADDRESS" isKey="FALSE" />| &
               | <sadl:attribute name="MOBILENUMBER" binding="MOBILENUMBER" isKey="FALSE" />| &
               | <sadl:attribute name="CREATEDAT" binding="CREATEDAT" isKey="FALSE" />| &
               | <sadl:attribute name="CHANGEDAT" binding="CHANGEDAT" isKey="FALSE" />| &
               | <sadl:attribute name="PASSWORD" binding="PASSWORD" isKey="FALSE" />| &
               |</sadl:structure>| &
               |<sadl:structure name="A_Games" dataSource="A_Games" maxEditMode="RO" >| &
               | <sadl:query name="EntitySetDefault">| &
               | </sadl:query>| &
               | <sadl:attribute name="GAMETYPE" binding="GAMETYPE" isKey="TRUE" />| &
               | <sadl:attribute name="GAMEDESCRIPTION" binding="GAMEDESCRIPTION" isKey="FALSE" />| &
               | <sadl:attribute name="TEAMSIZE" binding="TEAMSIZE" isKey="FALSE" />| &
               |</sadl:structure>| &
               |</sadl:resultSet>| &
               |</sadl:definition>| .
    ro_dpc = cl_sadl_gw_dpc_factory=>create_for_sadl( iv_sadl_xml   = lv_sadl_xml
               iv_timestamp         = 20200725112124
               iv_uuid              = 'ZCR_CLT_COMPETITIONS'
               io_query_control     = me
               io_extension_control = me
               io_context           = me->mo_context ).
  endmethod.