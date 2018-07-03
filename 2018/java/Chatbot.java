import java.util.Hashtable;
import java.util.Iterator;
import java.util.Date;
import java.util.Set;

public class Chatbot {

    Hashtable<String, String>  palabraRespuesta = new Hashtable<String, String>();
    private String bienvenida = null;
    private String despedida  = null;
    private int rateUser;
    private int rateChatbot;
    private int flagName = 0;

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

    public Mensajes createMessage(String nameUser,String msjUser) {

        Mensajes newMessage  = new Mensajes();
        Date date            = new Date();

        String str           = null;
        String msj           = null;
        String timeStamp     = String.format("[ %tD %tR ]", date, date);
        String[] arr         = msjUser.split(" ");
        Set<String> keys     = palabraRespuesta.keySet();
        Iterator<String> itr = keys.iterator();

        if(flagName == 1) {
            msj = "¿en que puedo ayudarte " + nameUser + "?";
            flagName--;
        }

        if(arr[0].equals("!beginDialog")) {
            msj = "¿Me podrias decir tu nombre?";
            flagName++;
        }

        if(arr[0].equals("!endDialog")) {
            msj = getDespedida();
        }

        for (Integer i = 0; i < arr.length; i++) {

            while (itr.hasNext()) {
               str = itr.next();

               if(str.equals(arr[i])) {
                   msj = palabraRespuesta.get(str);
               }
            }
            itr = keys.iterator();
        }

        if(msj == null) {
            msj = "no he entendido tu pregunta, ¿podrias Repetirmela?";
        }

        System.out.println("-> chatbot: " + msj);
        newMessage.setUser("chatbot");
        newMessage.setDateTime(timeStamp);
        newMessage.setMessage(msj);

        return newMessage;
    }
}
