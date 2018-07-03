import java.util.Date;

public class Usuario {

    private String name  = null;
    private int flagName = 0;

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Mensajes createMessage(String msj) {

        Mensajes newMessage = new Mensajes();
        Date date           = new Date();
        String[] arr        = msj.split(" ");

        String timeStamp    = String.format("[ %tD %tR ]", date, date);

        if(flagName == 1) {
            setName(msj);
        }

        if(arr[0].equals("!beginDialog")) {
            flagName = 0;
        }

        newMessage.setUser("Usuario");
        newMessage.setDateTime(timeStamp);
        newMessage.setMessage(msj);
        flagName++;
        return newMessage;
    }
}
