<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@include file="header.jsp" %>

<main>
    <style>
        .col-xs-4 {
            padding: 4px;
        }
    </style>
    <div class="container-fluid">
        <div class="row">
            <div class="col-xs-12">
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