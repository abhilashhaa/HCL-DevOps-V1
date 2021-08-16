implementation abstract;
define behavior for I_ClfnCharcForKeyDateTP
late numbering in place
etag CharcLastChangedDateTime
  {
    create;
    update;
    delete;

    association _CharacteristicDesc abbreviation CharcDesc { create; }
    association _CharacteristicRestriction abbreviation CharcRestr { create; }
    association _CharacteristicReference abbreviation CharcRef { create; }
    association _CharacteristicValue abbreviation CharcValue { create; }
  }

define behavior for I_ClfnCharcDescForKeyDateTP
late numbering in place
etag CharcLastChangedDateTime
  {
    create;
    update;
    delete;
  }

define behavior for I_ClfnCharcRstrcnForKeyDateTP
late numbering in place
etag CharcLastChangedDateTime
  {
    create;
    delete;
  }

define behavior for I_ClfnCharcRefForKeyDateTP
late numbering in place
etag CharcLastChangedDateTime
  {
    create;
    delete;
  }

define behavior for I_ClfnCharcValForKeyDateTP
late numbering in place
etag CharcLastChangedDateTime
  {
    create;
    update;
    delete;

    association _CharcValueDesc abbreviation ChrValDesc { create; }
  }

define behavior for I_ClfnCharcValDescForKeyDateTP
late numbering in place
etag CharcLastChangedDateTime
  {
    create;
    update;
    delete;
  }