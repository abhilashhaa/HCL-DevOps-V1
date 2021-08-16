class CL_NGC_BIL_CHR definition
  public
  final
  create private

  global friends CL_NGC_BIL_FACTORY
                 TC_NGC_BIL_CHR .

public section.

  interfaces IF_NGC_BIL_CHR .
  interfaces IF_NGC_BIL_CHR_TRANSACTIONAL .

  types:
    BEGIN OF lty_clfn_charc_cds ,
        s_charc                   TYPE i_clfncharcforkeydatetp,
        s_charc_incl_del          TYPE i_clfncharacteristic,
        s_charcdesc               TYPE i_clfncharcdescforkeydatetp,
        s_charcdesc_incl_del      TYPE i_clfncharcdesc,
        s_charcref                TYPE i_clfncharcrefforkeydatetp,
        s_charcrstrcn             TYPE i_clfncharcrstrcnforkeydatetp,
        s_charcvalue              TYPE i_clfncharcvalforkeydatetp,
        s_charcvalue_incl_del     TYPE i_clfncharcvalue,
        s_charcvaluedesc          TYPE i_clfncharcvaldescforkeydatetp,
        t_charc                   TYPE STANDARD TABLE OF i_clfncharcforkeydatetp        WITH DEFAULT KEY,
        t_charcdesc               TYPE STANDARD TABLE OF i_clfncharcdescforkeydatetp    WITH DEFAULT KEY,
        t_charcdesc_incl_del      TYPE STANDARD TABLE OF i_clfncharcdesc                WITH DEFAULT KEY,
        t_charcref                TYPE STANDARD TABLE OF i_clfncharcrefforkeydatetp     WITH DEFAULT KEY,
        t_charcref_incl_del       TYPE STANDARD TABLE OF i_clfncharcreference           WITH DEFAULT KEY,
        t_charcrstrcn             TYPE STANDARD TABLE OF i_clfncharcrstrcnforkeydatetp  WITH DEFAULT KEY,
        t_charcrstrcn_incl_del    TYPE STANDARD TABLE OF i_clfncharcrestriction         WITH DEFAULT KEY,
        t_charcvalue              TYPE STANDARD TABLE OF i_clfncharcvalforkeydatetp     WITH DEFAULT KEY,
        t_charcvalue_incl_del     TYPE STANDARD TABLE OF i_clfncharcvalue               WITH DEFAULT KEY,
        t_charcvaluedesc          TYPE STANDARD TABLE OF i_clfncharcvaldescforkeydatetp WITH DEFAULT KEY,
        t_charcvaluedesc_incl_del TYPE STANDARD TABLE OF i_clfncharcvaluedesc           WITH DEFAULT KEY,
      END OF lty_clfn_charc_cds .