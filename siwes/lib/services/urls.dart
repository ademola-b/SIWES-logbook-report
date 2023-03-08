String base_url = 'http://192.168.43.130:8000';

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

//industry_logbook
Uri entryDateUrl = Uri.parse("$base_url/api/entry_date/");
