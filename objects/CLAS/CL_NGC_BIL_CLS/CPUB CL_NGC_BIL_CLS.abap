class CL_NGC_BIL_CLS definition
  public
  final
  create private

  global friends CL_NGC_BIL_FACTORY
                 TC_NGC_BIL_CLS .

public section.

  interfaces IF_NGC_BIL_CLS .
  interfaces IF_NGC_BIL_CLS_TRANSACTIONAL .

  types:
    BEGIN OF lty_clfn_class_cds ,
        s_class        TYPE i_clfnclassforkeydatetp,
        s_charc        TYPE i_clfncharcforkeydatetp,
        s_charcrstrcn  TYPE i_clfncharcforkeydatetp,
        s_classdesc    TYPE i_clfnclassdescforkeydatetp,
        s_classkeyword TYPE i_clfnclasskeywordforkeydatetp,
        s_classtext    TYPE i_clfnclasstextforkeydatetp,
        s_classcharc   TYPE i_clfnclasscharcforkeydatetp,
        t_class        TYPE STANDARD TABLE OF i_clfnclassforkeydatetp WITH DEFAULT KEY,
        t_classdesc    TYPE STANDARD TABLE OF i_clfnclassdescforkeydatetp     WITH DEFAULT KEY,
        t_classkeyword TYPE STANDARD TABLE OF i_clfnclasskeywordforkeydatetp       WITH DEFAULT KEY,
        t_classtext    TYPE STANDARD TABLE OF i_clfnclasstextforkeydatetp    WITH DEFAULT KEY,
        t_classcharc   TYPE STANDARD TABLE OF i_clfnclasscharcforkeydatetp   WITH DEFAULT KEY,
        t_classtext_id TYPE STANDARD TABLE OF tclx WITH DEFAULT KEY,
        t_charc_key    TYPE ngct_core_charc_key,
        t_charc        TYPE STANDARD TABLE OF i_clfncharcforkeydatetp WITH DEFAULT KEY,
        t_charcrstrcn  TYPE STANDARD TABLE OF i_clfncharcrstrcnforkeydatetp WITH DEFAULT KEY,
        t_charc_range  TYPE RANGE OF atinn,
        t_class_range  TYPE RANGE OF clint,
      END OF lty_clfn_class_cds .