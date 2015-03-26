


import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Ashlie
 */
public class Event {
    // Foreign keys //
    int eventId;
    int userId;
    
    // Others //
    String contactInfo;
    String location;
    String price;
    String title;
    String description;
    String startTime;
    String endTime;
    String date;
    
    Event() {
        
        // Do an alphabetic sort when sorting by time (do military time when you sort) 
        //  d.setDate();
    }

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getContactInfo() {
        return contactInfo;
    }

    public void setContactInfo(String contactInfo) {
        this.contactInfo = contactInfo;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
    
    
/*    void getDate() {

        Calendar c = Calendar.getInstance();
        // http://www.tutorialspoint.com/java/java_date_time.htm
        // If pm is found && not 12. time + 12;
        c.set(9, 0);
        SimpleDateFormat ft = new SimpleDateFormat ("hh:mm a");

       // System.out.println("Current Date: " + ft.format(dNow));
    }*/
    // picture
    
}
