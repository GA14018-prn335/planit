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
                <h2>Create Your Event</h2>
                <form action="CreateEvent" method="post">                  
                    <div class="clearfix"></div>
                       Title:<input class="event-input" name="title"><br>
                       Contact Information:<input class="event-input" name="contactInfo"><br>
                       Price:<input class="event-input" name="price"><br>
                       Date:<input class="event-input" name="date"><br>
                       Start Time:<input class="event-input" name="startTime"><br>
                       End Time:<input class="event-input" name="endTime"><br>
                       Location:<textarea class="event-input" name="location"></textarea><br>
                       Description:<textarea class="event-input" name="description"></textarea><br>
                    <br>
                    <input type="submit" class="btn btn-primary" value="Create Event">
                </form>
            </div>
        </div>
    </div>
</div>
</main>
