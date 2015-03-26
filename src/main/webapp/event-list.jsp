<%@page import="java.util.Calendar"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ include file="header.jsp" %>

<main>
    <script>
        $().ready(function () {
            $('#eventDetails').hide();

            $('#search-date').change(function () {
                $('#changeDate').click();
            });

            $('div.event-list').click(function () {
                $('#eventList').hide('slide', {direction: 'left'});
                $('#eventDetails').show('slide', {direction: 'right'});

                var title = $(this).find('.long-title').text();
                var startTime = $(this).find('.start-time').text();
                var endTime = $(this).find('.end-time').text();
                var description = $(this).find('.long-description').text();
                var img = $(this).find('.img-responsive').prop('src');
                var location = $(this).find('.event-list-location').text();

                $('#eventDetails').find('.title').text(title);
                $('#eventDetails').find('.start-time').text(startTime);
                $('#eventDetails').find('.end-time').text(endTime);
                $('#eventDetails').find('.description').text(description);
                $('#eventDetails').find('.img-responsive').prop('src', img);
                $('#eventDetails').find('.location').text(location);
            });

            $('#back').click(function () {
                $('#eventDetails').hide('slide', {direction: 'right'});
                $('#eventList').show('slide', {direction: 'right'});
            });

        });

    </script>
    <style>
        .col-xs-4 {
            padding: 4px;
        }
        h3 {
            display: inline-block;
            width: 49%;
        }

    </style>

    <div class="container-fluid" id="eventDetails">
        <div class='row'>
            <div class='col-xs-12'>
                <button class='btn btn-block btn-primary' id='back'>BACK</button><br>
                <h1 class='title'>Event Title</h1>
                <img class='img-responsive' src='http://eventsbengaluru.com/blog/wp-content/uploads/2011/03/event-6.jpg'>
                <h2 class='date'><?php
                    echo date_format($selectedDate, 'D, M jS');
                    ?></h2>
                <h3><span class='start-time'>3pm</span> to <span class='end-time'>8pm</span></h3>
                <h4 class="location-label">Location:</h4>
                <h4 class="location"></h4>
                <p class='description'>This is a longer event description. It should be roughly under 100 characters in length. It should discuss what is taking place at the event and provide meaningful information.</p>
            </div>
        </div>
    </div>
    <div class="container-fluid" id="eventList">
        <div class="row">
            <div class="col-xs-12">
                <h1 class="logo">Planit</h1>
                <p class="logo">Local Events Search</p>
                <form action="event-list.php" method="post">
                    <div class="form-group">
                        <h2>Showing Events For:</h2>
                        <select class="btn btn-block btn-default form-control" id="search-date" name="search-date">
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
                    <input type="submit" class="hidden" id="changeDate">
                </form>
 <%
                
   // JDBC driver name and database URL
   String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
   String DB_URL = "jdbc:mysql://localhost:3306/";
   String dbName = "planit";
   //  Database credentials
   String USER = "root";
   String PASS = "root";
   
   Connection conn = null;
   Statement stmt = null;
                
    try{
      //STEP 2: Register JDBC driver
      Class.forName("com.mysql.jdbc.Driver");
      conn = DriverManager.getConnection(DB_URL+dbName,USER,PASS);

                String sql = "SELECT * FROM event WHERE `Date`='$selectedDate_string' ORDER BY `Date` ASC";
                ResultSet rs = stmt.executeQuery(sql);

                    while(rs.next()){
                    String title = rs.getString("Title");
                    String description = rs.getString("Description");
                    String startTime = rs.getString("StartTime"); //ASH
                    String endTime = rs.getString("EndTime"); //ASH
                    String img = rs.getString("Picture");
                    String location = rs.getString("Location");
                    
                    //
                    // ASH
                    // 
                    
                    String shortTitle = "";
                    if (title.length() > 20) {
                        shortTitle = title.substring(0, 17) + "...";                              
                    } else {
                      shortTitle = title;
                    }

                    String shortDescription = "";
                    if (description.length() > 40) {
                       shortDescription = description.substring(0, 37) + "...";
                    } else {
                       shortDescription = description;
                    }
                    
                    //
                    // END 
                    //

                    out.write("<div class='col-xs-12 col-md-6 col-lg-4 event-list'>");
                    out.write("<div class='event-list-img-container col-xs-4'>");
                    out.write("<img class='img-responsive' src='" + img + "'>" );
                    out.write("</div>");
                    out.write("<div class='col-xs-8'>" );
                    out.write( "<h2 class='event-list title'>" + title +"</h2>" );
                    out.write("<p class='hidden long-title'>"+ shortTitle + "</p>");
                    out.write("<div class='event-list-time-container col-xs-5 event-list-content'>");
                    out.write("<p class='event-list-time start-time'>" + startTime +"</p>" ); //ASH
                    out.write("<p class='event-list-time end-time'>" + endTime + "</p>"); //ASH
                    out.write("</div>");
                    out.write("<div class='event-list-content col-xs-7'>");
                    out.write("<p class='event-list-location'>" + location + "</p>"); //ASH
                    out.write("<p class='hidden long-description'>" + shortDescription + "</p>"); //ASH
                    out.write("</div>");
                    out.write("</div></div>");
                }     //STEP 6: Clean-up environment
      rs.close();
      stmt.close();
      conn.close();
   }catch(SQLException se){
      //Handle errors for JDBC
      se.printStackTrace();
   }catch(Exception e){
      //Handle errors for Class.forName
      e.printStackTrace();
   }finally{
      //finally block used to close resources
      try{
         if(stmt!=null)
            stmt.close();
      }catch(SQLException se2){
      }// nothing we can do
      try{
         if(conn!=null)
            conn.close();
      }catch(SQLException se){
         se.printStackTrace();
      }//end finally try
   }//end try
                %>
            </div>
        </div>
    </div>
</main>
    <footer></footer>
    </body>
</html>