implementation abstract;
define behavior for I_ClfnClassForKeyDateTP
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
  }

define behavior for I_ClfnClassDescForKeyDateTP
late numbering in place
etag ClassLastChangedDateTime
  {
    create;
    update;
//    delete;
  }

define behavior for I_ClfnClassKeywordForKeyDateTP
late numbering in place
etag ClassLastChangedDateTime
  {
    create;
    update;
    delete;
  }

define behavior for I_ClfnClassTextForKeyDateTP
late numbering in place
etag ClassLastChangedDateTime
  {
    create;
    update;
    delete;
  }

define behavior for I_ClfnClassCharcForKeyDateTP
late numbering in place
etag ClassLastChangedDateTime
  {
    create;
    update;
    delete;
  }