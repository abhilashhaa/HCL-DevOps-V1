implementation unmanaged in class cl_ngc_bil_clf_tp unique;
define behavior for I_ClfnObjectTP alias Object
lock master
{
  association _ObjectClass abbreviation _OClass { create; }
  association _ObjectCharc abbreviation _OCharc { }

  action SetRefData parameter D_ClfnObjectRefDataP;

  static action CheckConsistency;
}

define behavior for I_ClfnObjectClassTP alias ObjectClass
lock dependent ( ClfnObjectID = ClfnObjectID ClfnObjectTable = ClfnObjectTable )
{
  create;
  delete;

  field ( mandatory ) ClfnObjectID;
  field ( mandatory ) ClfnObjectTable;
  field ( mandatory ) ClassInternalID;
  field ( mandatory ) ClassType;

  field ( read only ) ClfnObjectInternalID;
//  field ( read only ) LastChangeDateTime;
}

define behavior for I_ClfnObjectCharcTP alias ObjectCharc
{
  association _ObjectCharcValue abbreviation _OCharcVal { create; }
}

define behavior for I_ClfnObjectCharcValueTP alias ObjectCharcValue
lock dependent ( ClfnObjectID = ClfnObjectID ClfnObjectTable = ClfnObjectTable )
{
  create;
  update;
  delete;

  field ( read only ) CharcValuePositionNumber;

  field ( mandatory ) ClfnObjectID;
  field ( mandatory ) ClfnObjectTable;
  field ( mandatory ) CharcInternalID;

  field ( read only ) ClfnObjectInternalID;
  field ( read only ) CharacteristicAuthor;
//  field ( read only ) LastChangeDateTime;
}