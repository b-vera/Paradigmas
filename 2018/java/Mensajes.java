public class Mensajes {

    private String user     = null;
    private String dateTime = null;
    private String message  = null;

    public void setDateTime(String dt) {
        this.dateTime = dt;
    }

    public void setMessage(String msj) {
        this.message = msj;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getDateTime() {
        return dateTime;
    }

    public String getMessage() {
        return message;
    }

    public String getUser() {
        return user;
    }

    public String printMessage() {
        String msj = dateTime + " " + user + ": " + message;
        return msj;
    }
}
