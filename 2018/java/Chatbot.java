import java.util.Hashtable;
import java.util.Date;

public class Chatbot {

    Hashtable<String, String>  palabraRespuesta = new Hashtable<String, String>();
    private String bienvenida = null;
    private String despedida  = null;
    private int rateUser;
    private int rateChatbot;

    public void answers() {

        bienvenida = "Hola! Bienvenido a su asistente de salud virtual, un chatbot creado con el objetivo de poder ayudarte sobre tus dudas rescpecto a tu salud :D";
        despedida  = "Hasta Pronto :) espero volvamos a conversar en otro momento";

        palabraRespuesta.put("calor","es probable que tengas fiebre, te recomiendo usar paños frios para reducir la temperatura");
        palabraRespuesta.put("cansado","por lo que me cuentas puede que te falten vitaminas y minerales en tu cuerpo");
        palabraRespuesta.put("mocos","por lo que me cuentas puedo decir que te encuentras con un resfriado comun, por lo que necesitas descansar, hidratarte y un tapsin en la noche");
        palabraRespuesta.put("estomago","es probable que tengas gastroenteritis, asi que tendras que cuidar tu alimentacion");
        palabraRespuesta.put("no","Me alegra haber resuelto tus dudas :D");
    }

    public String getBienvenida() {
        return bienvenida;
    }

    public String getDespedida() {
        return despedida;
    }

    public Mensajes createMessage(String msjUser) {

        Mensajes newMessage = new Mensajes();
        Date date           = new Date();

        String msj       = null;
        String timeStamp = String.format("[ %tD %tR ]", date, date);
        String[] arr     = msjUser.split(" ");

        // realizar interseccion entre palabras
        for (String token : arr) {
            System.out.println(token);
        }

        newMessage.setUser("chatbot");
        newMessage.setDateTime(timeStamp);
        newMessage.setMessage(msj);
        return newMessage;
    }
}
