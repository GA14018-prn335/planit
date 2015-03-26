<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@include file="header.jsp" %>

<main>
    <script>
        // This is called with the results from from FB.getLoginStatus().
        function statusChangeCallback(response) {
            console.log('statusChangeCallback');
            console.log(response);
            // The response object is returned with a status field that lets the
            // app know the current login status of the person.
            // Full docs on the response object can be found in the documentation
            // for FB.getLoginStatus().
            if (response.status === 'connected') {
                // Logged into your app and Facebook.
                testAPI();
            } else if (response.status === 'not_authorized') {
                // The person is logged into Facebook, but not your app.
                document.getElementById('status').innerHTML = 'Please log ' +
                        'into this app.';
            } else {
                // The person is not logged into Facebook, so we're not sure if
                // they are logged into this app or not.
                document.getElementById('status').innerHTML = 'Please log ' +
                        'into Facebook.';
            }
        }
        // This function is called when someone finishes with the Login
        // Button.  See the onlogin handler attached to it in the sample
        // code below.
        function checkLoginState() {
            FB.getLoginStatus(function (response) {
                statusChangeCallback(response);
            });
        }
        window.fbAsyncInit = function () {
            FB.init({
                appId: '1780893485469780',
                cookie: true, // enable cookies to allow the server to access 
                // the session
                xfbml: true, // parse social plugins on this page
                version: 'v2.2' // use version 2.2
            });
            // Now that we've initialized the JavaScript SDK, we call 
            // FB.getLoginStatus().  This function gets the state of the
            // person visiting this page and can return one of three states to
            // the callback you provide.  They can be:
            //
            // 1. Logged into your app ('connected')
            // 2. Logged into Facebook, but not your app ('not_authorized')
            // 3. Not logged into Facebook and can't tell if they are logged into
            //    your app or not.
            //
            // These three cases are handled in the callback function.
            FB.getLoginStatus(function (response) {
                statusChangeCallback(response);
            });
        };
        // Load the SDK asynchronously
        (function (d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id))
                return;
            js = d.createElement(s);
            js.id = id;
            js.src = "//connect.facebook.net/en_US/sdk.js";
            fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));
        // Here we run a very simple test of the Graph API after login is
        // successful.  See statusChangeCallback() for when this call is made.
        function testAPI() {
            console.log('Welcome!  Fetching your information.... ');
            FB.api('/me', function (response) {
                console.log('Successful login for: ' + response.name);
                document.getElementById('status').innerHTML =
                        'Thanks for logging in, ' + response.name + '!';
            });
        }
        function logout() {
            FB.logout(function (response) {
                // Person is now logged out
            });
        }
    </script>

    <style>
        .col-xs-4 {
            padding: 4px;
        }
    </style>
    <div class="container-fluid">
        <div class="row">
            <div class="col-xs-12">
                  <!--
  Below we include the Login Button social plugin. This button uses
  the JavaScript SDK to present a graphical Login button that triggers
  the FB.login() function when clicked.
This is the permissions page
https://developers.facebook.com/docs/facebook-login/login-flow-for-web/v2.2
Add 
user_events
when this is approved
<input type ="button" value ="Logout" onclick="logout()"/> //not working
Event info
https://developers.facebook.com/docs/graph-api/reference/v2.2/event
                -->

                <fb:login-button scope="public_profile,email" onlogin="checkLoginState();">
                </fb:login-button>



                <div id="status">
                </div>
                <h1 class="logo">Planit</h1>
                <p class="text-center logo">Local Events Search</p>
                <h2>Find Your Event</h2>
                <form action="event-list.jsp" method="post">
                    <div class="form-group">
                        <select class="btn btn-block btn-default text-center" id="search-date" name="search-date">
                            <%
                                // The date format that is stored as the value
                                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                // The day of the week (separate for the first instance of "Today"
                                SimpleDateFormat dateFormat2 = new SimpleDateFormat("E");
                                // The date itself
                                SimpleDateFormat dateFormat3 = new SimpleDateFormat("dd");

                                Calendar cal = Calendar.getInstance();
                                boolean first = false;

                                for (int i = 0; i < 14; i++) {
                                    // Manupulate a, b, and c in the display to get desired results
                                    String dataBase = (dateFormat.format(cal.getTime()));
                                    String dayOfWeek = (dateFormat2.format(cal.getTime()));
                                    String dateNum = (dateFormat3.format(cal.getTime()));                                  
                                    
                                    // Format the option tag
                                    String optionOpen = "<option value=\"";
                                    String optionClose = "\" >";
                                    String closingTag = "</option>";
                                        
                                    // If it is the first day, write "Today" instead of the day of the week
                                    if (first == false) {                    
                                        out.write(optionOpen + dataBase + optionClose + "Today " + dateNum + closingTag);
                                        first = true;
                                    } else {
                                        out.write(optionOpen + dataBase + optionClose + dayOfWeek + " " + dateNum + closingTag);
                                    }
                                        
                                    // Add to go to the next day
                                    cal.add(Calendar.DATE, 1);
                                }
                            %>
                            
                        </select><br>
                    </div>
                    <h2>Filter By:</h2>
                    <div class="col-xs-4">
                        <input class="hidden" type="radio" name="filter" id="time" value="time">
                        <label class="btn btn-block btn-default btn-change-ios" for="time">Time</label><br>
                    </div>

                    <div class="col-xs-4">
                        <input class="hidden" type="radio" name="filter" id="cost" value="cost">
                        <label class="btn btn-block btn-default disabled" for="cost">Cost</label><br>
                    </div>

                    <div class="col-xs-4">
                        <input class="hidden" type="radio" name="filter" id="location" value="location">
                        <label class="btn btn-block btn-default disabled" for="location">Location</label><br>
                    </div>

                    <div class="clearfix"></div>
<!--                        <input class="event-input" type="date" id="search-date" name="search-date"><br>-->
                    <br>
                    <input type="submit" class="btn btn-primary" value="Find Events">
                </form>



            </div>
        </div>
    </div>
</div>
</main>