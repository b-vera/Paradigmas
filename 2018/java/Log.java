import java.util.Date;
import java.util.ArrayList;
import java.util.Scanner;
import java.io.*;

public class Log {

    private String logTimeStamp = null;

    private void logDataTime() {
        Date date           = new Date();
        String logTimeStamp = String.format("%tY"+"-"+"%tm"+"-"+"%td"+"_"+"%tH"+"-"+"%tM"+".log", date, date, date, date, date);
        this.logTimeStamp   = logTimeStamp;
    }

    public void loadLog(String fileName) {
        ArrayList<String> message = new ArrayList<String>();

        File archivo = null;
        FileReader fr = null;
        BufferedReader br = null;
        String linea;
        try {
            fr = new FileReader (fileName);
            br = new BufferedReader(fr);

            String aux = "";
            while(aux != null){
                aux = br.readLine();
                if (aux == null) {
                    break;
                }
                message.add(aux);
            }
            System.out.println(message);
            System.out.println("> Se ha cargado el Log <");
            fr.close();


        }
        catch(Exception e){
            e.printStackTrace();
        }
    }

    public void saveLog() {
        logDataTime();
        File archivo = new File(logTimeStamp);
        BufferedWriter bw;
		try{
			bw = new BufferedWriter(new FileWriter(archivo));
			bw.write("Palabras en la Sopa:\n");
            System.out.println("> Se ha guardado el Log <");
			bw.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
    }

}
