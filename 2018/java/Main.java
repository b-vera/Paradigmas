import java.util.Scanner;
import java.util.ArrayList;

public class Main {

    public static void main(String[] args) {

        Usuario user = new Usuario();
        Chatbot bot  = new Chatbot();
        Log     log  = new Log();
        Scanner sc   = new Scanner(System.in);

        ArrayList<Mensajes> preLog = new ArrayList<Mensajes>();

        //  indica inicio o fin del dialogo
        int flag     = 0;
        int shutDown = 0;

        // carga de respuestas a bot
        bot.answers();

        //mensaje de bienvenida
        System.out.println(bot.getBienvenida());

        while (shutDown == 0) {
            String input, seed, fileName;
            int    rateBot, rateUser;
            char   firstChar;

            System.out.print("-> ");

            input        = sc.nextLine();
            String[] arr = input.split(" ");

            // salida del programa
            if (input.equals(".")) {
                shutDown = 1;
                break;
            }

            switch(arr[0]) {

                case "!beginDialog" :
                    // seed = sc.nextLine();
                    preLog.clear();
                    flag = 1;
                    break;

                case "!endDialog" :
                    flag = 0;
                    Mensajes msjChatbot = bot.createMessage(user.getName(),input);
                    preLog.add(msjChatbot);
                    break;

                case "!saveLog" :
                    log.saveLog(preLog);
                    break;

                case "!loadLog" :
                    // fileName = sc.nextLine();
                    // log.loadLog(fileName);
                    break;

                case "!rate" :
                    // rateBot  = sc.nextInt();
                    // rateUser = sc.nextInt();
                    // sc.nextLine();
                    break;
            }

            if (flag == 1) {

                // entrada nombre del usuario
                Mensajes msjUser    = user.createMessage(input);
                Mensajes msjChatbot = bot.createMessage(user.getName(),input);
                preLog.add(msjUser);
                preLog.add(msjChatbot);

            }
        }

        // for (int i = 0; i < preLog.size(); i++) {
        //     preLog.get(i).printMessage();
        // }
    }
}
