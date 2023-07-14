// String base_url = 'http://192.168.43.183:35467';
String base_url = 'http://192.168.145.182:8000';
// String base_url = 'http://192.168.199.182:8000';


//login_url
Uri loginUrl = Uri.parse("$base_url/api/accounts/login/");

//user_url
Uri userUrl = Uri.parse("$base_url/api/accounts/user/");

//week_dates url
Uri weekDatesUrl = Uri.parse("$base_url/api/week_dates/");

//student details
Uri stdDetailsUrl = Uri.parse("$base_url/api/students/");

//industry_student
Uri indStdListUrl = Uri.parse("$base_url/api/industry_supervisor/students/");

//industry_profile
Uri indProfile = Uri.parse("$base_url/api/industry_supervisor/profile/");

//industry_logbook
Uri entryDateUrl = Uri.parse("$base_url/api/entry_date/");

//weekly comment - get or create
Uri wkCommentUrl = Uri.parse("$base_url/api/week_comment/");

//update entry with date
Uri updateEntryUrl(int id) {
  return Uri.parse("$base_url/api/week_comment/$id/update/");
}

//placement centre URL
Uri placementCentreUri =
    Uri.parse("$base_url/api/industry_supervisor/add-placement/");

// School supervisor URLS
//Profile
Uri schProfileUrl = Uri.parse("$base_url/api/school_supervisor/profile/");

// get students
Uri schStdListUrl = Uri.parse("$base_url/api/school_supervisor/students/");

//Student URLS
Uri logEntryUrl = Uri.parse("$base_url/api/logbook_entry/");
