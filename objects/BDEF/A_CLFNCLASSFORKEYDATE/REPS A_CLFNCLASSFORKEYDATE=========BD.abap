implementation unmanaged in class cl_ngc_bil_cls_api unique;
define behavior for A_ClfnClassForKeyDate
late numbering in place
etag ClassLastChangedDateTime

  {
    create;
    update;
    delete;

    association _ClassDescription abbreviation _ClassDesc { create; }
    association _ClassKeyword abbreviation ClassKeyw { create; }
    association _ClassText abbreviation ClassText { create; }
    association _ClassCharacteristic abbreviation ClassCharc { create; }

//    field ( read only ) ClassType;
    field ( read only ) ClassTypeName;
    field ( read only ) ClassGroupName;
    field ( read only ) ClassStatusName;
    field ( read only ) CreationDate;
    field ( read only ) LastChangeDate;
    field ( read only ) ClassLastChangedDateTime;
    field ( read only ) KeyDate;
  }

define behavior for A_ClfnClassDescForKeyDate
late numbering in place
etag ClassLastChangedDateTime
  {
    create;
    update;
//    delete;

    field ( read only ) ClassLastChangedDateTime;
    field ( read only ) KeyDate;
  }

define behavior for A_ClfnClassKeywordForKeyDate
late numbering in place
etag ClassLastChangedDateTime
  {
    create;
    update;
    delete;

    field ( read only ) ClassLastChangedDateTime;
    field ( read only ) KeyDate;
  }

define behavior for A_ClfnClassTextForKeyDate
late numbering in place
etag ClassLastChangedDateTime
  {
    create;
    update;
    delete;

    field ( read only ) ClassLastChangedDateTime;
    field ( read only ) KeyDate;
  }

define behavior for A_ClfnClassCharcForKeyDate
late numbering in place
etag ClassLastChangedDateTime
  {
    create;
    update;
    delete;

//    field ( read only ) Characteristic;
    field ( read only ) CharcPositionNumber;
    field ( read only ) CharcIsProposalRelevant;
    field ( read only ) ClassLastChangedDateTime;
    field ( read only ) KeyDate;
  }