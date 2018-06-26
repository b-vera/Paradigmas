import java.util.Date;

public class Usuario {

    private String name = null;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Mensajes createMessage(String msj) {

        Mensajes newMessage = new Mensajes();
        Date date           = new Date();

        String timeStamp = String.format("[ %tD %tR ]", date, date);

        newMessage.setUser("Usuario");
        newMessage.setDateTime(timeStamp);
        newMessage.setMessage(msj);
        return newMessage;
    }
}
